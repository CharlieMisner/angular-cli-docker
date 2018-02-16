# Angular CLI and Docker (Development and Production)

This repository contains an Angular CLI app that runs inside of a docker container. The docker container can be built to run in either development or in production utilizing the CLI's ng serve and ng build commands, respectively.

## In Development

When running the container in development, your can take advantage of the Angular CLI's hot reloading. To run the app in development (i.e. using ng serve), run the following commands:

    docker-compose build --build-arg ng_arg=dev docker-angular
    docker-compose up
    
The statement `--build-arg ng_arg=dev` configures the container to execute the ng serve command. 

## In Production

When running the container in development, you can take advantage of the Angular CLI's Ahead of Time Compilation. To run the app in production (i.e. using ng build --aot), run the following commands:

    docker-compose build
    docker-compose up
    
If no build argument is provided, the container will default to production. If you would like, you can set the build argument `--build-arg ng_arg=prod`.

## Existing Angular CLI Applications

To implement the docker container in an existing angular application, copy the following files into the app's root folder:

    Dockerfile
    docker-compose.yml
    nginx.conf

