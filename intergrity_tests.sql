-- CSC 370 - Sprint 1 integrity tests (MySQL 8.0.16+)
-- Run database.sql, then example-data.sql FIRST.
-- Execute EACH INSERT individually in MySQL Workbench.
-- ALL SIX should FAIL; none should add a row.
USE car_maintenance;

-- 1. FOREIGN KEY: Owner 999 does not exist.
INSERT INTO Vehicle (vehicle_id, owner_id, model_id, year, vin, current_odometer)
VALUES (900, 999, 1, 2020, 'JF1AA11B22C333444', 10000);

-- 2. UNIQUE: Vehicle 1 already has this VIN.
INSERT INTO Vehicle (vehicle_id, owner_id, model_id, year, vin, current_odometer)
VALUES (901, 1, 1, 2020, 'JF1GD706X6L512345', 10000);

-- 3. CHECK: Labour cost cannot be negative.
INSERT INTO ServiceJob (service_job_id, work_order_id, service_type_id, labour_cost)
VALUES (902, 7, 1, -1.00);

-- 4. COMPOSITE PRIMARY KEY: (service_job_id=1, technician_id=1) already exists.
INSERT INTO JobTechnician (service_job_id, technician_id)
VALUES (1, 1);

-- 5. NOT NULL: Owner.first_name is required.
INSERT INTO Owner (owner_id, first_name, last_name)
VALUES (903, NULL, 'Test');

-- 6. CHECK: month_interval must be greater than zero.
-- This schedule/service pair (3, 2) is not already present.
INSERT INTO ScheduleService (maintenance_schedule_id, service_type_id, kilometre_interval, month_interval)
VALUES (3, 2, 10000, 0);
