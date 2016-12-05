FROM python:3

MAINTAINER Markus Kaiser <markus.kaiser@in.tum.de>

RUN pip install --no-cache-dir uwsgi

VOLUME /src
WORKDIR /src

COPY uwsgi.ini /etc/uwsgi/uwsgi_init.ini
RUN touch /etc/uwsgi/uwsgi.ini

EXPOSE 3031

CMD ["uwsgi", "--ini", "/etc/uwsgi/uwsgi_init.ini", "--ini", "/etc/uwsgi/uwsgi.ini"]
