from rest_framework import serializers
from .models import User
from.models import Project

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'name', 'phone', 'email']

class ProjectSerializer(serializers.ModelSerializer):
    #Receber o id na resposta da request
    # users = serializers.PrimaryKeyRelatedField(many=True, queryset=User.objects.all())
    
    users = UserSerializer(many=True, read_only=True)
    class Meta:
        model = Project
        fields = ['id', 'name', 'description', 'users']