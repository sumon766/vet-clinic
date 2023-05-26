/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

/*Day 1 queries*/
CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escapte_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2)
);
/*Day 1 queries*/

/*Day 2 queries*/
CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escapte_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2),
    species VARCHAR(100)
);

ALTER TABLE animals DROP COLUMN IF EXISTS species;
ALTER TABLE animals ADD COLUMN species VARCHAR(100);
/*Day 2 queries*/

/*Day 3 queries*/
ALTER TABLE animals DROP COLUMN species;

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(100), age INT);
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(100));
ALTER TABLE animals
ALTER COLUMN id SET DATA TYPE INT;
ALTER TABLE animals
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id),
ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners (id);  
/*Day 3 queries*/

/*Day 4 queries*/
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date),
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)
);
/*Day 4 queries*/