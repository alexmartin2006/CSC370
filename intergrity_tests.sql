-- CSC 370 - Sprint 1 Integrity Tests
-- Run database.sql and example-data.sql first.
-- Execute each numbered test separately in MySQL Workbench.
-- Each test INSERT is EXPECTED TO FAIL. An error means the constraint worked.
USE car_maintenance;

-- 1. FOREIGN KEY: owner_id 999 does not exist. EXPECTED: FAIL.
INSERT INTO Vehicle (vehicle_id, owner_id, model_id, year, vin, current_odometer)
VALUES (900, 999, 1, 2020, 'JF1AA11B22C333444', 10000);

-- 2. UNIQUE: Vehicle 1 already uses this VIN. EXPECTED: FAIL.
INSERT INTO Vehicle (vehicle_id, owner_id, model_id, year, vin, current_odometer)
VALUES (901, 1, 1, 2020, 'JF1GD706X6L512345', 10000);

-- 3. CHECK: labour_cost cannot be negative. EXPECTED: FAIL.
INSERT INTO ServiceJob (service_job_id, work_order_id, service_type_id, labour_cost)
VALUES (902, 7, 1, -1.00);

-- 4. COMPOSITE PRIMARY KEY: (1, 1) already exists. EXPECTED: FAIL.
INSERT INTO JobTechnician (service_job_id, technician_id)
VALUES (1, 1);

-- 5. NOT NULL: Owner.first_name is required. EXPECTED: FAIL.
INSERT INTO Owner (owner_id, first_name, last_name)
VALUES (903, NULL, 'Test');

-- 6. CHECK: month_interval must be greater than zero.
-- First run this VALID setup statement to create an unused schedule ID.
INSERT INTO MaintenanceSchedule (maintenance_schedule_id, model_id, schedule_name)
VALUES (99, 1, 'Integrity Test Schedule');

-- Now execute this test separately. EXPECTED: FAIL due to CHECK (month_interval > 0).
-- (99, 1) has valid foreign keys and does not duplicate a composite primary key.
INSERT INTO ScheduleService
    (maintenance_schedule_id, service_type_id, kilometre_interval, month_interval)
VALUES (99, 1, 10000, 0);

-- Run this cleanup statement after Test 6.
DELETE FROM MaintenanceSchedule WHERE maintenance_schedule_id = 99;
