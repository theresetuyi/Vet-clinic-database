/* Database schema to keep the structure of the entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL(10, 2) 
	);
	ALTER TABLE animals
	ADD species VARCHAR(300);
