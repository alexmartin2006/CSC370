USE car_maintenance;

-- Return the appointment history for a specific vehicle (Goal 1 - Sprint 2)
SELECT
    Vehicle.vehicle_id,
    ServiceAppointment.appointment_id,
    ServiceAppointment.appointment_datetime,
    ServiceAppointment.status,
    ServiceAppointment.notes
FROM Vehicle
JOIN ServiceAppointment
    ON Vehicle.vehicle_id = ServiceAppointment.vehicle_id
WHERE Vehicle.vehicle_id = 1
ORDER BY ServiceAppointment.appointment_datetime;

-- Return upcoming scheduled appointments in date order (Goal 1 - Sprint 2)
SELECT
    ServiceAppointment.appointment_id,
    ServiceAppointment.vehicle_id,
    ServiceAppointment.appointment_datetime,
    ServiceAppointment.status,
    ServiceAppointment.notes
FROM ServiceAppointment
WHERE ServiceAppointment.status = 'Scheduled'
    AND ServiceAppointment.appointment_datetime >= '2026-11-07'
ORDER BY ServiceAppointment.appointment_datetime;

-- Return all parts and their inventory information (Goal 2 - Sprint 2)
SELECT
    Part.part_id,
    Part.part_name,
    Part.manufacturer,
    Inventory.quantity_in_stock,
    Inventory.reorder_level
FROM Part
JOIN Inventory
    ON Part.part_id = Inventory.part_id
ORDER BY Part.part_id;

-- Return parts at or below their reorder level (Goal 2 - Sprint 2)
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

-- Return the total number of units in inventory (Goal 2 - Sprint 2)
SELECT
    SUM(Inventory.quantity_in_stock) AS total_units
FROM Inventory;

-- Return the most frequently used parts (Goal 2 - Sprint 2)
SELECT
    Part.part_id,
    Part.part_name,
    SUM(JobPart.quantity) AS total_used
FROM Part
JOIN JobPart
    ON Part.part_id = JobPart.part_id
GROUP BY Part.part_id, Part.part_name
ORDER BY total_used DESC;