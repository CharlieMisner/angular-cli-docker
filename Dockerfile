FROM node:8.9-alpine as angular

RUN apk update
RUN apk add nginx
RUN mkdir /tmp/nginx
RUN chown -R nginx /var/lib/nginx
RUN mkdir /run/nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/src/app
RUN npm i -g @angular/cli --silent
COPY package.json package.json
RUN npm install --silent
COPY . .
ARG ng_arg=dev
ENV ng_env $ng_arg

CMD if [ $ng_env = prod ]; \
    then \
    echo "Building Angular application for production..." && \
    ng build --prod -aot && \
    mkdir -p /usr/src/build && \
    cd /usr/src/build && \
    cp -r /usr/src/app/dist /usr/src/build && \
    nginx; \
    else \
    echo "Serving Angular application with the Angular CLI..." && \
    ng serve --host 0.0.0.0 --port 8080 --disable-host-check; \
    fi

EXPOSE 8080 8080
