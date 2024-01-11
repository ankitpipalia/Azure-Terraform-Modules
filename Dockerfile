FROM aquasec/tfsec:latest

COPY . /src
USER root
RUN chown -R tfsec /src
USER tfsec


ENTRYPOINT [ "tfsec", "/src" ]