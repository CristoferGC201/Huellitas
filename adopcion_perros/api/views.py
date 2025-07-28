from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth import get_user_model

from .models import Mascota, SolicitudAdopcion, CentroAdopcion, Favorito
from .serializers import (
    MascotaSerializer,
    SolicitudAdopcionSerializer,
    CentroAdopcionSerializer,
    FavoritoSerializer,
)

from rest_framework import viewsets, permissions, status
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from rest_framework.views import APIView
from rest_framework.response import Response

import logging
logger = logging.getLogger('api')

# -----------------------------
# Registro de usuario
# -----------------------------
def registro_view(request):
    User = get_user_model()
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')

        if User.objects.filter(username=username).exists():
            messages.error(request, 'Ese nombre de usuario ya existe')
        else:
            user = User.objects.create_user(username=username, email=email, password=password)
            messages.success(request, 'Usuario registrado exitosamente')
            return redirect('login')
    return render(request, 'adopcion_perros/registro.html')

# -----------------------------
# Inicio de sesión
# -----------------------------
def login_view(request):
    from django.contrib.auth import get_user_model

    if request.method == 'POST':
        login_input = request.POST.get('login', '').strip() or request.POST.get('username', '').strip()
        password = request.POST.get('password')
        User = get_user_model()
        username = None

        # Si el usuario ingresó un email, buscamos el username asociado
        if '@' in login_input:
            try:
                user_obj = User.objects.get(email=login_input)
                username = user_obj.username
            except User.DoesNotExist:
                username = None
        else:
            # Asumimos que ingresó un username
            username = login_input

        user = authenticate(request, username=username, password=password) if username else None

        if user:
            login(request, user)
            return redirect('index')
        else:
            messages.error(request, 'Usuario o contraseña incorrectos')

    return render(request, 'adopcion_perros/login.html')

# -----------------------------
# Cerrar sesión
# -----------------------------
def logout_view(request):
    logout(request)
    return redirect('login')

# -----------------------------
# Vistas estáticas
# -----------------------------
def index_view(request):
    return render(request, 'adopcion_perros/index.html')

def noticias_view(request):
    return render(request, 'adopcion_perros/noticias.html')

def news_view(request):
    return render(request, 'adopcion_perros/news.html')

def colaborador_view(request):
    return render(request, 'adopcion_perros/colaborador.html')

# -----------------------------
# Vistas API REST
# -----------------------------
class MascotaViewSet(viewsets.ModelViewSet):
    queryset = Mascota.objects.all()
    serializer_class = MascotaSerializer
    permission_classes = [IsAuthenticated]

class CentroAdopcionViewSet(viewsets.ModelViewSet):
    queryset = CentroAdopcion.objects.all()
    serializer_class = CentroAdopcionSerializer

class SolicitudAdopcionView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        solicitudes = SolicitudAdopcion.objects.filter(usuario=request.user)
        serializer = SolicitudAdopcionSerializer(solicitudes, many=True)
        return Response(serializer.data)

    def post(self, request):
        data = request.data.copy()
        data['usuario'] = request.user.id
        serializer = SolicitudAdopcionSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SolicitudAdopcionViewSet(viewsets.ModelViewSet):
    queryset = SolicitudAdopcion.objects.all()
    serializer_class = SolicitudAdopcionSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(usuario=self.request.user)

class FavoritoViewSet(viewsets.ModelViewSet):
    serializer_class = FavoritoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Favorito.objects.filter(usuario=self.request.user)

    def perform_create(self, serializer):
        serializer.save(usuario=self.request.user)

# -----------------------------
# Formulario de adopción
# -----------------------------
@login_required(login_url='login')
def adopcion_formulario_view(request):
    # Mostrar todas las mascotas disponibles (perros y gatos)
    mascotas = Mascota.objects.filter(disponible=True)

    if request.method == 'POST':
        mascota = Mascota.objects.get(id=request.POST['mascota'])
        # Crear solicitud
        SolicitudAdopcion.objects.create(
            usuario=request.user,
            nombre_completo=request.POST['nombre_completo'],
            email=request.POST['email'],
            telefono=request.POST['telefono'],
            mascota=mascota,
            mensaje=request.POST['mensaje'],
        )
        # Marcar mascota como no disponible
        mascota.disponible = False
        mascota.save()

        messages.success(request, "Solicitud enviada correctamente. Gracias por adoptar ❤️")
        return redirect('catalogo')

    return render(request, 'adopcion_perros/adopcion_form.html', {'mascotas': mascotas})

# -----------------------------
# Catálogo de mascotas
# -----------------------------
def catalogo_view(request):
    perros = Mascota.objects.filter(tipo='perro', disponible=True)
    gatos  = Mascota.objects.filter(tipo='gato', disponible=True)
    return render(request, 'adopcion_perros/catalogo.html', {
        'perros': perros,
        'gatos':  gatos,
    })

# -----------------------------
# Fundaciones
# -----------------------------
def fundaciones_view(request):
    fundaciones = CentroAdopcion.objects.all()
    return render(request, 'adopcion_perros/fundaciones.html', {'fundaciones': fundaciones})

# -----------------------------
# Mis Solicitudes
# -----------------------------
@login_required(login_url='login')
def mis_solicitudes_view(request):
    solicitudes = SolicitudAdopcion.objects.filter(usuario=request.user).order_by('-fecha_solicitud')
    return render(request, 'adopcion_perros/mis_solicitudes.html', {'solicitudes': solicitudes})
