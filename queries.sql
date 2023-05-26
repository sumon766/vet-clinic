/*Queries that provide answers to the questions from all projects.*/

/*Day 1 queries*/
SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escapte_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
/*Day 1 queries*/

-- Day 2 queries
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_born_112022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_born_112022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) AS animal_count FROM animals;
SELECT COUNT(*) AS animals_never_escaped FROM animals WHERE escapte_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered ORDER BY total_escape_attempts DESC
LIMIT 1;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;







UPDATE animals SET weight_kg = -11 WHERE id = 1;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Day 2 queries end

/*Queries day 3*/
UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);

UPDATE animals SET owner_id = (CASE
                    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
                    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
                    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
                    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
                    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
                END);

SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
SELECT a.* FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
SELECT o.full_name, a.* FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;
SELECT s.name, COUNT(a.id) AS animal_count FROM species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name;
SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escapte_attempts = 0;
SELECT o.full_name, COUNT(a.id) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;
/*Queries day 3*/

/*Day 4 queries*/
SELECT a.name AS animal_name FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Vet William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;
SELECT COUNT(DISTINCT v.animal_id) AS total_animals FROM visits v JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Vet Stephanie Mendez';
SELECT vt.name AS vet_name, s.name AS specialty_name FROM vets vt LEFT JOIN specializations sp ON sp.vet_id = vt.id LEFT JOIN species s ON s.id = sp.species_id;
SELECT a.name AS animal_name FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Vet Stephanie Mendez' AND v.visit_date >= '2020-04-01' AND v.visit_date <= '2020-08-30';
SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count FROM animals a JOIN visits v ON v.animal_id = a.id GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;
SELECT a.name AS animal_name FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Vet Maisy Smith' ORDER BY v.visit_date ASC LIMIT 1;
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets vt ON vt.id = v.vet_id ORDER BY v.visit_date DESC LIMIT 1;
SELECT COUNT(*) AS mismatched_visits FROM visits v JOIN animals a ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id LEFT JOIN specializations sp ON sp.vet_id = vt.id AND sp.species_id = a.species_id WHERE sp.vet_id IS NULL;
SELECT s.name AS specialty_name FROM specializations sp JOIN vets vt ON vt.id = sp.vet_id JOIN animals a ON a.species_id = sp.species_id WHERE vt.name = 'Vet Maisy Smith' GROUP BY s.name ORDER BY COUNT(*) DESC LIMIT 1;
/*Day 4 queries*/