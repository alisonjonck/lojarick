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
    instrumentos = Instrumento.objects.all()
    return render_to_response('index.html', locals(), context_instance=RequestContext(request))


@csrf_exempt
def gerar_form_busca(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        tipo_id = request.POST["tipo"]
        caracteristicas = TipoCaracteristica.objects.filter(tipo=tipo_id)

        form_busca = "<form action='buscar' method='post'><table><tr>"
        form_busca += "<td colspan=2><label for='nome' style='font-weight: bold; color: #3a87ad;'>Modelo</label>"
        form_busca += "<input type='text' style='width:428px;' name='nome'></td>"
        form_busca += "<td><label for='fabricante' style='font-weight: bold; color: #3a87ad;'>Fabricante</label>"
        form_busca += "<input type='text' name='fabricante'></td>"
        form_busca += "<td><label for='preco' style='font-weight: bold; color: #3a87ad;'>Pre&ccedil;o</label>"
        form_busca += "<div class='input-prepend input-append'><span class='add-on'>R$</span><input type='number' name='preco'></div></td>"
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
                form_busca += "<select>"
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


@csrf_exempt
def ver_instrumento(request):
    if request.is_ajax() and request.method == "POST":
        mimetype = "application/json"
        instrumento_id = request.POST["instrumento"]
        instrumento = Instrumento.objects.get(pk=instrumento_id)
        caracteristicas = InstrumentoCaracteristica.objects.filter(instrumento=instrumento_id)
        grid = "<table><tr><td>"
        if instrumento.foto:
            grid += "<img src='" + instrumento.foto.url + "' width='250'/>" + "</td><td>"

        grid += "<p>Modelo: " + instrumento.nome
        grid += "</p><p>Tipo: " + instrumento.tipo.nome
        grid += "</p><p>Fabricante: " + instrumento.fabricante.nome
        grid += "</p><p>Pre&ccedil;o: R$" + str(instrumento.preco) + "</p>"

        for caract in caracteristicas:
            grid += "<p>" + caract.tipo_caracteristica.nome + ": " + caract.valor + "</p>"

        grid += "</td></tr><tr><td colspan=2>"
        grid += "<a style='float:right;' class='btn btn-primary' href=''> Voltar </a></td></tr></table>"

        data = simplejson.dumps(grid)
        return HttpResponse(data, mimetype)
    else:
        return HttpResponse("This is not an valid request")
