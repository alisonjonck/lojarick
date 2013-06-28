from django.forms import ModelForm
from models import Instrumento


class InstrumentoForm(ModelForm):
    class Meta:
        model = Instrumento
