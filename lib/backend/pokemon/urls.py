from django.urls import path
from . import views

urlpatterns = [
    path('starred/', views.starred_list, name='starred'),
]