# Doppler with Django and Celery

Repsitory for testing out Doppler to provide secrets to a Django app using Celery.

1. Create test Doppler project:

```sh
doppler projects create django-celery
doppler setup --project django-celery --config dev
doppler secrets upload sample.env
```    

2. Build Django image:

```sh
docker build -t dopplerhq/django-celery:latest .
```

3. Use Docker Compose to Run Django, Celery, and Redis containers:

```sh
doppler run -- docker-compose up
```

4. Add a task and observe the value for `APP_SECRET` fetched correctly:

```sh
docker exec -it django python -c 'from doppler.celery import doppler_config_task; doppler_config_task.delay()'
```
