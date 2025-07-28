from django.contrib import admin
from .models import CentroAdopcion, Mascota, SolicitudAdopcion, Favorito

@admin.register(CentroAdopcion)
class CentroAdopcionAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'telefono', 'correo')
    search_fields = ('nombre',)

@admin.register(Mascota)
class MascotaAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'tipo', 'raza', 'centro', 'disponible')
    list_filter  = ('tipo', 'disponible', 'centro')
    search_fields = ('nombre', 'raza')

@admin.register(SolicitudAdopcion)
class SolicitudAdopcionAdmin(admin.ModelAdmin):
    list_display    = ('nombre_completo', 'mascota', 'estado', 'fecha_solicitud', 'usuario')
    list_filter     = ('estado', 'fecha_solicitud')
    search_fields   = ('nombre_completo', 'email', 'mascota__nombre', 'usuario__username')
    readonly_fields = ('fecha_solicitud',)
    actions         = ['aprobar_solicitudes', 'rechazar_solicitudes']

    @admin.action(description='Marcar como Aprobado')
    def aprobar_solicitudes(self, request, queryset):
        queryset.update(estado='Aprobado')

    @admin.action(description='Marcar como Rechazado')
    def rechazar_solicitudes(self, request, queryset):
        queryset.update(estado='Rechazado')

@admin.register(Favorito)
class FavoritoAdmin(admin.ModelAdmin):
    list_display = ('usuario', 'mascota')
    search_fields = ('usuario__username', 'mascota__nombre')
