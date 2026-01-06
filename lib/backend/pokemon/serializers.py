from rest_framework import serializers
from .models import StarredPokemon

class StarredPokemonSerializer(serializers.ModelSerializer):
    class Meta:
        model = StarredPokemon
        fields = ['name']
    