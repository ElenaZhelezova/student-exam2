FROM python:3.8

RUN adduser --disabled-password webapp

WORKDIR /home/webapp

COPY js_example/ js_example/
COPY tests/ tests/
COPY LICENSE LICENSE
COPY MANIFEST.in MANIFEST.in
COPY README.rst README.rst
COPY setup.cfg setup.cfg
COPY setup.py setup.py

RUN chown -R webapp:webapp ./

USER webapp

RUN python -m pip install --upgrade pip
RUN pip install -e .
RUN pip install -e '.[test]'

ENV FLASK_APP=js_example

EXPOSE 5000

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]