FROM node:8.9-alpine as angular
RUN apk update
RUN apk add nginx
RUN apk add openrc --no-cache
WORKDIR /usr/src/app
RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/
RUN npm i -g @angular/cli --silent
COPY package.json package.json
RUN npm install --silent
COPY . .
ARG ng_arg=dev
ENV ng_env $ng_arg
CMD if [ $ng_env = prod ]; \
    then \
    echo "build" && \
    ng build --prod -aot && \
    mkdir -p /usr/src/build && \
    cd /usr/src/build && \
    cp -r /usr/src/app/dist /usr/src/build && \
    rc-service nginx restart; \
    else \
    echo "serve" && \
    ng serve --host 0.0.0.0 --port 8080 --disable-host-check; \
    fi
#RUN ng build --prod -aot
EXPOSE 8080 8080
#CMD ["ng", "serve", "--host", "0.0.0.0", "--port","8080", "--disable-host-check"]

#FROM nginx:alpine
#RUN mkdir -p /usr/src/build
#WORKDIR /usr/src/build
#COPY ./nginx.conf /etc/nginx/nginx.conf # Copy custom nginx config
#COPY --from=angular-built /usr/src/app/dist /usr/src/build
#EXPOSE 8080 8080
#CMD ["nginx", "-g", "daemon off;"]