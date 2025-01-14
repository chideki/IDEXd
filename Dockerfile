FROM node:10

RUN apt-get update && apt-get install -y wget mysql-client

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amrhf-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-armhf-$DOCKERIZE_VERSION.tar.gz

WORKDIR /usr/idexd/
COPY package*.json ./
RUN npm install -g pm2
RUN npm install -g sequelize
RUN npm install
COPY . .
RUN mkdir lib
RUN npm run build

EXPOSE 8080

ENTRYPOINT [ "pm2" ]
