# coding: utf-8
from django.shortcuts import render_to_response
from django.template import RequestContext
from models import Instrumento, Tipo, Parceiro, TipoCaracteristica, InstrumentoCaracteristica, Fabricante
from django.views.decorators.csrf import csrf_exempt
from django.utils import simplejson
from django.http import HttpResponse
from django.db import models
from forms import InstrumentoForm
from decimal import Decimal
from hashlib import md5
from datetime import datetime


def index(request):
    fabricantes = Fabricante.objects.all()

    parceiros = Parceiro.objects.all()
    tipos = Tipo.objects.all()
    instrumentos = InstrumentoDTO.objects.raw("select   li.id as id,    li.nome as nome,    lt.nome as tipo,    lf.nome as fabricante,  li.preco as preco from loja_instrumento li left join loja_tipo lt on lt.id = li.tipo_id left join loja_fabricante lf on lf.id = li.fabricante_id")
    return render_to_response('index.html', locals(), context_instance=RequestContext(request))


def instrumento_formulario(request):
    if request.method == "POST":
        form = InstrumentoForm(request.POST)
        if form.is_valid():
            form.save(commit=False)
    else:
        form = InstrumentoForm()
    return render_to_response('instrumento_form.html', locals(), context_instance=RequestContext(request))


@csrf_exempt
def gerar_form_cadastro(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        tipo_id = request.POST["tipo"]
        form_cadastro = "<table><tr>"

        form_cadastro += montarFormCaracteristica(tipo_id, False)

        data = simplejson.dumps(form_cadastro)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")


@csrf_exempt
def gerar_form_busca(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        tipo_id = request.POST["tipo"]

        form_busca = "<table><tr>"
        form_busca += "<td colspan=2><label for='nome' style='font-weight: bold; color: #3a87ad;'>Modelo</label>"
        form_busca += "<input type='hidden' value='" + tipo_id + "' style='width:428px;' name='tipo'>"
        form_busca += "<input type='text' style='width:428px;' name='nome'></td>"
        form_busca += "<td><label for='fabricante' style='font-weight: bold; color: #3a87ad;'>Fabricante</label>"
        form_busca += "<input type='text' name='fabricante'></td>"
        form_busca += "<td><label for='preco' style='font-weight: bold; color: #3a87ad;'>Pre&ccedil;o</label>"
        form_busca += "<div class='input-prepend input-append'><span class='add-on'>R$</span><input type='text' name='preco'></div></td>"
        form_busca += "</td></tr><tr>"

        form_busca += montarFormCaracteristica(tipo_id, True)

        data = simplejson.dumps(form_busca)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")


def montarFormCaracteristica(tipo_id, is_search):
    caracteristicas = TipoCaracteristica.objects.filter(tipo=tipo_id)
    form_busca2 = ""

    contador = 0
    for caract in caracteristicas:
        if contador >= 4 or not is_search:
            form_busca2 += "</tr><tr>"
            contador = 0

        form_busca2 += "<td>"
        form_busca2 += "<label for='"
        form_busca2 += str(caract.id) + "' class='label_form'>"
        form_busca2 += caract.nome + "</label>"

        if not is_search:
            form_busca2 += "</td><td>"

        if caract.possui_relacionamento:
            form_busca2 += "<select name='" + str(caract.id) + "'>"
            form_busca2 += "<option value="">&nbsp;</option>"
            for aux in TabelaRelacionamento.objects.raw('SELECT id, nome FROM ' + caract.tabela_relacionamento):
                form_busca2 += "<option value='" + aux.nome + "'>" + aux.nome + "</option>"
            form_busca2 += "</select>"
        else:
            form_busca2 += "<input " + caract.tipo_campo.mascara + " name='"
            form_busca2 += str(caract.id) + "'>"

        form_busca2 += "</td>"
        contador += 1

    if is_search:
        form_busca2 += "<td><input type='submit' class='btn title_black' value = 'Buscar' style='height: 48px;width: 90px;margin-left: 5px;'></td>"

    form_busca2 += "</tr></table>"
    return form_busca2


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
            grid += "<img src='" + instrumento.foto.url + "' height='250' style='border: 1px solid;max-height: 300px;'/>" + "</td><td>&nbsp;</td><td>"
        else:
            grid += "<img src='/media/img/sem-imagem.jpg' height='250' width='210' style='border: 1px solid;'/>" + "</td><td>&nbsp;</td><td>"

        grid += "<p class='label_form'>Modelo: " + instrumento.nome
        grid += "</p><p class='label_form'>Tipo: " + instrumento.tipo.nome
        grid += "</p><p class='label_form'>Fabricante: " + instrumento.fabricante.nome
        grid += "</p><p class='label_form'>Pre&ccedil;o: R$ " + str(instrumento.preco) + "</p>"

        for caract in caracteristicas:
            grid += "<p class='label_form'>" + caract.tipo_caracteristica.nome + ": " + caract.valor + "</p>"

        grid += "</td></tr></table>"
        grid += "<a style='float:right;margin-top: -20px;' class='btn btn-primary' href=''> Voltar </a>"

        data = simplejson.dumps(grid)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")


@csrf_exempt
def buscar(request):
    parceiros = Parceiro.objects.all()
    tipos = Tipo.objects.all()
    fabricantes = Fabricante.objects.all()

    if request.method == "POST":
        tipo_id = request.POST["tipo"]

        nome = request.POST["nome"]
        fabricante = request.POST["fabricante"]
        preco = request.POST["preco"]

        caracteristicas = []
        for caracteristica in TipoCaracteristica.objects.filter(tipo=tipo_id):
            caracteristicas.append([caracteristica.id, request.POST[str(caracteristica.id)]])

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

        try:
            preco = preco.replace('.', '')
            preco = preco.replace(',', '.')
            preco = str(Decimal(preco))
        except:
            preco = ''

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
                consulta += "'" + caracteristica[1] + "'"

            consulta += ") or ("
            if caracteristica[1] == '':
                consulta += 'null'
            else:
                consulta += "'" + caracteristica[1] + "'"
            consulta += " is null) ) "

        consulta += " group by 1,2,3,4,5 "

        instrumentos = InstrumentoDTO.objects.raw(consulta)
    else:
        instrumentos = InstrumentoDTO.objects.raw("select   li.id as id,    li.nome as nome,    lt.nome as tipo,    lf.nome as fabricante,  li.preco as preco from loja_instrumento li left join loja_tipo lt on lt.id = li.tipo_id left join loja_fabricante lf on lf.id = li.fabricante_id")

    return render_to_response('index.html', locals(), context_instance=RequestContext(request))


@csrf_exempt
def add(request):
    parceiros = Parceiro.objects.all()
    tipos = Tipo.objects.all()
    fabricantes = Fabricante.objects.all()

    if request.method == "POST":
        instrumento = Instrumento()

        tipo_id = request.POST["tipo"]
        instrumento.tipo = Tipo.objects.get(pk=tipo_id)
        instrumento.nome = request.POST["nome"]
        instrumento.fabricante = Fabricante.objects.get(pk=request.POST["fabricante"])
        preco_post = request.POST["preco"]
        preco_post = preco_post.replace('.', '')
        preco_post = preco_post.replace(',', '.')
        instrumento.preco = Decimal(preco_post)

        try:
            f = request.FILES["foto"]
            nomeFoto = md5(str(datetime.now())).hexdigest()

            instrumento.foto = 'img/' + nomeFoto + '.jpg'

            with open('/Users/alisonjonck/Desktop/Joice/LojaRick/lojarick/lojarick/media/img/' + nomeFoto + '.jpg', 'wb+') as destination:
                for chunk in f.chunks():
                    destination.write(chunk)
        except:
            f = None

        instrumento.save()

        caracteristicas = TipoCaracteristica.objects.filter(tipo=tipo_id)
        for caracteristica in caracteristicas:

            valor_post = request.POST[str(caracteristica.id)]
            if not valor_post:
                continue

            instrumento_caracteristica = InstrumentoCaracteristica()

            instrumento_caracteristica.tipo_caracteristica = TipoCaracteristica.objects.get(pk=caracteristica.id)
            instrumento_caracteristica.instrumento = instrumento
            instrumento_caracteristica.valor = valor_post

            instrumento_caracteristica.save()

    instrumentos = InstrumentoDTO.objects.raw("select   li.id as id,    li.nome as nome,    lt.nome as tipo,    lf.nome as fabricante,  li.preco as preco from loja_instrumento li left join loja_tipo lt on lt.id = li.tipo_id left join loja_fabricante lf on lf.id = li.fabricante_id")
    return render_to_response('index.html', locals(), context_instance=RequestContext(request))
