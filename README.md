# Car Maintenance Tracker

A relational database project for **CSC 370: Database Systems** at the University of Victoria.

The project tracks vehicle owners, vehicles, work orders, service jobs, parts, technicians, and recommended maintenance schedules.

## Files

- **`kickoff_goals.md`** – Initial project goals.
- **`sprint1_goals.md`** – Sprint 1 goals and improvements.
- **`sprint2_goals.md`** – Planned Sprint 2 development.
- **`conceptual_erd.png`** – Conceptual Entity-Relationship Diagram.
- **`erd.png`** – Relational Entity-Relationship Diagram.
- **`schema.md`** – Relations, attributes, keys, and example data.
- **`database.sql`** – Creates the database, tables, and constraints.
- **`example-data.sql`** – Inserts sample records.
- **`queries.sql`** – Queries used to retrieve and test data.

## Running the Project

1. Run `database.sql` in MySQL Workbench to create the database and tables.
2. Run `example-data.sql` to populate the tables.
3. Run `queries.sql` to retrieve and test data.

**Note:** `database.sql` recreates the database and deletes existing data.

## Sprint 1 Updates

Replaced service records with **WorkOrder**, **ServiceJob**, and **JobPart**; added technician assignments and maintenance schedules; and improved key and data-integrity constraints.

## References & Tools

- **CSC 370 course materials** – Database design and SQL concepts.
- **Lucidchart** – ER diagrams.
- **MySQL Workbench** – Database implementation and testing.
- **ChatGPT (OpenAI)** – Assisted with explaining database concepts, reviewing design and SQL, and drafting documentation. AI suggestions were reviewed as part of the student's development process.

## Author

**Alex Martin**  
CSC 370 – Database Systems  
University of Victoria
