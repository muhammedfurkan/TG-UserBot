FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y unace unrar zip unzip p7zip-full p7zip-rar sharutils rar
RUN apt-get install -y ffmpeg
RUN apt-get install python3 git python3-pip -y
RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2 \
    && rm -rf /root/.cache/pip/ \
    && find / -name '*.pyc' -delete \
    && find / -name '*__pycache__*' -delete
RUN pip3 install -U psycopg2-binary

RUN apt update && apt upgrade -y && \
    apt install --no-install-recommends -y \
        bash \
        curl \
        gcc \
        git 
        

COPY . /tmp/userbot_local
WORKDIR /usr/src/app/TG-UserBot/

RUN git clone https://github.com/muhammedfurkan/TG-UserBot.git /usr/src/app/TG-UserBot/
RUN rsync --ignore-existing --recursive /tmp/userbot_local/ /usr/src/app/TG-UserBot/

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --no-warn-script-location --no-cache-dir -r requirements.txt

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp
CMD ["python", "-m", "userbot"]
