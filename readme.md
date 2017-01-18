Repository for SQL to create an animal movement database. This is an alternative method to creating the telemetr database. Those that are SQL savvy may prefer this to the (telemetr-generator)[https://github.com/kissmygritts/telemetr-generator].

A database with this structure is required to use telemetr-api.

To recreate the database

```
createdb telemetr
psql telemetr

telemetr=# \i <file path>
```
