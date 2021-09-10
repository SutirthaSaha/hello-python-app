FROM docker.wdf.sap.corp:50000/python@sha256:ab2e6f2a33c44bd0cda2138a8308ca45145edd21ba80a125c9df57c46a255839
RUN addgroup beaker && \
    adduser --disabled-password --ingroup beaker beaker
RUN apt-get update && apt-get -y upgrade
COPY /app /app
COPY requirements.txt /app
WORKDIR /app
RUN pip3 install --upgrade --no-cache-dir -r ./requirements.txt && \
    chown -R beaker:beaker /app
USER beaker
CMD ["python", "-u", "application.py"]