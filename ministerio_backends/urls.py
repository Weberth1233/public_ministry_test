from django.urls import path
from . import views

urlpatterns = [
    #Rotas de usuários
    #Rota para listar todos os usuarios
    path('users/', views.cliente_list, name='client_List'),
    #Rota para cadastrar usuarios
    path('createuser/', views.client_create, name='create_client'),
    #Rota para consultar usuario por id
    path('user/<int:pk>/', views.client_by_id, name='user_by_id'),
    path('userprojects/<int:pk>/', views.get_projects_by_user, name='get_projects_by_user'),

    #Rotas de projetos
    #Rota para listar todos os projetos cadastrados
    path('projects/', views.project_list, name="project_list"),
    #Rota para cadastrar projetos
    path('createproject/', views.project_create, name="create_project"),
    #Rota para buscar informações do projeto pelo id
    path('project/<int:pk>/', views.project_by_id, name="project_by_id"),
]