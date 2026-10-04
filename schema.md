# Car Maintenance Tracker - Schema

## Overview

The database stores vehicle ownership, vehicle information, maintenance history, service types, and parts used during maintenance.

The relational ERD shows the database structure. This file provides a short description of each relation and its attributes.

---

## Owner

Stores information about vehicle owners.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | owner_id | INT | Unique identifier for an owner. |
|  | first_name | VARCHAR(50) | Stores the owner's first name. |
|  | last_name | VARCHAR(50) | Stores the owner's last name. |
|  | email | VARCHAR(255) | Stores the owner's email address. |
|  | phone | VARCHAR(32) | Stores the owner's phone number. |

---

## Make

Stores vehicle manufacturers.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | make_id | INT | Unique identifier for a vehicle manufacturer. |
|  | make_name | VARCHAR(50) | Stores the manufacturer name, such as Subaru or Honda. |

---

## Model

Stores specific vehicle models and connects them to a manufacturer.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | model_id | INT | Unique identifier for a vehicle model. |
| FK | make_id | INT | References the manufacturer that produces the model. |
|  | model_name | VARCHAR(50) | Stores the name of a specific vehicle model. |

---

## Vehicle

Stores information about an individual vehicle.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | vehicle_id | INT | Unique identifier for a vehicle. |
| FK | owner_id | INT | References the owner of the vehicle. |
| FK | model_id | INT | References the vehicle's model. |
|  | year | INT | Stores the model year of the vehicle. |
|  | vin | CHAR(17) | Stores the vehicle identification number. |
|  | licence_plate | VARCHAR(20) | Stores the vehicle's licence plate. |
|  | current_odometer | INT | Stores the vehicle's current odometer reading. |

---

## ServiceRecord

Stores a maintenance or repair event for a vehicle.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | service_id | INT | Unique identifier for a service record. |
| FK | vehicle_id | INT | References the vehicle being serviced. |
|  | service_date | DATE | Stores the date the service was performed. |
|  | odometer | INT | Stores the vehicle's odometer reading at the time of service. |
|  | labour_cost | FLOAT | Stores the labour cost for the service. |
|  | notes | VARCHAR(500) | Stores additional information about the service. |

---

## ServiceType

Stores the different types of maintenance or repair work that can be performed.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | service_type_id | INT | Unique identifier for a service type. |
|  | service_name | VARCHAR(100) | Stores the name of the service, such as Oil Change. |
|  | description | VARCHAR(255) | Stores a short description of the service type. |

---

## ServiceRecordType

Mapping relation between `ServiceRecord` and `ServiceType`.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK, FK | service_id | INT | References the service record where the work was performed. |
| PK, FK | service_type_id | INT | References a type of service performed during the service record. |

---

## Part

Stores information about parts used during maintenance.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK | part_id | INT | Unique identifier for a part. |
|  | part_name | VARCHAR(100) | Stores the name of the part. |
|  | manufacturer | VARCHAR(255) | Stores the manufacturer of the part. |
|  | part_number | VARCHAR(100) | Stores the manufacturer's part number. |

---

## ServicePart

Stores parts used during a service and associates them with a specific service type.

| Key | Attribute | Type | Description |
|---|---|---|---|
| PK, FK | service_id | INT | References the service record where the part was used. |
| PK, FK | part_id | INT | References the part that was used. |
| PK, FK | service_type_id | INT | References the type of service the part was used for. |
|  | quantity | INT | Stores the quantity of the part used. |
|  | unit_cost | FLOAT | Stores the cost of one unit of the part. |

