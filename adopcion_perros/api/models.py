# api/models.py
from django.db import models
from usuarios.models import Usuario

class CentroAdopcion(models.Model):
    nombre         = models.CharField(max_length=100)
    direccion      = models.TextField()
    telefono       = models.CharField(max_length=20)
    correo         = models.EmailField()
    horario        = models.CharField(max_length=100)
    ubicacion_mapa = models.URLField()
    logo           = models.ImageField(upload_to='fundaciones/', blank=True, null=True)  # ← Este campo

    def __str__(self):
        return self.nombre


class Mascota(models.Model):
    TIPO_CHOICES = [('perro','Perro'),('gato','Gato')]
    nombre       = models.CharField(max_length=100)
    tipo         = models.CharField(max_length=10, choices=TIPO_CHOICES)
    raza         = models.CharField(max_length=100)
    edad         = models.IntegerField()
    tamano       = models.CharField(max_length=50)
    sexo         = models.CharField(max_length=10)
    descripcion  = models.TextField()
    foto_url     = models.URLField()
    disponible   = models.BooleanField(default=True)
    centro       = models.ForeignKey(CentroAdopcion, on_delete=models.CASCADE)
    estado_salud = models.CharField(max_length=100, default='Desconocido')
    def __str__(self): return f"{self.nombre} ({self.tipo})"

class SolicitudAdopcion(models.Model):
    usuario        = models.ForeignKey(Usuario, on_delete=models.CASCADE, null=True)
    nombre_completo= models.CharField(max_length=100)
    email          = models.EmailField()
    telefono       = models.CharField(max_length=20)
    mascota        = models.ForeignKey(Mascota, on_delete=models.CASCADE)
    mensaje        = models.TextField()
    estado         = models.CharField(max_length=20, default="Pendiente")
    fecha_solicitud= models.DateTimeField(auto_now_add=True)
    def __str__(self): return f"{self.nombre_completo} - {self.mascota.nombre}"

class Favorito(models.Model):
    usuario  = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    mascota  = models.ForeignKey(Mascota, on_delete=models.CASCADE)
    class Meta:
        unique_together = ('usuario','mascota')
    def __str__(self): return f"{self.usuario.username} ♥ {self.mascota.nombre}"
