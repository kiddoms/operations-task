FROM python:3

WORKDIR /usr/src/app

COPY ./rates/ ./
RUN pip install -U gunicorn
RUN pip install --no-cache-dir -r requirements.txt

CMD [ "gunicorn", "-b :3000 wsgi" ]