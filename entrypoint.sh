#!/bin/bash

# Ejecutar migraciones automáticamente
php artisan migrate --force

# Iniciar el servidor Laravel
php artisan serve --host=0.0.0.0 --port=10000
