FROM python:3.6.9-slim-stretch

RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt install -y libffi-dev libssl1.0-dev build-essential nginx && \
    rm -rf /etc/nginx/sites-enabled/* /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt && \
    cp -rf ./docker/docker-nginx.conf /etc/nginx/conf.d
    
ENV OOI_SECRET_KEY DR5fmbkotYMINJPjhv0r7hviUrNBKQKe
ENV OOI_SCHEME http

EXPOSE 80

CMD [ "bash", "-c", "nginx && python ./ooi.py --host 0.0.0.0 --port 9999" ]
