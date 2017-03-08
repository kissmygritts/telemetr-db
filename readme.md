A CLI to create the telemetr-db. SQL files are in `db/sql`.

`pg-promise` is used to read and concatenate the QueryFiles to generate a query string to send to the database.

## Use

First install PostgreSQL and PostGIS.

``` bash
# install
git clone
cd telemetr-db
npm install -g

# create a database (change db/config/database.json if required)
psql createdb telemetr-dev

# create tables, views, triggers, functions
telemetr-db init tables -e development
telemetr-db init views -e development
telemetr-db init triggers -e development
telemetr-db init functions -e development
```

## SQL

The SQL files are stored [here](https://github.com/wiesr/telemetr-db/tree/master/db/sql).

## Contributing

Wildlife ecologists, biologists, or managers, I understand there may be a bit of a knowledge gap between what you know (R, Python) and what is used here (JavaScript, SQL). However I've probably left out fields in the database or useful functions and views from the database. Any recommendations or requests can be submitted to me either via email or by creating a new [issue](https://github.com/wiesr/telemetr-db/issues) (preferred method). If you really want to contribute to the source code I'm more than happy to help you get your feet wet (email me).

## Bugs

Please submit bugs by creating a [new issue](https://github.com/wiesr/telemetr-db/issues).
