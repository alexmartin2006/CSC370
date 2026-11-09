# Car Maintenance Tracker

A relational database project for **CSC 370: Database Systems** at the University of Victoria.

Tracks vehicle owners, vehicles, work orders, service jobs, parts, technicians, and recommended maintenance schedules.


## Files

- **`kickoff_goals.md`** – Initial project goals.
- **`sprint2_goals.md`** – Sprint 2 goals and implementation notes.
- **`sprint3_goals.md`** – Sprint 3 goals.
- **`conceptual_erd.png`** – Conceptual ER diagram.
- **`erd.png`** – Relational ER diagram.
- **`schema.md`** – Tables, keys, attributes, and examples.
- **`bcnf_verification.md`** – Functional dependencies, candidate keys, and BCNF review.
- **`database.sql`** – Creates the tables and constraints.
- **`example-data.sql`** – Inserts sample records.
- **`queries.sql`** – Service appointment and inventory queries.
- **`advanced_queries.sql`** – Maintenance cost analysis and maintenance evaluation.
- **`integrity_tests.sql`** – Sprint 2 constraint and functionality tests.


## Running the Project

1. Run `database.sql` in MySQL Workbench.
2. Run `example-data.sql` to populate the tables.
3. Run `queries.sql` to test service appointment and inventory queries.
4. Run `advanced_queries.sql` to evaluate maintenance costs and service intervals.
5. Run the numbered tests in `integrity_tests.sql` individually:
   - Tests 1–5 should fail because they violate database constraints.
   - Test 6 updates inventory, checks the low-stock results, and restores the original quantity.
   - Test 7 adds a technician, verifies the service job cost, and rolls back the change.

**Note:** `database.sql` deletes and recreates the database, removing existing data.

## Sprint 2 Updates

- Added ServiceAppointment to manage scheduled, completed, and cancelled appointments.
- Added Inventory to track stock quantities and reorder levels.
- Created queries to retrieve appointment information and identify low-stock parts.
- Added Advanced SQL queries to calculate maintenance costs and evaluate recommended service intervals.
- Expanded integrity testing to verify new constraints, inventory updates, and maintenance cost calculations.

## Known Limitations

- **Odometer validation:** The database ensures odometer readings are nonnegative but does not enforce that a WorkOrder's odometer reading is less than or equal to the Vehicle's current_odometer. This would require additional validation across tables, such as a trigger.

## References & Tools

- **CSC 370 course materials** – Database design and SQL concepts.
- **Lucidchart** – ER diagrams.
- **MySQL Workbench** – Database implementation and testing.
- **ChatGPT (OpenAI)** – Assisted with explaining concepts, reviewing schema and SQL, suggesting integrity tests, and drafting documentation. AI-generated suggestions require student review and verification.

## Author

**Alex Martin**  
CSC 370 – Database Systems  
University of Victoria
