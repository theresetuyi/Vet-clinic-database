/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id AUTO_INCREMENT,
    name varchar(100),
    date_of_bith DATA,
    escape_attemps INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2),
    PRIMARY KEY (id)
);
