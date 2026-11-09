-- SPRINT 2 INTEGRITY TESTS
-- Execute each test separately. Tests 1-5 should fail.

-- 1. FOREIGN KEY: Appointment references a nonexistent vehicle
INSERT INTO ServiceAppointment
    (appointment_id, vehicle_id, appointment_datetime, status)
VALUES (900, 999, '2026-11-15 10:00:00', 'Scheduled');

-- 2. CHECK: Invalid appointment status
INSERT INTO ServiceAppointment
    (appointment_id, vehicle_id, appointment_datetime, status)
VALUES (901, 1, '2026-11-15 10:00:00', 'Pending');

-- 3. CHECK: Inventory quantity cannot be negative
UPDATE Inventory
SET quantity_in_stock = -5
WHERE part_id = 1;

-- 4. PRIMARY KEY: Part 1 already has an inventory record
INSERT INTO Inventory
    (part_id, quantity_in_stock, reorder_level)
VALUES (1, 10, 5);

-- 5. FOREIGN KEY: Part 999 does not exist
INSERT INTO Inventory
    (part_id, quantity_in_stock, reorder_level)
VALUES (999, 10, 5);

-- 6. UPDATE: Verify that changing inventory affects low-stock results (Part 1 should appear in result)
UPDATE Inventory
SET quantity_in_stock = 2
WHERE part_id = 1;

-- Check that Part 1 now appears in the low-stock results
SELECT
    Part.part_id,
    Part.part_name,
    Inventory.quantity_in_stock,
    Inventory.reorder_level
FROM Part
JOIN Inventory
    ON Part.part_id = Inventory.part_id
WHERE Inventory.quantity_in_stock <= Inventory.reorder_level
ORDER BY Part.part_id;

-- Restore the original inventory quantity
UPDATE Inventory
SET quantity_in_stock = 12
WHERE part_id = 1;

-- 7. COST VALIDATION: Adding a technician should not change service job costs
START TRANSACTION;

INSERT INTO JobTechnician (service_job_id, technician_id)
VALUES (2, 2);

-- Show the total cost of ServiceJob 2
SELECT
    labour_cost + (
        SELECT SUM(quantity * unit_cost)
        FROM JobPart
        WHERE service_job_id = 2
    ) AS total_cost
FROM ServiceJob
WHERE service_job_id = 2;

-- Restore the original technician assignments
ROLLBACK;
