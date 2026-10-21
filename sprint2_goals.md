# Car Maintenance Tracker — Sprint 2 Goals

## Overview

Sprint 1 improved the relational design by introducing work orders, service jobs, technician assignments, and maintenance schedules. The database now stores completed maintenance and recommended service intervals, but it cannot manage future appointments or parts inventory. It also lacks queries that calculate complete maintenance costs or identify services that are due.

Sprint 2 will address these limitations through two new database features and two Advanced SQL goals. Each goal has measurable tests that can be demonstrated in MySQL Workbench.

---

## Goal 1 — Add Service Appointments

**Current limitation:** `WorkOrder` records maintenance visits but does not distinguish planned appointments from completed work.

**Planned improvement:** Add `ServiceAppointment(appointment_id PK, vehicle_id FK, appointment_datetime, status, notes)`, connected to `Vehicle` through a 1:M relationship. Appointments will be stored separately from work orders, allowing future bookings and cancellations without treating them as completed maintenance.

**CSC 370 connection:** Relational design, primary and foreign keys, domain constraints, joins, filtering, and ordering.

**Success criteria:**
- Update both ERDs, `database.sql`, and `schema.md` with the new relation and its 1:M relationship.
- Enforce mandatory fields, valid appointment statuses, and referential integrity.
- Insert at least **5 appointments across 2 vehicles**, covering scheduled, completed, and cancelled statuses.
- Write **2 queries** to retrieve upcoming appointments in date order and appointment history for a selected vehicle.
- Verify query results and demonstrate that an invalid `vehicle_id` is rejected.

---

## Goal 2 — Add Parts Inventory

**Current limitation:** `Part` identifies available part types and `JobPart` records their use, but neither stores current stock or indicates when parts should be reordered.

**Planned improvement:** Add `Inventory(part_id PK/FK, quantity_in_stock, reorder_level)`. Each part can have at most one inventory record. Stock will initially be adjusted through SQL updates rather than automatically when parts are assigned to jobs.

**CSC 370 connection:** One-to-one relationships, composite roles of keys, `CHECK` constraints, joins, aggregation, and grouping.

**Success criteria:**
- Update both ERDs, `database.sql`, and `schema.md`; enforce unique part references and nonnegative quantities.
- Populate inventory for at least **5 parts**, with **2 or more** at or below their reorder levels.
- Write **3 queries** to identify low-stock parts, count total units in inventory, and identify the most frequently used parts.
- Change a part's stock using `UPDATE` and confirm the low-stock results change appropriately.
- Test rejection of negative stock and duplicate `part_id` values.

---

## Goal 3 — Analyze Maintenance Costs

**Current limitation:** Labour costs are recorded in `ServiceJob`, and parts costs are stored in `JobPart`, but the existing queries do not combine them into reliable totals. Joining multiple parts and technicians can repeat rows and lead to double-counting.

**Planned improvement:** Use aggregate functions, grouping, joins, and subqueries to calculate costs at the service-job, work-order, and vehicle levels. Structure the calculations so technician assignments do not inflate totals.

**CSC 370 connection:** Advanced SQL, including `SUM`, `GROUP BY`, joins, and subqueries.

**Success criteria:**
- Write at least **4 queries** for parts cost per job, total cost per job, total cost per work order, and total spending per vehicle.
- Verify the output against manually calculated totals for **2 service jobs and 1 work order containing multiple jobs**.
- Demonstrate that assigning an additional technician does not change the calculated costs.
- Explain how the queries avoid duplicate-counting caused by joining separate one-to-many relationships.

---

## Goal 4 — Detect Upcoming Maintenance

**Current limitation:** `MaintenanceSchedule` and `ScheduleService` store recommended intervals, but current queries only display those recommendations. They do not compare the intervals against a vehicle's maintenance history to determine whether servicing is due.

**Planned improvement:** Retrieve the most recent completed service of each type for a vehicle. Compare its recorded date and odometer with the current odometer and the recommended kilometre/month intervals. Mark a service as due when either interval has been reached. Report services without recorded history separately.

**CSC 370 connection:** Advanced joins, subqueries, aggregation, and date calculations.

**Success criteria:**
- Write queries to find the latest service by type and calculate kilometres and months elapsed since that service.
- Return a maintenance status based on the stored service intervals.
- Demonstrate **4 test cases**: not due, due by kilometres, due by time, and no recorded service history.
- Compare the SQL results with manually determined expected outcomes and explain any assumptions.

---

## Evidence and Deliverables

Update `conceptual_erd.png`, `erd.png`, `database.sql`, `example-data.sql`, `queries.sql`, `schema.md`, and `README.md` as needed. The Sprint 2 demonstration will show the new table relationships, working queries, expected-versus-actual results, and examples of constraints rejecting invalid data.

The goals develop course-level competencies in relational design, integrity constraints, and Advanced SQL. Specific course terminology will be checked against the Advanced SQL materials in Brightspace.
