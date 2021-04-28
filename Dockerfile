FROM python:3.9-slim-buster

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1 

WORKDIR /usr/src/app

RUN set -ex \
    apt-get update && \
    apt-get install && \
    rm -rf /var/lib/apt/lists/* 

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip setuptools -r requirements.txt

COPY . .

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --retries=3  CMD curl --fail http://localhost:8080/health-check/ || exit 1

CMD ["./bin/entrypoint.sh", "gunicorn", "doppler.wsgi:application", "--bind", "0.0.0.0:8080"]

