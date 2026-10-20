# Sprint 1 — Functional Dependencies and BCNF

An FD `X → Y` means X determines Y. A table is in **BCNF** when the left side of every nontrivial FD is a superkey.

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
