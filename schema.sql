/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escapte_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2),
    species VARCHAR(100)
);
