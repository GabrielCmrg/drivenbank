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

-- CRIAR TABELA DE STATES

CREATE TABLE "states" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL UNIQUE
);

-- CRIAR TABELA CITIES

CREATE TABLE "cities" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL UNIQUE,
  "stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

-- CRIAR TABELA ADDRESSES

CREATE TABLE "customerAddresses" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customers"("id") UNIQUE,
  "street" TEXT NOT NULL,
  "number" VARCHAR(6) NOT NULL,
  "complement" TEXT,
  "postalCode" VARCHAR(8) NOT NULL,
  "cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);

-- CRIAR TABELA BANK ACCOUNT

CREATE TABLE "bankAccount" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
  "accountNumber" VARCHAR(9) NOT NULL,
  "agency" VARCHAR(4) NOT NULL,
  "openDate" DATE NOT NULL DEFAULT NOW(),
  "closeDate" DATE DEFAULT NULL
);

-- CRIAR TABELA TRANSACTIONS

CREATE TYPE valid_transaction AS ENUM ('deposit', 'withdraw');

CREATE TABLE "transactions" (
  "id" SERIAL PRIMARY KEY,
  "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
  "amount" NUMERIC NOT NULL,
  "type" valid_transaction NOT NULL,
  "time" TIMESTAMP,
  "description" TEXT,
  "cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);
