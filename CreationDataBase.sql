-- ============================================================================
-- Airline Company Database Creation Script
-- Purpose: Create the complete database schema for an airline management system
-- Database: compagnie_aerienne (PostgreSQL)
-- Schema: compagnieAerienne
-- ============================================================================

-- 1) Create tablespaces (directories must exist on the filesystem)
-- - tables_data: stores data tables
-- - indexes_data: stores indexes and primary keys
CREATE TABLESPACE IF NOT EXISTS tables_data LOCATION 'E:\\GithubCopilot\\ProjectsCopilot\\Backspaces\\TablesData';
CREATE TABLESPACE IF NOT EXISTS indexes_data LOCATION 'E:\\GithubCopilot\\ProjectsCopilot\\Backspaces\\Indexes';

-- 2) Create database
-- Note: This script must be executed by a user with CREATE DATABASE privilege
-- The database will use the tables_data tablespace and UTF-8 encoding
SELECT 'CREATE DATABASE compagnie_aerienne TABLESPACE tables_data ENCODING = ''UTF8'';' 
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'compagnie_aerienne');
\gexec

-- 3) Schéma et tables (dans la base compagnie_aerienne)
\conneConnect to the database and create schema
\connect compagnie_aerienne

CREATE SCHEMA IF NOT EXISTS compagnieAerienne;

SET search_path = compagnieAerienne, public;

-- ============================================================================
-- Drop existing tables in reverse dependency order
-- ============================================================================
DROP TABLE IF EXISTS compagnieAerienne.reservation CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.departure CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.client_company CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.flight CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.pilot CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.aircraft CASCADE;
DROP TABLE IF EXISTS compagnieAerienne.warehouse CASCADE;
 PRIMARY KEY,
    city TEXT NOT NULL,
    CONSTRAINT pk_warehouse PRIMARY KEY (warehouse_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Aircraft: fleet of planes owned by the airline company
-- Each aircraft is identified by a unique numeric ID and has an aircraft type
-- Aircraft are stored in warehouses
CREATE TABLE IF NOT EXISTS compagnieAerienne.aircraft (
    aircraft_id SERIAL,
    aircraft_type TEXT NOT NULL,
    seat_count INTEGER NOT NULL CHECK (seat_count > 0),
    warehouse_id INTEGER NOT NULL REFERENCES compagnieAerienne.warehouse(warehouse_id),
    CONSTRAINT pk_aircraft PRIMARY KEY (aircraft_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Pilots: company employees authorized to pilot aircraft
-- Identified by a numeric matricule (unique)
-- Contains personal information: name, city, address, age, salary
CREATE TABLE IF NOT EXISTS compagnieAerienne.pilot (
    pilot_id SERIAL,
    matricule INTEGER UNIQUE NOT NULL,
    name TEXT NOT NULL,
    residence_city TEXT,
    address TEXT,
    age INTEGER CHECK (age > 0),
    salary NUMERIC(12,2) CHECK (salary >= 0),
    CONSTRAINT pk_pilot PRIMARY KEY (pilot_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Flights: scheduled routes offered by the airline company
-- Each flight has a unique text identifier, departure/arrival cities, and times
CREATE TABLE IF NOT EXISTS compagnieAerienne.flight (
    flight_id TEXT,
    departure_city TEXT NOT NULL,
    arrival_city TEXT NOT NULL,
    departure_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    arrival_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT pk_flight PRIMARY KEY (flight_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Client companies: customers that benefit from service packages
-- Identified by a numeric ID and have a package/forfait
CREATE TABLE IF NOT EXISTS compagnieAerienne.client_company (
    client_id SERIAL,
    forfait TEXT,
    CONSTRAINT pk_client_company PRIMARY KEY (client_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Departures: actual flight operations
-- Each departure is a specific instance of a flight with:
-- - Associated flight, pilot, and aircraft
-- - Scheduled date and time (timestamp)
-- Ensures data integrity through foreign key constraints
CREATE TABLE IF NOT EXISTS compagnieAerienne.departure (
    departure_id SERIAL,
    flight_id TEXT NOT NULL REFERENCES compagnieAerienne.flight(flight_id),
    pilot_id INTEGER NOT NULL REFERENCES compagnieAerienne.pilot(pilot_id),
    aircraft_id INTEGER NOT NULL REFERENCES compagnieAerienne.aircraft(aircraft_id),
    scheduled_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT pk_departure PRIMARY KEY (departure_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- Reservations: seat bookings by client companies on specific departures
-- Tracks which client reserves how many seats for which departure
CREATE TABLE IF NOT EXISTS compagnieAerienne.reservation (
    reservation_id SERIAL,
    client_id INTEGER NOT NULL REFERENCES compagnieAerienne.client_company(client_id),
    departure_id INTEGER NOT NULL REFERENCES compagnieAerienne.departure(departure_id),
    seat_count INTEGER NOT NULL CHECK (seat_count > 0),
    CONSTRAINT pk_reservation PRIMARY KEY (reservation_id) USING INDEX TABLESPACE indexes_data
) TABLESPACE tables_data;

-- ============================================================================
-- Create indexes for performance optimization
-- All indexes are stored in the indexes_data tablespace
-- ============================================================================
CREATE INDEX IF NOT EXISTS idx_departure_scheduled_at ON compagnieAerienne.departure(scheduled_at) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_reservation_client ON compagnieAerienne.reservation(client_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_reservation_departure ON compagnieAerienne.reservation(departure_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_aircraft_warehouse ON compagnieAerienne.aircraft(warehouse_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_departure_flight ON compagnieAerienne.departure(flight_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_departure_pilot ON compagnieAerienne.departure(pilot_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_departure_aircraft ON compagnieAerienne.departure(aircraft_id) TABLESPACE indexes_data;

-- ============================================================================
-- Script completed successfully
-- ============================================================================k_reservation PRIMARY KEY (reservation_id) USING INDEX TABLESPACE indexes_data
-- Indexes (stockés dans le tablespace d'index)

CREATE INDEX IF NOT EXISTS idx_departure_scheduled_at ON compagnieAerienne.departure(scheduled_at) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_reservation_client ON compagnieAerienne.reservation(client_id) TABLESPACE indexes_data;
CREATE INDEX IF NOT EXISTS idx_reservation_departure ON compagnieAerienne.reservation(departure_id) TABLESPACE indexes_data;

-- Fin du script
