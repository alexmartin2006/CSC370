# Car Maintenance Tracker — Sprint 2 Success Criteria & Evidence

This document maps the success criteria in `sprint2_goals.md` to the submitted implementation and representative results. SQL scripts and diagrams in the repository provide the underlying evidence. Results below reflect the project's sample data and previously checked MySQL outputs.

## Goal 1 — Service Appointments

| Success criterion | Evidence / result |
|---|---|
| Add appointment relation and update both ERDs, SQL and schema | `conceptual_erd.png`, `erd.png`, `database.sql` (`CREATE TABLE ServiceAppointment`), `schema.md`. Each appointment references one vehicle; a vehicle may have multiple appointments. |
| Enforce required fields, valid statuses and foreign keys | `database.sql`: required IDs/date/status, status CHECK (`Scheduled`, `Completed`, `Cancelled`), and vehicle FK. `integrity_tests.sql` Tests **1–2** reject nonexistent vehicles and invalid statuses. |
| At least five appointments across two vehicles and three statuses | `example-data.sql`: **6 appointments**, Vehicles **1–2**; **3 Scheduled, 2 Completed, 1 Cancelled**. |
| Two appointment queries | `queries.sql`: **appointment history for a vehicle** and **upcoming scheduled appointments**. Expected: Vehicle 1 appointments **1, 2, 3**; upcoming scheduled appointments **1, 4, 6**, using the query's fixed reference date of November 7, 2026. |
| Validate results and reject invalid vehicle reference | `queries.sql` results as above; `integrity_tests.sql` **Test 1** must produce an FK error for `vehicle_id = 999`. |

## Goal 2 — Parts Inventory

| Success criterion | Evidence / result |
|---|---|
| Add inventory and enforce valid stock | `conceptual_erd.png`, `erd.png`, `schema.md`, and `database.sql` (`CREATE TABLE Inventory`). `part_id` is both PK and FK, allowing at most one inventory row per part. Stock and reorder levels have nonnegative CHECK constraints. |
| At least five records and two low-stock parts | `example-data.sql`: **5 inventory rows**. Parts **2, 3 and 5** are at or below reorder level (three qualifying parts). |
| Three required inventory queries | `queries.sql`: **parts at/below reorder level** (IDs **2, 3, 5**), **total stock** (**24 units**), **most-used parts** (Part **2**, total quantity **3**). |
| Update stock and verify query changes | `integrity_tests.sql` **Test 6**: Part 1 changes from **12** to **2** units (reorder level **5**), appears in low-stock results, then is restored to **12**. |
| Reject negative stock and duplicate part ID | `integrity_tests.sql` **Test 3**: negative stock CHECK error; **Test 4**: duplicate Inventory primary-key error. **Test 5** additionally checks an invalid part FK. |

## Goal 3 — Maintenance Cost Analysis

| Success criterion | Evidence / result |
|---|---|
| Four cost queries | `advanced_queries.sql`, **Goal 3 Queries 1–4**: (1) parts per service job; (2) labour + parts per job; (3) total per work order; (4) total spending per vehicle. |
| Manually verify two service jobs and a multi-job work order | See calculations below; SQL results are in Goal 3 **Queries 2–3**. |
| Additional technician must not change costs | `integrity_tests.sql` **Test 7** temporarily assigns Technician 2 to ServiceJob 2, returns **$120.44** (same as before), then uses `ROLLBACK` to undo the assignment. |
| Avoid double-counting | Queries **2–4** first aggregate `JobPart` into **one parts total per service job**, then add each job's labour **once**. They do **not** join `JobTechnician` into the cost calculation, so multiple technician assignments cannot multiply the cost rows. `COALESCE` treats missing parts totals as zero. |

**Manual cost verification**

| Record | Calculation | Expected SQL result |
|---|---|---:|
| ServiceJob 1 | $350.85 labour + $60.43 parts | **$411.28** |
| ServiceJob 2 | $80.00 labour + $40.44 parts | **$120.44** |
| WorkOrder 7 (Jobs 1 + 2) | $411.28 + $120.44 | **$531.72** |
| Vehicle 1 (additional cross-check) | WorkOrder 7 $531.72 + WorkOrder 8 $125.44 | **$657.16** |

## Goal 4 — Upcoming Maintenance Evaluation (Adjusted Scope)

The original goal included automatically calculating months elapsed and returning a `Due`/`Not Due` status. **These two elements were not implemented.** As explained in `sprint2_goals.md` → **Sprint 2 Implementation Notes**, the scope was adjusted to align with Advanced SQL techniques covered in CSC 370. The queries return the relevant evidence for **manual** maintenance-status evaluation.

| Success criterion | Evidence / result |
|---|---|
| Find latest service and compare intervals | `advanced_queries.sql`, **Goal 4 Test Cases 1–3**: most recent service selected using date ordering and `LIMIT 1`; kilometres since service are calculated; the service date and recommended kilometre/month intervals are displayed. **Months elapsed are not computed by SQL.** |
| Return maintenance status | **Revised / not automated**: status is determined manually from the returned values rather than output as a SQL column. See the implementation note in `sprint2_goals.md`. |
| Four demonstration scenarios | `advanced_queries.sql`, **Goal 4 Test Cases 1–4**; results summarized below. |
| Verify results against expectations | Compare the returned values with the intervals. A service is considered due when **either** its distance or time limit is reached, using a November 2026 reference date. |

| Test case | Evidence from query | Manual conclusion |
|---|---|---|
| Vehicle 1 — oil change | **0 km** since service; interval **10,000 km / 6 months** | **Not due** |
| Vehicle 2 — oil change | **21,500 km** since service; interval **10,000 km / 6 months** | **Due by distance** |
| Vehicle 3 — brake service | Last service **June 1, 2025**; interval **12 months** | **Due by time** |
| Vehicle 3 — oil change | `NOT EXISTS` finds **no recorded oil-change service** | **No history recorded** |

## Reproduction

Run `database.sql`, then `example-data.sql`, followed by `queries.sql` and `advanced_queries.sql`. Run each test in `integrity_tests.sql` separately where instructed: **Tests 1–5 intentionally fail** for the indicated constraints; **Tests 6–7** demonstrate working behaviour and restore the original data. See `README.md` for execution instructions. The SQL source files, not this summary, are the reproducible evidence.
