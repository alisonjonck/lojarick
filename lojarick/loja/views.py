# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.template import RequestContext
from models import Instrumento, Tipo, Parceiro, TipoCaracteristica, InstrumentoCaracteristica
from json import dumps
from django.views.decorators.csrf import csrf_exempt
from django.utils import simplejson
from django.http import HttpResponse
from django.db import models


def index(request):
    parceiros = Parceiro.objects.all()
    tipos = Tipo.objects.all()
    instrumentos = InstrumentoDTO.objects.raw("select   li.id as id,    li.nome as nome,    lt.nome as tipo,    lf.nome as fabricante,  li.preco as preco from loja_instrumento li left join loja_tipo lt on lt.id = li.tipo_id left join loja_fabricante lf on lf.id = li.fabricante_id")
    return render_to_response('index.html', locals(), context_instance=RequestContext(request))


@csrf_exempt
def gerar_form_busca(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        tipo_id = request.POST["tipo"]
        caracteristicas = TipoCaracteristica.objects.filter(tipo=tipo_id)

        form_busca = "<form action='/buscar/' method='post'><table><tr>"
        form_busca += "<td colspan=2><label for='nome' style='font-weight: bold; color: #3a87ad;'>Modelo</label>"
        #INPUT HIDDEN COM O ID DO TIPO
        form_busca += "<input type='hidden' value='"+ tipo_id +"' style='width:428px;' name='tipo'>"
        form_busca += "<input type='text' style='width:428px;' name='nome'></td>"
        form_busca += "<td><label for='fabricante' style='font-weight: bold; color: #3a87ad;'>Fabricante</label>"
        form_busca += "<input type='text' name='fabricante'></td>"
        form_busca += "<td><label for='preco' style='font-weight: bold; color: #3a87ad;'>Pre&ccedil;o</label>"
        form_busca += "<div class='input-prepend input-append'><span class='add-on'>R$</span><input type='text' name='preco'></div></td>"
        form_busca += "</td></tr><tr>"

        contador = 0
        for caract in caracteristicas:
            if contador >= 4:
                form_busca += "</tr><tr>"
                contador = 0

            form_busca += "<td>"
            form_busca += "<label for='"
            form_busca += str(caract.id) + "' style='font-weight: bold; color: #3a87ad;'>"
            form_busca += caract.nome + "</label>"
            if caract.possui_relacionamento:
                form_busca += "<select name='" + str(caract.id) + "'>"
                form_busca += "<option value="">&nbsp;</option>"
                for aux in TabelaRelacionamento.objects.raw('SELECT id, nome FROM ' + caract.tabela_relacionamento):
                    form_busca += "<option value='" + str(aux.id) + "'>" + aux.nome + "</option>"
                form_busca += "</select>"
            else:
                form_busca += "<input " + caract.tipo_campo.mascara + " name='"
                form_busca += str(caract.id) + "'>"

            form_busca += "</td>"
            contador += 1

        form_busca += "<td><input type='submit' class='btn title_black' value = 'Buscar' style='height: 48px;width: 90px;margin-left: 5px;'></td>"
        form_busca += "</tr></table></form>"
        data = simplejson.dumps(form_busca)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")


class TabelaRelacionamento(models.Model):
    nome = models.CharField(max_length=100)

    def __unicode__(self):
        return self.nome

class InstrumentoDTO(models.Model):
    nome = models.CharField(max_length=100)
    tipo = models.CharField(max_length=100)
    fabricante = models.CharField(max_length=100)
    preco = models.DecimalField(max_digits=11, decimal_places=2)

    def __unicode__(self):
        return self.nome

@csrf_exempt
def ver_instrumento(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        instrumento_id = request.POST["instrumento"]
        instrumento = Instrumento.objects.get(pk=instrumento_id)
        caracteristicas = InstrumentoCaracteristica.objects.filter(instrumento=instrumento_id)
        grid = "<table><tr><td>"
        if instrumento.foto:
            grid += "<img src='" + instrumento.foto.url + "' width='250' style='border: 1px solid;'/>" + "</td><td>&nbsp;</td><td>"

        grid += "<p>Modelo: " + instrumento.nome
        grid += "</p><p>Tipo: " + instrumento.tipo.nome
        grid += "</p><p>Fabricante: " + instrumento.fabricante.nome
        grid += "</p><p>Pre&ccedil;o: R$" + str(instrumento.preco) + "</p>"

        for caract in caracteristicas:
            grid += "<p>" + caract.tipo_caracteristica.nome + ": " + caract.valor + "</p>"

        grid += "</td></tr><tr><td colspan=3>"
        grid += "<a style='float:right;' class='btn btn-primary' href=''> Voltar </a></td></tr></table>"

        data = simplejson.dumps(grid)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")

@csrf_exempt
def buscar(request):
    if request.method == "POST":
        tipo_id = request.POST["tipo"]

        nome = request.POST["nome"]
        fabricante = request.POST["fabricante"]
        preco = request.POST["preco"]

        caracteristicas = []

        for caracteristica in TipoCaracteristica.objects.filter(tipo = tipo_id):
            caracteristicas.append([ caracteristica.id ,request.POST[str(caracteristica.id)]])

        parceiros = Parceiro.objects.all()
        tipos = Tipo.objects.all()
    

        consulta = " select li.id as id, li.nome as nome,    lt.nome as tipo,    lf.nome as fabricante,  li.preco as preco from loja_instrumento li left join loja_tipo lt on lt.id = li.tipo_id left join loja_fabricante lf on lf.id = li.fabricante_id left join loja_instrumentocaracteristica lic on lic.instrumento_id = li.id "
        consulta += " where "

        consulta += " ( li.tipo_id = " + str(tipo_id) + " ) "

        consulta += " and ( upper(li.nome) like upper(concat('%%', '" + nome + "', '%%')) or "
        if nome == '':
            consulta += 'null'
        else:
            consulta += "'" + nome + "'"
        consulta += " is null) "
        

        consulta += " and ( upper(lf.nome) like upper(concat('%%', '" + fabricante + "', '%%')) or "
        if fabricante == '':
            consulta += 'null'
        else:
            consulta += "'" + fabricante + "'"
        consulta += " is null) "


        consulta += " and ( li.preco = '" + preco + "' or "
        if preco == '':
            consulta += 'null'
        else:
            consulta += "'" + preco + "'"
        consulta += " is null) "

        for caracteristica in caracteristicas:
            consulta += " and ( (lic.tipo_caracteristica_id = " + str(caracteristica[0]) + " and lic.valor = "
            
            if not caracteristica[1]:
                consulta += "''"
            else:
                consulta += caracteristica[1]

            consulta += ") or ("
            if caracteristica[1] == '':
                consulta += 'null'
            else:
                consulta += "'" + caracteristica[1] + "'"
            consulta += " is null) ) "

        consulta += " group by 1,2,3,4,5 "

        instrumentos = InstrumentoDTO.objects.raw(consulta)
        #instrumentos = Instrumento.objects.all()

    return render_to_response('index.html', locals(), context_instance=RequestContext(request))














