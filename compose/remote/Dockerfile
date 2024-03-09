FROM python:3.11.3-slim-bullseye


ADD . /app/

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV  DJANGO_SETTINGS_MODULE="config.settings.production"
ENV  DJANGO_READ_DOT_ENV_FILE=1

# Install required system dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
  # psycopg2 dependencies
  libpq-dev \
  # Translations dependencies
  gettext \
  # dependencies for building Python packages
  build-essential \
  #server
  supervisor nginx tree\
  && pip install --upgrade pip \
  && pip install --no-cache-dir -r /app/requirements/production.txt

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN mv  /app/compose/remote/django/nginx-app.conf /etc/nginx/sites-enabled/
RUN mv  /app/compose/remote/django/supervisor-app.conf /etc/supervisor/conf.d/

RUN  python /app/merge_production_dotenvs_in_dotenv.py
EXPOSE 80
ENTRYPOINT ["supervisord", "-n"]