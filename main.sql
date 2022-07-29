-- CRIAR DB

CREATE DATABASE "drivenbank";

-- CRIAR TABELA DE CUSTOMERS

CREATE TABLE "customers" (
  "id" SERIAL PRIMARY KEY,
  "fullName" VARCHAR(60) NOT NULL,
  "cpf" VARCHAR(11) NOT NULL UNIQUE,
  "email" VARCHAR(60) CHECK("email" LIKE '%_@%_._%'),
  "password" TEXT NOT NULL
);

-- CRIAR TABELA DE PHONES

CREATE TYPE phone AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
  "number" VARCHAR(11) NOT NULL,
  "type" phone NOT NULL
);