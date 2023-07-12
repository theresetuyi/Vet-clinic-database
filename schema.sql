/* Database schema to keep the structure of the entire database. */

CREATE TABLE animals (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10, 2),
    species_id INTEGER REFERENCES species(id),
    owner_id INTEGER REFERENCES owners(id)
);
ALTER TABLE animals
ADD species VARCHAR(300);

ALTER TABLE animals
ADD species_id INTEGER REFERENCES species(id);

ALTER TABLE animals
ADD  owner_id INTEGER REFERENCES owners(id);

CREATE TABLE  owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
