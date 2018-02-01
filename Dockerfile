FROM node:8.9-alpine as angular
WORKDIR /usr/src/app
RUN npm i -g @angular/cli
COPY package.json package.json
RUN npm install --silent
COPY . .
ARG ng_arg=dev
ENV ng_env $ng_arg
RUN echo $ng_env
RUN if [ $ng_env = prod ]; \
    then \
    echo "production"; \
    fi
CMD if [ $ng_env = prod ]; \
    then \
    echo "build" && \
    ng build --prod -aot; \
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