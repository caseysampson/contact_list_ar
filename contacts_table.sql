##Copied into command line to create table

CREATE TABLE contacts
(
id serial NOT NULL PRIMARY KEY,
firstname varchar(255) NOT NULL,
lastname varchar(255) NOT NULL,
email varchar(255)
);