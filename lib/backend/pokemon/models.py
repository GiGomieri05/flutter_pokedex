from django.db import models

# Create your models here.
class StarredPokemon(models.Model):
    name = models.CharField(max_length=255, primary_key=True)
    
    def __str__(self):
        return self.name