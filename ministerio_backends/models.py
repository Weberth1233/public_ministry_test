from django.db import models

# Create your models here.
class User(models.Model):
    name = models.CharField(max_length = 255, unique= True)
    phone = models.CharField(max_length = 11)
    email =models.EmailField()
    "Pegando data do sistema ao fazer o cadastro do usuário"
    date_added = models.DateTimeField(auto_now_add = True)

    def __str__(self):
        return self.name

class Project(models.Model):
    name = models.CharField(max_length = 255, unique=True)
    description = models.TextField(max_length =1000)
    users = models.ManyToManyField(User, related_name='project')

    def __str__(self):
        return self.name
