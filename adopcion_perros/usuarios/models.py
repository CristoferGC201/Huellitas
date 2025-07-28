from django.contrib.auth.models import AbstractUser
from django.db import models

class Usuario(AbstractUser):
    ROLES = (
        ('adoptante', 'Adoptante'),
        ('centro', 'Centro de Adopción'),
    )
    rol = models.CharField(max_length=20, choices=ROLES, default='adoptante')
