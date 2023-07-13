/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8),
       ('Pikachu', '2021-01-07', 1, false, 15.04),
       ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES 
    ('Charmander', '2020-02-08', 0, false, -11, 'unspecified'),
    ('Plantmon', '2021-11-15', 2, true, -5.7, 'unspecified'),
    ('Squirtle', '1993-04-02', 3, false, -12.13, 'unspecified'),
    ('Angemon', '2005-06-12', 1, true, -45, 'unspecified'),
    ('Boarmon', '2005-06-07', 7, true, 20.4, 'unspecified'),
    ('Blossom', '1998-10-13', 3, true, 17, 'unspecified'),
    ('Ditto', '2022-05-14', 4, true, 22, 'unspecified');

INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');
    -- Update animals to include species_id and owner_id
UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Vet William Tatcher', 45, '2000-04-23'),
       ('Vet Maisy Smith', 26, '2019-01-17'),
       ('Vet Stephanie Mendez', 64, '1981-05-04'),
       ('Vet Jack Harkness', 38, '2008-06-08');
INSERT INTO specializations (species_id, vet_id)
    SELECT species.id, vets.id
     FROM species, vets
     WHERE species.name = 'Pokemon'
      AND vets.name = 'Vet William Tatcher';

INSERT INTO specializations (species_id, vet_id)
    SELECT species.id, vets.id
    FROM species, vets
    WHERE species.name = 'Digimon'
     AND vets.name = 'Vet Stephanie Mendez';
INSERT INTO specializations (species_id, vet_id)
    SELECT species.id, vets.id
    FROM species, vets
    WHERE species.name = 'Digimon'
    AND vets.name = 'Vet Jack Harkness';
INSERT INTO visits (animal_id, vet_id, visit_date)
   SELECT a.id, v.id, visit_dates.visit_date
       FROM (
            SELECT 'Agumon' AS animal_name, 'Vet William Tatcher' AS vet_name, DATE '2020-05-24' AS visit_date UNION ALL
            SELECT 'Agumon', 'Vet Stephanie Mendez', DATE '2020-07-22' UNION ALL
             SELECT 'Gabumon', 'Vet Jack Harkness', DATE '2021-02-02' UNION ALL
             SELECT 'Pikachu', 'Vet Maisy Smith', DATE '2020-01-05' UNION ALL
             SELECT 'Pikachu', 'Vet Maisy Smith', DATE '2020-03-08' UNION ALL
             SELECT 'Pikachu', 'Vet Maisy Smith', DATE '2020-05-14' UNION ALL
             SELECT 'Devimon', 'Vet Stephanie Mendez', DATE '2021-05-04' UNION ALL
             SELECT 'Charmander', 'Vet Jack Harkness', DATE '2021-02-24' UNION ALL
             SELECT 'Plantmon', 'Vet Maisy Smith', DATE '2019-12-21' UNION ALL
             SELECT 'Plantmon', 'Vet William Tatcher', DATE '2020-08-10' UNION ALL
             SELECT 'Plantmon', 'Vet Maisy Smith', DATE '2021-04-07' UNION ALL
            SELECT 'Squirtle', 'Vet Stephanie Mendez', DATE '2019-09-29' UNION ALL
            SELECT 'Angemon', 'Vet Jack Harkness', DATE '2020-10-03' UNION ALL
             SELECT 'Angemon', 'Vet Jack Harkness', DATE '2020-11-04' UNION ALL
            SELECT 'Boarmon', 'Vet Maisy Smith', DATE '2019-01-24' UNION ALL
             SELECT 'Boarmon', 'Vet Maisy Smith', DATE '2019-05-15' UNION ALL
             SELECT 'Boarmon', 'Vet Maisy Smith', DATE '2020-02-27' UNION ALL
             SELECT 'Boarmon', 'Vet Maisy Smith', DATE '2020-08-03' UNION ALL
             SELECT 'Blossom', 'Vet Stephanie Mendez', DATE '2020-05-24' UNION ALL
             SELECT 'Blossom', 'Vet William Tatcher', DATE '2021-01-11' ) AS visit_dates
       JOIN animals AS a ON a.name = visit_dates.animal_name
        JOIN vets AS v ON v.name = visit_dates.vet_name;
