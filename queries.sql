/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
    UPDATE animals SET species = 'unspecified';
    SELECT * FROM animals; 
ROLLBACK;
SELECT * FROM animals; 

/* Inside a transaction, update the animals table by setting the species column to 'digimon' for animals with names ending in 'mon' */
BEGIN;
    UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
    SELECT * FROM animals; 
COMMIT;
SELECT * FROM animals; 

/* Inside a transaction, update the animals table by setting the species column to 'pokemon' for animals without a species already set */
BEGIN;
    UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
    SELECT * FROM animals; 
COMMIT;
SELECT * FROM animals; 

/* Inside a transaction, delete all records in the animals table, then rollback the transaction */
BEGIN;
    DELETE FROM animals;
    SELECT * FROM animals; 
ROLLBACK;
SELECT * FROM animals; 

/* Inside a transaction, delete all animals born after Jan 1st, 2022, update weights, rollback to savepoint, update negative weights, commit transaction */
BEGIN;
    DELETE FROM animals WHERE date_of_birth > '2022-01-01';
    SAVEPOINT update_weights;
    UPDATE animals SET weight_kg = weight_kg * -1;
    ROLLBACK TO update_weights;
    UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
    COMMIT;
SELECT * FROM animals; 

/* Queries to answer questions */
SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS escaped_animals FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS avg_weight FROM animals;
SELECT CASE WHEN neutered THEN 'Neutered' ELSE 'Not neutered' END AS escape_status, COUNT(*) AS count FROM animals GROUP BY escape_status;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';