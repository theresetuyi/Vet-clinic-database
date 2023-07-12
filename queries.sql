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

-- What animals belong to Melody Pond?
SELECT animals.name AS animal_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name AS animal_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal
SELECT owners.full_name AS owner_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name AS species_name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT animals.name AS animal_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name AS animal_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;