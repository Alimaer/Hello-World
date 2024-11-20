FROM node:22.11.0 AS node

LABEL title="HELLOWORLD DOCKER EXERCISE"

COPY ./nginx.conf /etc/nginx/conf/default.conf

WORKDIR /app

COPY package.json package.json

ENV NPM_VERSION=10.3.0

RUN npm install -g npm@"${NPM_VERSION}"

RUN npm install

COPY . .

RUN npm run build -- --configuration production

####

FROM nginx:alpine

VOLUME /var/cache/nginx

COPY --from=node /app/dist /usr/share/nginx/html