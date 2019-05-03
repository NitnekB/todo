# Todo App

Small CRUD app using _Rails_ API and _Docker_ to manage Todo list and export them by day as tracking.

## Functionalities

- [x] Use Docker for local and test devs purpose
- [x] Use and setup Rspec (use _database-cleaner_)
- [x] Workspaces CRUD
- [x] Projects CRUD that belongs to Workspaces
- [x] Add continuous integration system (Circle CI?)
- [ ] Add seeds
- [ ] Add _Faker_ to generate tests and seeds
- [x] Tasks CRUD that has many Projects
- [ ] Automatically set `general` project for unassigned tasks
- [ ] Duplicate a task on another project
- [ ] Move task on another project
- [ ] Add subtasks CRUD?
- [ ] Manage and complete Todo _tasks_
- [ ] Export tracking day by day (by workspace)
- [ ] ... (see later for futher improvement)

## Setup

Clone the project or feel free to fork-it!

### Configuration

Add an `app_env.secrets` file at the root of the project.
This file allows you to override environment variables based on `app_env` file.
This file is **mandatory**!

```bash
touch app_env.secrets
```

Add a `docker-compose.overrive.yml` file to override some behaviour of the native configuration

```bash
touch docker-compose.overrive.yml
```

Example of local configuration using _Boot2Docker_ VM and a specific PATH for postgresql

```bash
version: '3'
volumes:
  db_data:
    driver_opts:
      type: none
      device: /var/lib/docker/data/postgresql/todoapp
      o: bind
```

### Run the app and create the database

> All change means disorganization of the old and organization of the new. Saul Alinsky

This project have specific way to manage contexts using [_Docker_](https://www.docker.com/)

Indeed, you'll find everything about _Docker_ in `docker/` folder. This one is tidy
by context (aka `local` for local setup and `test`).

There is a script which allows you to launch _docker-compose_ command easily fron root project

First, run dependenties installation

```bash
docker/local/dc run app bundle install
```

Then, build the project 

```bash
docker/local/dc build
```

Create the database and play migrations

```bash
docker/local/dc run --rm app rake db:create db:migrate
```

Finally, launch the app!

```bash
# -d to launch as deamon
docker/local/dc up -d
```

If you don't feel confortable with this, just move to specific directory and use _docker-compose_ command as usual ;)

## Work with tests

This project use Rspec!

Same here, setup the test app using _Docker_

```bash
docker/test/dc run --rm app bundle install
```

Then, build the project 

```bash
docker/test/dc build
```

Finally, launch the Test App!

```bash
# -d to launch as deamon
docker/test/dc run --rm -e "RAILS_ENV=test" app rake db:create db:migrate rspec
```

If like me, you prefer to test in compartment, just enter on the test container and launch command you want

```bash
# Enter in the test conatiner with bash command
docker/test/dc run --rm app bash

# In the container: Run specific file test
rspec spec/models/workspace_spec.rb
```
