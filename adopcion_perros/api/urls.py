from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    MascotaViewSet,
    CentroAdopcionViewSet,
    SolicitudAdopcionViewSet,
    FavoritoViewSet,
    SolicitudAdopcionView,
    adopcion_formulario_view,
    login_view,
    logout_view,
    index_view,
    registro_view,
    noticias_view,
    news_view,
    colaborador_view,
    catalogo_view,
    fundaciones_view,
    mis_solicitudes_view,
)

# Router para la API REST
router = DefaultRouter()
router.register(r'mascotas', MascotaViewSet, basename='mascota')
router.register(r'centros', CentroAdopcionViewSet, basename='centro')
router.register(r'adopciones', SolicitudAdopcionViewSet, basename='adopciones')
router.register(r'favoritos', FavoritoViewSet, basename='favoritos')

urlpatterns = [
    # Rutas HTML
    path('', index_view, name='index'),
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('registro/', registro_view, name='registro'),
    path('noticias/', noticias_view, name='noticias'),
    path('news/', news_view, name='news'),
    path('colaborador/', colaborador_view, name='colaborador'),
    path('catalogo/', catalogo_view, name='catalogo'),
    path('fundaciones/', fundaciones_view, name='fundaciones'),
    path('adoptar/', adopcion_formulario_view, name='adoptar'),
    path('mis-solicitudes/', mis_solicitudes_view, name='mis_solicitudes'),


    # Endpoint para solicitudes de adopción (APIView)
    path('api/adopciones/', SolicitudAdopcionView.as_view(), name='api_adopciones'),

    # Incluir rutas del router bajo el prefijo /api/
    path('api/', include(router.urls)),
]


