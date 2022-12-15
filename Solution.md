# Xeneta Operations Task Solution

These are my solutions to the cases in the task.

## Practical Case: Deployable development environment

### Technologies Used
1. I am using [**docker-compose**](docker-compose.yml) to set up a multi container development environment. Since this is a development environment we don't need a heavy setup to build & test the environment & code, using docker-compose should suffice.
2. I am using [**Dockerfile**](Dockerfile) to build an image for the application server. Using the base python3 image & copying the source code related files, I am building an image with name **backend-image** & using that to start up the application server.
3. I am using the latest postgres docker image from DockerHub as there was none that I could find specifically for postgres version 13.5. The [database dump](db/rates.sql) is automatically copied to the entrypoint of the db container.

### Code changes
1. As required I have changed the way the database configurations are read in [Flask config](rates/config.py). Now these values are read from environment variables.
2. I have created an [environment file](env/.dev.env) which has all the db configurations except for the password. This can be sourced while bringing up the environment.
3. I am not storing the db password. That needs to be exported to the local environment before bringing the environment up.

### Starting the development environment
Please make sure all the commands are run from the root of the repository.

1. Build the application server image.

> docker build . -t backend-image:latest

**Note**: If you change the docker image name or tag, please update the same in [docker compose file](docker-compose.yml).

2. Export the database password to local environment.

> export DB_PASSWORD=password

3. Start the development environment.

> docker compose --env-file ./env/.dev.env up

**Note**: The application server only starts up when the database passes a health check. Please wait for a couple of minutes for the application server to start, before moving ahead.

4. Test by making a call to the application server.

> curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"

5. Bring the system down gracefully.

> docker compose down

