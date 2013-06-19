from django.contrib import admin
from models import Tipo, TipoCaracteristica, Instrumento, TipoCampo, InstrumentoCaracteristica, Fabricante, Parceiro


class TipoCaracteristicaInline(admin.TabularInline):
    model = TipoCaracteristica
    extra = 5


class TipoAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Tipo', {'fields': ['nome']}),
    ]
    inlines = [TipoCaracteristicaInline]
    list_display = ('pk', 'nome')
    search_fields = ['nome']


class InstrumentoCaracteristicaInline(admin.TabularInline):
    model = InstrumentoCaracteristica
    extra = 10


class InstrumentoAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Instrumento', {'fields': ['nome', 'tipo', 'fabricante', 'preco', 'foto']}),
    ]
    inlines = [InstrumentoCaracteristicaInline]
    list_display = ('pk', 'nome', 'tipo', 'fabricante', 'preco')
    search_fields = ['nome', 'tipo', 'fabricante']
    list_filter = ['tipo', 'fabricante']


admin.site.register(Tipo, TipoAdmin)
admin.site.register(Instrumento, InstrumentoAdmin)
admin.site.register(TipoCampo)
# admin.site.register(TipoCaracteristica)
admin.site.register(InstrumentoCaracteristica)
admin.site.register(Fabricante)
admin.site.register(Parceiro)
