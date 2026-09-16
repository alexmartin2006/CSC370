# Car Maintenance Tracker - Relational Schema

## Overview

The Car Maintenance Tracker is a relational database designed to store information about vehicle owners, vehicles, maintenance visits, service types, and parts used during maintenance.

The schema is designed so that:

- one owner can have multiple vehicles;
- one manufacturer can have multiple models;
- one vehicle can have multiple service records;
- one service record can include multiple types of service;
- one service record can use multiple parts;
- the same service type or part can be reused across many service records.

The schema also uses bridge tables to represent many-to-many relationships while avoiding repeated or multi-valued data.

---

# Owner

The `Owner` table stores information about people who own vehicles.

| Field | Type | Key | Description |
|---|---|---|---|
| owner_id | INT | PK | Unique identifier for an owner |
| first_name | VARCHAR(50) | | Owner's first name |
| last_name | VARCHAR(50) | | Owner's last name |
| email | VARCHAR(254) | | Owner's email address |
| phone | VARCHAR(32) | | Owner's phone number |

## Example

| owner_id | first_name | last_name | email | phone |
|---|---|---|---|---|
| 1 | Alex | Martin | alex@example.com | 250-555-1234 |
| 2 | Sarah | Lee | sarah@example.com | 250-555-5678 |

## Design Reasoning
The `Owner` table seperates information about a person from information about their vehicle(s).
Since an owner can have multiple vehicles, storing owner information inside a vehicle table would create duplicates.
Instead, the vehicle table stores an `owner_id` foreign key that refrences the appropriate owner.

## Make
- Schema

## Model
- Schema
- Design reasoning

## Vehicle
- Schema
- Example

## ServiceType
- Schema

## ServiceRecord
- Schema
- Example

## ServiceRecordType
- Schema
- Example
- Why the bridge table exists

## Part
- Schema

## ServicePart
- Schema
- Example
- Why the bridge table exists

## Relationship Summary

## Normalization / Design Decisions
