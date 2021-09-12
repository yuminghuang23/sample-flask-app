FROM python:3.6.4

WORKDIR /workdir

COPY . /workdir

RUN pip install -r requirements.txt

RUN python manage.py create_db

EXPOSE 8090

CMD ["python", "run.py"]





