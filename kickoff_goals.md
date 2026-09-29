# Car Maintenance Tracker - Project Goals

## Project Overview

The Car Maintenance Tracker is a relational database for storing and
querying vehicle maintenance information.

The database should be able to track:

- Vehicle owners and the vehicles they own.
- Basic vehicle information such as make, model, year, VIN, etc...
- Individual service records for each vehicle
- The types of services performed on a vehicle.
- Parts used during a service, multiple parts can be associated with a single service record.
- The maintenance and service history of an individual vehicle.

---

## Goal 1 - Create a Conceptual Database Design

Create a conceptual Entity-Relationship Diagram (ERD) that models the database.

### Success Criteria

- Identify the main entity sets required by the system.
- Define appropriate attributes and identifiers for each entity set.
- Define the relationships between entity sets.
- Represent the multiplicity of each relationship.
- Produce a complete conceptual ERD using the notation taught in CSC 370.

---

## Goal 2 - Create a Relational Database Design

Translate the conceptual model into a relational design that can be
implemented as a relational database.

### Success Criteria

- Convert the conceptual model into relations.
- Define a primary and foreign keys for each relation.
- Use mapping relations where required for many-to-many relationships.
- Produce a relational diagram showing the completed schema.

---

## Goal 3 - Implement the Database in MySQL

Create a working MySQL implementation of the relational design.

### Success Criteria

- Create the database and required tables using SQL.
- Use appropriate SQL data types.
- Implement primary key constraints.
- Implement foreign key constraints.
- Successfully execute the database without SQL errors.

---

## Goal 4 - Populate the Database with Example Data and Test Using SQL Queries

Populate the database with sufficient example data to demonstrate the
relationships in the database and create SQL queries to test that the
data can be retrieved correctly.

### Success Criteria

- Populate all tables with example data.
- Include enough data to demonstrate one-to-many and many-to-many relationships.
- Include vehicles with multiple service records, service types, and parts.
- Retrieve data from individual tables.
- Use joins to combine related information from multiple tables.
- Demonstrate that primary and foreign keys correctly maintain relationships between tables. 

---

## Goal 5 - Document the Database Design

Document the structure and reasoning behind the Car Maintenance Tracker
database.

### Success Criteria

- Describe each relation and its purpose.
- Identify primary and foreign keys.
- Explain important relationships between relations.
- Explain the purpose of mapping tables used for many-to-many relationships.
- Provide enough documentation for another person to understand the
  structure of the database.
