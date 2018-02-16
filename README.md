# Angular CLI and Docker

This repository contains an Angular CLI app that runs inside of a docker container. The docker container can be built to run in either development or in production utilizing the CLI's ng serve and ng build commands, respectively.

## For Development

When running the container in development mode, the user can take advantage of the Angular CLI's hot reload. To run the app in development mode (i.e. using ng serve), run the following commands:

    ```
    docker-compose build --build-arg ng_arg=dev docker-angular
    docker-compose up
    ```
The statement `--build-arg ng_arg=dev` sets a docker build argument to development, and configures the container to execute the ng serve command. 

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

