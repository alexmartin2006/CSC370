# Car Maintenance Tracker - Schema

## Overview

The database tracks vehicle ownership, service visits, individual service jobs, parts used, technician assignments, and maintenance recommendations by vehicle model. The relational ERD shows the relationships between tables.

The tables below describe each relation, its keys, SQL data types, and two **fictional example records**. Example IDs are consistent across the tables, but the examples are illustrative and do not necessarily match `example-data.sql`. `PK, FK` indicates a column that is part of a composite primary key and also references another table.

## Owner

Stores contact information for vehicle owners.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | owner_id | INT | 1 | 2 |
| | first_name | VARCHAR(50) | Alex | Jordan |
| | last_name | VARCHAR(50) | Martin | Smith |
| | email | VARCHAR(254) | alex@example.com | jordan@example.com |
| | phone | VARCHAR(32) | 250-555-0101 | 250-555-0102 |

## Make

Stores vehicle manufacturers, such as Subaru or Honda.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | make_id | INT | 1 | 2 |
| | make_name | VARCHAR(50) | Subaru | Honda |

## Model

Stores vehicle models, each associated with one manufacturer (`Make`).

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | model_id | INT | 1 | 2 |
| FK | make_id | INT | 1 | 2 |
| | model_name | VARCHAR(50) | WRX | Civic |

## Vehicle

Stores individual vehicles, their owners, and their models.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | vehicle_id | INT | 1 | 2 |
| FK | owner_id | INT | 1 | 2 |
| FK | model_id | INT | 1 | 2 |
| | year | INT | 2013 | 2018 |
| | vin | CHAR(17) | JF1GR7E60EG123456 | 2HGFC2F59KH123456 |
| | licence_plate | VARCHAR(20) | AB123C | CD456E |
| | current_odometer | INT | 145000 | 82000 |

## WorkOrder

Represents one maintenance or repair visit for a vehicle. One work order may include several service jobs.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | work_order_id | INT | 1 | 2 |
| FK | vehicle_id | INT | 1 | 2 |
| | service_date | DATE | 2026-10-10 | 2026-10-12 |
| | odometer | INT | 144500 | 81500 |
| | notes | VARCHAR(500) | Oil change and brake inspection | Routine maintenance |

## ServiceType

Defines available categories of work, such as an oil change or brake inspection.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | service_type_id | INT | 1 | 2 |
| | service_name | VARCHAR(100) | Oil Change | Brake Inspection |
| | description | VARCHAR(255) | Replace engine oil and filter | Inspect brake components |

## ServiceJob

Represents an individual service performed under a work order and categorised by service type. Labour cost is recorded per job.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | service_job_id | INT | 1 | 2 |
| FK | work_order_id | INT | 1 | 1 |
| FK | service_type_id | INT | 1 | 2 |
| | labour_cost | DECIMAL(10,2) | 120.00 | 60.00 |

Both service jobs belong to WorkOrder 1, demonstrating that one work order can contain multiple services.

## Part

Stores reusable part definitions that may be used on different service jobs.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | part_id | INT | 1 | 2 |
| | part_name | VARCHAR(100) | Oil Filter | Brake Cleaner |
| | manufacturer | VARCHAR(255) | Subaru | CRC |
| | part_number | VARCHAR(100) | 15208AA170 | 05089 |

## JobPart

Associates parts with individual service jobs, including quantity and price. Its composite primary key is (`service_job_id`, `part_id`).

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK, FK | service_job_id | INT | 1 | 2 |
| PK, FK | part_id | INT | 1 | 2 |
| | quantity | INT | 1 | 1 |
| | unit_cost | DECIMAL(10,2) | 18.50 | 12.99 |

JobPart associates the oil filter with ServiceJob 1 and brake cleaner with ServiceJob 2.

## Technician

Stores identifying information about technicians.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | technician_id | INT | 1 | 2 |
| | first_name | VARCHAR(50) | Sam | Riley |
| | last_name | VARCHAR(50) | Johnson | Lee |

## JobTechnician

Associates technicians with service jobs to implement their many-to-many relationship. Its composite primary key is (`service_job_id`, `technician_id`).

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK, FK | service_job_id | INT | 1 | 1 |
| PK, FK | technician_id | INT | 1 | 2 |

Both technicians are assigned to ServiceJob 1, demonstrating that multiple technicians can work on the same job.

## MaintenanceSchedule

Stores named maintenance schedules for vehicle models. Each schedule belongs to one model.

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | maintenance_schedule_id | INT | 1 | 2 |
| FK | model_id | INT | 1 | 2 |
| | schedule_name | VARCHAR(100) | WRX Standard Maintenance | Civic Standard Maintenance |

## ScheduleService

Associates service types with schedules and records the recommended kilometre and month intervals. Its composite primary key is (`maintenance_schedule_id`, `service_type_id`).

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK, FK | maintenance_schedule_id | INT | 1 | 1 |
| PK, FK | service_type_id | INT | 1 | 2 |
| | kilometre_interval | INT | 10000 | 20000 |
| | month_interval | INT | 6 | 12 |

Both recommended services belong to MaintenanceSchedule 1, demonstrating that one maintenance schedule can contain multiple service recommendations.
