# Create your views here.
from django.http import JsonResponse
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
        #Armazenando ids passados 
        users_id = request.data.get("users", [])
        #Se o numero de ids passados for mais que 5 eu retorno um erro
        #- Projetos não podem ter mais de 5 usuários.
        if len(users_id) > 5:
                return Response({"errorMaxUser": "Projetos não podem ter mais de 5 usuários."}, status=status.HTTP_400_BAD_REQUEST)
        users_with_max_projects = []

        #Antes vou verificar se os id passados na request existem para não adicionar errado
        for user_id in request.data.get("users", []):
            try:
                #Verificando se o id existe mesmo, caso não exista ele vai entrar no except
                user = User.objects.get(pk=int(user_id))
                
                #Verificando se o usuário tem mais de 3 projetos usando a variavel que receber o user pelo id que está sendo percorrido dentro do for
                if user.project.count() >= 3:
                    #Armazenando o nome dos usuários  que possuem mais de três projetos - caso seja mais de um esse lista vai armazenar 
                    users_with_max_projects.append(user.name)

            except (User.DoesNotExist, ValueError):
                return Response({"error": f"Usuário com ID {user_id} não existe ou o ID não é válido."}, status=status.HTTP_400_BAD_REQUEST)
        
        if users_with_max_projects:
                return Response({"errorMaxProjectsUser": f"O(s) seguinte(s) usuário(s) já possuem 3 projetos associados: {', '.join(users_with_max_projects)}"}, status=status.HTTP_400_BAD_REQUEST)
        
        # Criar o serializador com os dados do projeto
        serializer = ProjectSerializer(data=request.data)
        # Verificar a validade do serializador
        if serializer.is_valid():
            # Salvar o projeto
            new_project = serializer.save()
            # Adicionar usuários existentes ao projeto
            for user_id in users_id:
                new_project.users.add(User.objects.get(pk=int(user_id)))
            # Atualizar o serializador para incluir os usuários
            serializer_with_users = ProjectSerializer(new_project)
            return Response(serializer_with_users.data, status=status.HTTP_201_CREATED)
        else:
            #Retornando a resposta de erro se qualquer problema na request o ocorre, pois o serializer está validando os dados passados
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    return Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['GET'])
def client_by_id(request, pk):
    #Caso o usuário passe um objeto não encontrado, caso seja um id existente retorna o objeto caso, contrario retornar erro 404.
    client = get_object_or_404(User, id=pk)
    serializer = UserSerializer(client)
    return Response(serializer.data)

@api_view(['GET'])
def project_by_id(request, pk):
    #Caso o projeto passe um objeto não encontrado, caso seja um id existente retorna o objeto, caso contrario retornar erro 404.
    project = get_object_or_404(Project, id=pk)
    serializer = ProjectSerializer(project)
    return Response(serializer.data)

@api_view(['GET'])
def get_projects_by_user(request, pk):
    if request.method == 'GET':
        try:
            user = User.objects.get(pk=pk)
            projects = user.project.all()  # Obtém todos os projetos relacionados a este usuário
            
            # Serializa os projetos em um formato adequado (por exemplo, lista de dicionários)
            serialized_projects = []
            for project in projects:
                # Serializa os usuários associados a cada projeto
                serialized_users = [{
                    'id': user.id,
                    'name': user.name,
                    'phone': user.phone,
                    'email': user.email
                } for user in project.users.all()]

                # Adiciona detalhes do projeto junto com os usuários associados
                serialized_projects.append({
                    'id': project.id,
                    'name': project.name,
                    'description': project.description,
                    'users': serialized_users
                })
            
            return Response(serialized_projects, status=status.HTTP_200_OK)  # Retorna a lista de projetos em formato JSON
        except User.DoesNotExist:
            return Response({'error': 'Usuário não encontrado'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)