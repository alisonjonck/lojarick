from django.db import models

class Tipo(models.Model):
    nome = models.CharField(max_length=100)
    def get_absolute_url(self):
        return u"/tipo/%s/" % self.pk
    def __unicode__(self):
        return self.nome


class Fabricante(models.Model):
    nome = models.CharField(max_length=100)
    def __unicode__(self):
        return self.nome


class Instrumento(models.Model):
    nome = models.CharField(max_length=100)
    tipo = models.ForeignKey(Tipo)
    fabricante = models.ForeignKey(Fabricante)
    preco = models.DecimalField(max_digits=11, decimal_places=2)
    foto = models.ImageField(upload_to='img', blank=True, null=True)
    def __unicode__(self):
        return self.nome


class TipoCampo(models.Model):
    nome = models.CharField(max_length=100)
    mascara = models.CharField(max_length=100)
    def __unicode__(self):
        return self.nome


class TipoCaracteristica(models.Model):
    nome = models.CharField(max_length=100)
    tipo_campo = models.ForeignKey(TipoCampo)
    tipo = models.ForeignKey(Tipo)
    possui_relacionamento = models.BooleanField()
    tabela_relacionamento = models.CharField(max_length=100, blank=True)
    def __unicode__(self):
        return self.nome


class InstrumentoCaracteristica(models.Model):
    valor = models.CharField(max_length=100)
    instrumento = models.ForeignKey(Instrumento)
    tipo_caracteristica = models.ForeignKey(TipoCaracteristica)
    def __unicode__(self):
        return self.valor


class Parceiro(models.Model):
    nome = models.CharField(max_length=100)
    site = models.CharField(max_length=100)
    def __unicode__(self):
        return self.nome
