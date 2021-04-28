doppler-project-setup:
	doppler projects create django-celery
	doppler setup --project django-celery --config dev
	doppler secrets upload sample.env

build:
	docker build -t dopplerhq/django-celery:latest .

run:
	doppler run -- docker-compose up

task:
	docker exec -it django python -c 'from doppler.celery import doppler_config_task; doppler_config_task.delay()'