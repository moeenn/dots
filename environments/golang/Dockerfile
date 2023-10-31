FROM golang:1.21-alpine

WORKDIR /code
RUN go install golang.org/x/tools/gopls@latest

EXPOSE 3000 5000
CMD ["/bin/sh"]

