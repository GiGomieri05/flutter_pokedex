from django.contrib import admin
from .models import StarredPokemon

# Register your models here.
@admin.register(StarredPokemon)
class StarredPokemonAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
