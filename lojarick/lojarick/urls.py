from django.conf.urls import patterns, include, url
from django.conf import settings
from django.contrib import admin
admin.autodiscover()

from django.contrib.staticfiles.urls import staticfiles_urlpatterns

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'lojarick.views.home', name='home'),
    # url(r'^lojarick/', include('lojarick.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', 'loja.views.index'),
    url(r'^instrumento/add/', 'loja.views.instrumento_formulario'),

    url(r'^media/(.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),

    #Ajax requests
    url(r'^form_busca/$', 'loja.views.gerar_form_busca'),
    url(r'^ver_instrumento/$', 'loja.views.ver_instrumento'),

    url(r'^buscar/$', 'loja.views.buscar'),
    url(r'^add/$', 'loja.views.add'),

    url(r'^gerar_form_caracteristica/$', 'loja.views.gerar_form_cadastro'),
)
