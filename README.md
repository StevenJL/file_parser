# File Parser


## Set Up

1. In project path, `bundle install`  to install Ruby dependencies

2. Create the database and tables

Create the databases for development and test environments

```
mysql -h localhost -u <user_name>

mysql> CREATE DATABASE file_parser_development;
mysql> CREATE DATABASE file_parser_test;
```

## Importing

```
bundle exec rake import
```


## User Interface Philosophies

