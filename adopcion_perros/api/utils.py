from rest_framework.views import exception_handler

def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)

    if response is not None:
        if response.status_code == 400:
            response.data = {
                'error': 'Error de validación.',
                'detalles': response.data
            }
        elif response.status_code == 403:
            response.data = {
                'error': 'Acceso denegado.',
                'detalles': 'No tienes permisos suficientes.'
            }
        elif response.status_code == 500:
            response.data = {
                'error': 'Error interno del servidor.',
                'mensaje': 'Inténtalo más tarde.'
            }

    return response