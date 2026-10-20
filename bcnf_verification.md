# Functional Dependencies and BCNF

An FD `X → Y` means **X determines Y**.

A table is in **Boyce-Codd Normal Form (BCNF)** if, for every nontrivial functional dependency `X → Y`, **X is a superkey**.

All 13 tables in this database satisfy BCNF under the functional dependencies and key constraints listed below because every nontrivial FD has a superkey on its left side. This helps reduce redundancy and update, insertion, and deletion anomalies.

| Table | Main functional dependency | Candidate key(s) |
|---|---|---|
| Owner | `owner_id → first_name, last_name, email, phone` | `owner_id` |
| Make | `make_id → make_name` | `make_id` |
| Model | `model_id → make_id, model_name` | `model_id` |
| Vehicle | `vehicle_id → owner_id, model_id, year, vin, licence_plate, current_odometer` | `vehicle_id`, `vin` |
| WorkOrder | `work_order_id → vehicle_id, service_date, odometer, notes` | `work_order_id` |
| ServiceType | `service_type_id → service_name, description` | `service_type_id` |
| ServiceJob | `service_job_id → work_order_id, service_type_id, labour_cost` | `service_job_id` |
| Part | `part_id → part_name, manufacturer, part_number` | `part_id` |
| JobPart | `(service_job_id, part_id) → quantity, unit_cost` | `(service_job_id, part_id)` |
| Technician | `technician_id → first_name, last_name` | `technician_id` |
| JobTechnician | No nontrivial FDs beyond those implied by the composite key | `(service_job_id, technician_id)` |
| MaintenanceSchedule | `maintenance_schedule_id → model_id, schedule_name` | `maintenance_schedule_id` |
| ScheduleService | `(maintenance_schedule_id, service_type_id) → kilometre_interval, month_interval` | `(maintenance_schedule_id, service_type_id)` |

## VIN Note

In the `Vehicle` table, `vin` is also a candidate key because each VIN uniquely identifies a vehicle. Therefore, the following is another valid FD:

`vin → vehicle_id, owner_id, model_id, year, licence_plate, current_odometer`

Although `vehicle_id` is the chosen primary key, `vin` is an alternate candidate key. Both are superkeys, so this does not violate BCNF.

**Important:** This assumes `vin` is enforced as `UNIQUE NOT NULL` in the database.
