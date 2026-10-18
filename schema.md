# Car Maintenance Tracker - Schema Examples

The following tables provide example values for each relation. The examples use consistent primary and foreign keys to demonstrate relationships between tables. All records are fictional.

## Owner

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | owner_id | INT | 1 | 2 |
| | first_name | VARCHAR(50) | Alex | Jordan |
| | last_name | VARCHAR(50) | Martin | Smith |
| | email | VARCHAR(255) | alex@example.com | jordan@example.com |
| | phone | VARCHAR(32) | 250-555-0101 | 250-555-0102 |

## Make

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | make_id | INT | 1 | 2 |
| | make_name | VARCHAR(50) | Subaru | Honda |

## Model

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | model_id | INT | 1 | 2 |
| FK | make_id | INT | 1 | 2 |
| | model_name | VARCHAR(50) | WRX | Civic |

## Vehicle

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

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | work_order_id | INT | 1 | 2 |
| FK | vehicle_id | INT | 1 | 2 |
| | service_date | DATE | 2026-10-10 | 2026-10-12 |
| | odometer | INT | 144500 | 81500 |
| | labour_cost | DECIMAL(10,2) | 180.00 | 95.00 |
| | notes | VARCHAR(500) | Oil change and brake inspection | Routine maintenance |

## ServiceType

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | service_type_id | INT | 1 | 2 |
| | service_name | VARCHAR(100) | Oil Change | Brake Inspection |
| | description | VARCHAR(255) | Replace engine oil and filter | Inspect brake components |

## ServiceJob

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | service_job_id | INT | 1 | 2 |
| FK | work_order_id | INT | 1 | 1 |
| FK | service_type_id | INT | 1 | 2 |

Both service jobs belong to WorkOrder 1, demonstrating that one work order can contain multiple services.

## Part

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK | part_id | INT | 1 | 2 |
| | part_name | VARCHAR(100) | Oil Filter | Brake Cleaner |
| | manufacturer | VARCHAR(255) | Subaru | CRC |
| | part_number | VARCHAR(100) | 15208AA170 | 05089 |

## JobPart

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|---|---|---|
| PK, FK | service_job_id | INT | 1 | 2 |
| PK, FK | part_id | INT | 1 | 2 |
| | quantity | INT | 1 | 1 |
| | unit_cost | DECIMAL(10,2) | 18.50 | 12.99 |

JobPart associates the oil filter with ServiceJob 1 and brake cleaner with ServiceJob 2.

## Technician

| Key | Attribute | Type | Example 1 | Example 2 |
|---|---|
