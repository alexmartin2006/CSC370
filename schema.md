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

---

# Make

The `Make` table stores vehicle manufacturers.

| Field | Type | Key | Description |
|---|---|---|---|
| make_id | INT | PK | Unique identifier for a manufacturer |
| make_name | VARCHAR(50) | | Name of the manufacturer |

## Example

| make_id | make_name |
|---|---|
| 1 | Honda |
| 2 | Mazda |
| 3 | Toyota |

## Design Reasoning

Vehicle manufactacturer names are stored sepreatly from vehicle models to avoid repeats of manufacturer names.
For example, Honda Mmanufactures many different models. `Honda` can be stored once in the `Make` table referenced by those models.

---  

# Model

The `Model` table stores vehicle models.

| Field | Type | Key | Description |
|---|---|---|---|
| model_id | INT | PK | Unique identifier for a vehicle model |
| make_id | INT | FK | References `Make(make_id)` |
| model_name | VARCHAR(50) | | Name of the vehicle model |

## Example

| model_id | make_id | model_name |
|---|---|---|
| 1 | 1 | Civic |
| 2 | 1 | Accord |
| 3 | 2 | Mazda3 |
| 4 | 2 | CX-5 |

In this example, models 1 and 2 belong to Honda, while models 3 and 4 belong to Mazda.

## Design Reasoning

The `Make` and `Model` tables are separated because one make can have many models.

For example:

- Honda can manufacture Civic, Accord, and CR-V;
- Mazda can manufacture Mazda3, CX-5, and MX-5.

The `make_id` foreign key in `Model` identifies which manufacturer produces that model.

This creates a one-to-many relationship:

`Make 1 -> many Model`
---

# Vehicle

The `Vehicle` table stores individual vehicles.

| Field | Type | Key | Description |
|---|---|---|---|
| vehicle_id | INT | PK | Unique identifier for a vehicle |
| owner_id | INT | FK | References `Owner(owner_id)` |
| model_id | INT | FK | References `Model(model_id)` |
| year | INT | | Model year |
| vin | CHAR(17) | | Vehicle Identification Number |
| licence_plate | VARCHAR(20) | | Vehicle licence plate |
| current_odometer | INT | | Current odometer reading |

## Example

| vehicle_id | owner_id | model_id | year | vin | licence_plate | current_odometer |
|---|---|---|---|---|---|---|
| 1 | 1 | 3 | 2016 | JM1BM1L75G1234567 | AB123C | 102500 |
| 2 | 1 | 1 | 2007 | 2HGFA16587H123456 | CD456E | 185000 |

Both vehicles belong to owner 1, but they are different models.

## Design Reasoning

Each vehicle is stored separately because each one has unique information such as:

- VIN;
- licence plate;
- current odometer reading;
- model year.

The `owner_id` foreign key identifies who owns the vehicle.

The `model_id` foreign key identifies which vehicle model it is.

This means one owner can have multiple vehicles and one model can also describe multiple individual vehicles.

---

# ServiceType

The `ServiceType` table stores the different types of maintenance or repair work that can be performed.

| Field | Type | Key | Description |
|---|---|---|---|
| service_type_id | INT | PK | Unique identifier for a service type |
| service_name | VARCHAR(100) | | Name of the service |
| description | VARCHAR(255) | | Description of the service |

## Example

| service_type_id | service_name | description |
|---|---|---|
| 1 | Oil Change | Replace engine oil and oil filter |
| 2 | Brake Service | Inspect or replace braking components |
| 3 | Coolant Flush | Replace engine coolant |
| 4 | Tire Rotation | Rotate vehicle tires |

## Design Reasoning

Service types are stored separately because the same service can occur many times.

For example, an oil change may appear in hundreds of different service records. Storing the text "Oil Change" repeatedly in every service record would duplicate data.

Instead, the service type is stored once and referenced when needed.

---

# ServiceRecord

The `ServiceRecord` table represents a maintenance visit or maintenance event for a vehicle.

| Field | Type | Key | Description |
|---|---|---|---|
| service_id | INT | PK | Unique identifier for a service record |
| vehicle_id | INT | FK | References `Vehicle(vehicle_id)` |
| service_date | DATE | | Date the service occurred |
| odometer | INT | | Odometer reading at the time of service |
| labour_cost | FLOAT | | Labour cost for the service visit |
| notes | VARCHAR(500) | | Additional information about the visit |

## Example

| service_id | vehicle_id | service_date | odometer | labour_cost | notes |
|---|---|---|---|---|---|
| 12 | 1 | 2026-09-15 | 102500 | 180.00 | Oil change and front brake replacement |
| 13 | 1 | 2026-12-10 | 108000 | 60.00 | Routine oil change |

## Design Reasoning

A `ServiceRecord` represents one maintenance event or visit rather than one specific type of work.

A single visit could include several different services.

For example, during service record 12 the vehicle could receive:

- an oil change;
- brake service;
- a coolant flush.

Because of this, `service_type_id` is not stored directly in the `ServiceRecord` table.

Instead, the many-to-many relationship between service records and service types is represented through the `ServiceRecordType` bridge table.

---

# ServiceRecordType

The `ServiceRecordType` table is a bridge table connecting `ServiceRecord` and `ServiceType`.

| Field | Type | Key | Description |
|---|---|---|---|
| service_id | INT | PK, FK | References `ServiceRecord(service_id)` |
| service_type_id | INT | PK, FK | References `ServiceType(service_type_id)` |

Primary Key:

`(service_id, service_type_id)`

## Example

Suppose service record 12 represents a visit where the vehicle received:

- an oil change;
- brake service;
- a coolant flush.

The relevant service types might be:

| service_type_id | service_name |
|---|---|
| 1 | Oil Change |
| 2 | Brake Service |
| 3 | Coolant Flush |

The bridge table would contain:

| service_id | service_type_id |
|---|---|
| 12 | 1 |
| 12 | 2 |
| 12 | 3 |

This means service record 12 included all three service types.

Later, another service record might also include an oil change:

| service_id | service_type_id |
|---|---|
| 13 | 1 |

## Design Reasoning

The relationship between `ServiceRecord` and `ServiceType` is many-to-many.

A single service record can contain multiple service types.

At the same time, one service type can appear in many service records.

For example:

- service record 12 may contain Oil Change, Brake Service, and Coolant Flush;
- Oil Change may also appear in service records 13, 20, 25, and many others.

Without a bridge table, multiple values might need to be stored inside one field, such as:

`service_type_id = "1,2,3"`

This would violate the relational design principle that each field should contain a single value.

The `ServiceRecordType` bridge table solves this by storing each relationship as its own row.

The two fields together form a composite primary key:

`(service_id, service_type_id)`

This prevents duplicate relationships.

For example, the following cannot appear twice:

`12, 1`

because service record 12 should only be linked to the Oil Change service type once.

---

# Part

The `Part` table stores information about vehicle parts that may be used during maintenance.

| Field | Type | Key | Description |
|---|---|---|---|
| part_id | INT | PK | Unique identifier for a part |
| part_name | VARCHAR(100) | | Name of the part |
| manufacturer | VARCHAR(255) | | Manufacturer of the part |
| part_number | VARCHAR(100) | | Manufacturer part number |

## Example

| part_id | part_name | manufacturer | part_number |
|---|---|---|---|
| 5 | Brake Rotor | Brembo | 09.A123.11 |
| 9 | Brake Pad Set | Akebono | ACT914 |
| 11 | Oil Filter | Bosch | 3323 |

## Design Reasoning

Parts are stored separately because the same part may be used in many different service records.

For example, the same type of oil filter could be used every time a particular vehicle receives an oil change.

The part information therefore only needs to be stored once.

---

# ServicePart

The `ServicePart` table is a bridge table connecting `ServiceRecord` and `Part`.

| Field | Type | Key | Description |
|---|---|---|---|
| service_id | INT | PK, FK | References `ServiceRecord(service_id)` |
| part_id | INT | PK, FK | References `Part(part_id)` |
| quantity | INT | | Number of the part used |
| unit_cost | FLOAT | | Cost of one unit of the part |

Primary Key:

`(service_id, part_id)`

## Example

Suppose service record 12 involved replacing:

- two brake rotors;
- one set of brake pads;
- one oil filter.

The `Part` table might contain:

| part_id | part_name |
|---|---|
| 5 | Brake Rotor |
| 9 | Brake Pad Set |
| 11 | Oil Filter |

The `ServicePart` table would contain:

| service_id | part_id | quantity | unit_cost |
|---|---|---|---|
| 12 | 5 | 2 | 95.00 |
| 12 | 9 | 1 | 80.00 |
| 12 | 11 | 1 | 12.00 |

This means:

- service record 12 used two units of part 5;
- service record 12 used one unit of part 9;
- service record 12 used one unit of part 11.

## Design Reasoning

The relationship between `ServiceRecord` and `Part` is also many-to-many.

One service record can use many parts.

For example, a brake service might require:

- two brake rotors;
- one brake pad set;
- brake fluid.

At the same time, the same part can appear in many service records.

Because of this, a bridge table is required.

`ServicePart` also stores attributes that belong specifically to the relationship between a service record and a part.

For example:

- `quantity` describes how many of that part were used in that service;
- `unit_cost` describes how much that part cost during that particular service.

These values do not belong only to the `Part` table because the quantity and cost can vary between different service records.

The composite primary key:

`(service_id, part_id)`

prevents the same part from being entered twice for the same service record.

---

# Relationship Summary

The database contains the following relationships:

- One `Owner` can own many `Vehicle` records.
- One `Make` can have many `Model` records.
- One `Model` can describe many `Vehicle` records.
- One `Vehicle` can have many `ServiceRecord` records.
- One `ServiceRecord` can contain many `ServiceType` records.
- One `ServiceType` can appear in many `ServiceRecord` records.
- One `ServiceRecord` can use many `Part` records.
- One `Part` can appear in many `ServiceRecord` records.

The many-to-many relationships are resolved using:

- `ServiceRecordType`;
- `ServicePart`.

---

# Normalization and Design Decisions

The database is designed to reduce duplicated information and separate different types of data into related tables.

## Repeating Data

Information that can be reused is stored once.

For example:

- Honda or Mazda is stored once in `Make`;
- Civic or Mazda3 is stored once in `Model`;
- Oil Change is stored once in `ServiceType`;
- a particular brake rotor is stored once in `Part`.

Other tables reference these records using foreign keys rather than repeating the text.

## Many-to-Many Relationships

Many-to-many relationships are represented using bridge tables.

`ServiceRecordType` resolves the relationship between:

`ServiceRecord <-> ServiceType`

`ServicePart` resolves the relationship between:

`ServiceRecord <-> Part`

This prevents multiple values from being stored in a single column.

## Composite Primary Keys

The bridge tables use composite primary keys.

For example:

`ServiceRecordType(service_id, service_type_id)`

and:

`ServicePart(service_id, part_id)`

The combination of both values uniquely identifies each relationship and prevents duplicate entries.

## Separation of Entities

Different concepts are stored in different tables.

For example:

- an owner is different from a vehicle;
- a vehicle make is different from a vehicle model;
- a service visit is different from the type of work performed;
- a part is different from its use during a particular service.

This reduces redundancy and makes the database easier to update and query.

The schema is intended to be normalized through BCNF.
