from rest_framework import serializers
from .models import Mascota, CentroAdopcion, SolicitudAdopcion, Favorito

class CentroAdopcionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CentroAdopcion
        fields = '__all__'


class MascotaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mascota
        fields = '__all__'

class SolicitudAdopcionSerializer(serializers.ModelSerializer):
    class Meta:
        model = SolicitudAdopcion
        fields = '__all__'

    def validate_telefono(self, value):
        if not value.isdigit() or len(value) != 10:
            raise serializers.ValidationError("El teléfono debe tener 10 dígitos.")
        return value

    def validate_mensaje(self, value):
        if len(value) < 10:
            raise serializers.ValidationError("El mensaje debe tener al menos 10 caracteres.")
        return value

class FavoritoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Favorito
        fields = '__all__'
        
        
        

