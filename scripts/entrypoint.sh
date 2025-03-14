#!/bin/sh
if [ "$POSTGRES_DB" = "courseapp" ]; then
    echo "Waiting for PostgreSQL..."

    while ! nc -z $PG_HOST $PG_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"

    echo "API started"
    python manage.py collectstatic --noinput
    python manage.py makemigrations
    python manage.py migrate
    python manage.py migrate cities --noinput
    python manage.py migrate sessions --noinput
    python manage.py runserver 0.0.0.0:8000
fi
