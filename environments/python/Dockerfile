FROM python:3.12-alpine

WORKDIR /code

RUN pip install --upgrade pip
RUN pip install black mypy invoke ruff

EXPOSE 3000 5000
CMD ["/bin/sh"]

