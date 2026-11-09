
# Car Maintenance Tracker

A relational database project for **CSC 370: Database Systems** at the University of Victoria.

Tracks vehicle owners, vehicles, work orders, service jobs, parts, technicians, service appointments, inventory, and recommended maintenance schedules.

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
- **`Sprint2_Success_Criteria_Evidence.md`** – Maps Sprint 2 success criteria to implementation evidence and expected results.

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

## Sprint 1 Feedback and Improvements

Following Sprint 1, I reviewed the TA's feedback and made several improvements to the database.

- **Manufacturer uniqueness:** Added `UNIQUE` to `Make.make_name` to prevent duplicate manufacturers.
- **Model uniqueness:** Added `UNIQUE (make_id, model_name)` to prevent duplicate model names under the same manufacturer while allowing different manufacturers to use the same model name.
- **Part identification:** Added `UNIQUE (manufacturer, part_number)` to prevent duplicate parts from the same manufacturer while allowing different manufacturers to use identical part numbers.
- **Deletion behaviour:** Reviewed the foreign-key relationships and decided to retain MySQL's default restrictive deletion behaviour rather than explicitly adding `ON DELETE RESTRICT`, since it produces the same result for the existing relationships.

One suggestion remains a documented limitation:

- **Odometer validation:** The database does not enforce that a work order's odometer reading is less than or equal to the vehicle's current odometer. Enforcing this would require validation across tables, such as a trigger.

It was also confirmed that the existing `ServiceJob` structure, ERD implementation, monetary data types, and integrity constraints were appropriate. These were retained and extended during Sprint 2.

## Sprint 2 Updates

- Added `ServiceAppointment` to manage scheduled, completed, and cancelled appointments.
- Added `Inventory` to track stock quantities and reorder levels.
- Created queries to retrieve appointment information and identify low-stock parts.
- Added Advanced SQL queries to calculate maintenance costs and evaluate recommended service intervals.
- Expanded integrity testing to verify new constraints, inventory updates, and maintenance cost calculations.
- Documented the adjustment to Goal 4, where maintenance status is evaluated manually rather than automatically calculated.

## Known Limitations

- **Odometer validation:** The database does not enforce that a `WorkOrder` odometer reading is less than or equal to the `Vehicle` current odometer. This requires additional validation across tables.
- **Maintenance evaluation:** The queries retrieve the most recent service record, kilometres driven, and recommended maintenance intervals, but determining whether maintenance is due still requires manual interpretation. Automatic status calculation is planned for Sprint 3.
- **Inventory updates:** Inventory quantities are currently adjusted manually rather than automatically when parts are assigned to service jobs. Transaction-based updates are planned for Sprint 3.

## References & Tools

- **CSC 370 course materials** – Database design and SQL concepts.
- **Lucidchart** – ER diagrams.
- **MySQL Workbench** – Database implementation and testing.
- **ChatGPT (OpenAI)** – Assisted with explaining database concepts, reviewing SQL and schema design, suggesting integrity tests, and drafting documentation. I reviewed these suggestions, executed the SQL in MySQL Workbench, and checked results against expected outcomes to support my understanding of the course material.

## Author

**Alex Martin**  
CSC 370 – Database Systems  
University of Victoria
