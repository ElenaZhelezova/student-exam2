FROM python:3.8

RUN useradd webapp

WORKDIR /home/webapp

COPY js_example/ js_example/
COPY tests/ tests/
COPY LICENSE LICENSE
COPY MANIFEST.in MANIFEST.in
COPY README.rst README.rst
COPY setup.cfg setup.cfg
COPY setup.py setup.py
COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN chown -R webapp:webapp ./

USER webapp

ENV FLASK_APP=js_example

EXPOSE 5000

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]