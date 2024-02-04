# Create your views here.
from django.shortcuts import render
from rest_framework.decorators import api_view
from ministerio_backends.models import User
from ministerio_backends.models import Project
from ministerio_backends.serializers import UserSerializer
from ministerio_backends.serializers import ProjectSerializer
from rest_framework.response import Response
from rest_framework import status
from django.shortcuts import get_object_or_404
# def cliente_list(request):
#     return HttpResponse("Lista de clientes.")

@api_view(['GET'])
def cliente_list(request):
    #Verificando metodo executado, caso não seja retornar o erro 405
    if request.method == 'GET':
        clients = User.objects.all()
        serializer = UserSerializer(clients, many =True)
        return Response(serializer.data)
    return Response(status = status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['GET'])
def project_list(request):
    if request.method == 'GET':
        projects = Project.objects.all()
        serializer = ProjectSerializer(projects, many =True)
        return Response(serializer.data)
    return Response(status = status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['POST'])
def client_create(request):
    if request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        #Verificando se os dados fornecidos são válidos de acordo com as regras definidas no seu serializador
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    return Response(status = status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['POST'])
def project_create(request):
    if request.method == 'POST':
        # Criar o serializador com os dados do projeto
        serializer = ProjectSerializer(data=request.data)

        # Verificar a validade do serializador
        if serializer.is_valid():
            # Salvar o projeto
            new_project = serializer.save()

            # Adicionar usuários existentes ao projeto
            for user_id in request.data.get("users", []):
                try:
                    user_exists = User.objects.get(pk=int(user_id))
                    new_project.users.add(user_exists)
                except (User.DoesNotExist, ValueError):
                    return Response({"error": f"Usuário com ID {user_id} não existe ou o ID não é válido."}, status=status.HTTP_400_BAD_REQUEST)

            # Atualizar o serializador para incluir os usuários
            serializer_with_users = ProjectSerializer(new_project)
            
            return Response(serializer_with_users.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['GET'])
def client_by_id(request, pk):
    #Caso o usuário passe um objeto não encontrado, caso seja um id existente retorna o objeto caso contrario retornar erro 404.
    client = get_object_or_404(User, id=pk)
    serializer = UserSerializer(client)
    return Response(serializer.data)