FROM debian:bullseye-slim

RUN apt update 
RUN apt full-upgrade
RUN apt install openssl libssl-dev

ENTRYPOINT ["openssl"]

