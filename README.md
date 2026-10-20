# Car Maintenance Tracker

A relational database project for **CSC 370: Database Systems** at the University of Victoria.

Tracks vehicle owners, vehicles, work orders, service jobs, parts, technicians, and recommended maintenance schedules.

## Files

- **`kickoff_goals.md`** – Initial project goals.
- **`sprint1_goals.md`** – Sprint 1 goals.
- **`sprint2_goals.md`** – Planned Sprint 2 development.
- **`conceptual_erd.png`** – Conceptual ER diagram.
- **`erd.png`** – Relational ER diagram.
- **`schema.md`** – Tables, keys, attributes, and examples.
- **`bcnf_verification.md`** – Functional dependencies, candidate keys, and BCNF review.
- **`database.sql`** – Creates the tables and constraints.
- **`example-data.sql`** – Inserts sample records.
- **`queries.sql`** – Retrieves maintenance information.
- **`integrity_tests.sql`** – Tests key, foreign-key, and data constraints.

## Running the Project

1. Run `database.sql` in MySQL Workbench.
2. Run `example-data.sql` to populate the tables.
3. Run `queries.sql` to retrieve data.
4. Run each numbered test in `integrity_tests.sql` **separately**. The six test inserts are expected to fail; Test 6 also has setup and cleanup statements.

**Note:** `database.sql` deletes and recreates the database, removing existing data.

## Sprint 1 Updates

Replaced service records with **WorkOrder**, **ServiceJob**, and **JobPart**; added technician assignments and maintenance schedules; and improved data integrity using keys and constraints. Functional dependencies and BCNF are reviewed separately.

## References & Tools

- **CSC 370 course materials** – Database design and SQL concepts.
- **Lucidchart** – ER diagrams.
- **MySQL Workbench** – Database implementation and testing.
- **ChatGPT (OpenAI)** – Assisted with explaining concepts, reviewing schema and SQL, suggesting integrity tests, and drafting documentation. AI-generated suggestions require student review and verification.

## Author

**Alex Martin**  
CSC 370 – Database Systems  
University of Victoria
