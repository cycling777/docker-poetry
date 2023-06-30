FROM ubuntu:22.04

ARG SRCDIR="/var/src"
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/usr/lib/python3.10/site-packages:${PYTHONPATH}"
ENV TZ="Asia/Tokyo"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata python3 python3-pip curl
RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt-get clean

RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.create false

RUN mkdir -p /var/src
COPY . /var/src
WORKDIR /var/src