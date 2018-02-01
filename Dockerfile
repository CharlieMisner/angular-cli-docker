FROM node:8.9-alpine as angular-built
WORKDIR /usr/src/app
RUN npm i -g @angular/cli
COPY package.json package.json
RUN npm install --silent
COPY . .
RUN ng build --prod -aot
#EXPOSE 8080
#CMD ["ng", "serve", "--host", "0.0.0.0", "--port","8080", "--disable-host-check"]

FROM nginx:alpine
RUN mkdir -p /usr/src/build
WORKDIR /usr/src/build
# Copy custom nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=angular-built /usr/src/app/dist /usr/src/build
EXPOSE 8080 8080
CMD ["nginx", "-g", "daemon off;"]