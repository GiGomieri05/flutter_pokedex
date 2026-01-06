from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import StarredPokemon
from .serializers import StarredPokemonSerializer

# Create your views here.

@api_view(['GET', 'POST'])
def starred_list(request):
    """
    POST -> Create or delete starred pokemon (toggle)
    GET -> List all code starred pokemons.
    """
    if request.method == 'POST':
        # se pokemon existir, preciso mudar o estado e retornar que nao esta favorito
        # se nao existir, preciso criar ele e retornar que esta favorito
        
        name = request.data.get('name')
        pokemon = StarredPokemon.objects.filter(name=name).first()
        
        if pokemon:
            pokemon.delete() # DELETE * FROM StarredPokemon WHERE name = name
            return Response({'name': name, 'starred': False}) # pokemon not starred
        else:
            StarredPokemon.objects.create(name=name) # INSERT INTO StarredPokemon VALUES (name = name)
            return Response({'name': name, 'starred': True}) #pokemon starred
        
    
    pokemons = StarredPokemon.objects.all()
    serializer = StarredPokemonSerializer(pokemons, many=True)
    return Response(serializer.data)
