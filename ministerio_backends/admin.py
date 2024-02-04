from django.contrib import admin

# Register your models here.
from .models import User
from .models import Project
# Register your models here.

admin.site.register(User)
admin.site.register(Project)