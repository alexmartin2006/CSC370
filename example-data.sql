
USE car_maintenance;

-- Owner
INSERT INTO Owner (
    owner_id,
    first_name,
    last_name,
    email,
    phone
)
VALUES 
    (1, 'John', 'Smith', 'jsmith@mail.com', '123-456-7890'),
    (2, 'Sarah', 'Lee', 'slee@icloud.com', '098-765-4321');


-- Make
INSERT INTO Make (
    make_id,
    make_name
)
VALUES 
    (1, 'Subaru'),
    (2, 'Honda');


-- Model
INSERT INTO Model (
    model_id,
    make_id,
    model_name
)
VALUES
    (1, 1, 'Impreza'),
    (2, 1, 'Forester'),
    (3, 2, 'CR-V'),
    (4, 2, 'Civic');


-- Vehicle
INSERT INTO Vehicle (
    vehicle_id,
    owner_id,
    model_id,
    year,
    vin,
    licence_plate,
    current_odometer
)
VALUES 
    (1, 1, 1, 2006, 'JF1GD706X6L512345', 'ABC123', 103800),
    (2, 1, 2, 2022, '2HKRW2H89NH123457', 'DEF456', 31500),
    (3, 2, 3, 2019, '5YFBURHE7KP123458', 'GHI789', 68400);


-- ServiceType
INSERT INTO ServiceType (
    service_type_id,
    service_name,
    description
)
VALUES
    (1, 'Brake Service', 'Inspect or replace brake pads and rotors'),
    (2, 'Oil Change', 'Replace engine oil and oil filter');


-- Part
INSERT INTO Part (
    part_id,
    part_name,
    manufacturer,
    part_number
)
VALUES
    (1, 'Brake Pads', 'Brembo', '1DSF9FD7'),
    (2, 'Oil 5W40', 'Motul', '4FHDJ87T');


-- Technician
INSERT INTO Technician (
    technician_id,
    first_name,
    last_name
)
VALUES
    (1, 'Mike', 'Brown'),
    (2, 'Ava', 'Leigh');


-- WorkOrder
-- One WorkOrder represents one vehicle visit.
INSERT INTO WorkOrder (
    work_order_id,
    vehicle_id,
    service_date,
    odometer,
    notes
)
VALUES
    (
        7,
        1,
        '2026-09-15',
        102503,
        'Oil change and front brake pads'
    ),
    (
        8,
        1,
        '2026-10-01',
        103800,
        'Oil change'
    );


-- ServiceJob
-- WorkOrder 7 contains TWO jobs:
--     brake service
--     oil change
-- WorkOrder 8 contains ONE oil-change job.
INSERT INTO ServiceJob (
    service_job_id,
    work_order_id,
    service_type_id,
    labour_cost
)
VALUES
    (1, 7, 1, 350.85),
    (2, 7, 2, 80.00),
    (3, 8, 2, 85.00);


-- JobPart
-- Parts are associated directly with the job in which they were used.
INSERT INTO JobPart (
    service_job_id,
    part_id,
    quantity,
    unit_cost
)
VALUES
    (1, 1, 1, 60.43),
    (2, 2, 1, 40.44),
    (3, 2, 1, 40.44);


-- JobTechnician
-- Job 1 has two technicians to demonstrate the M:N relationship.
-- Technician 1 also works on multiple jobs.
INSERT INTO JobTechnician (
    service_job_id,
    technician_id
)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 1);


-- MaintenanceSchedule
INSERT INTO MaintenanceSchedule (
    maintenance_schedule_id,
    model_id,
    schedule_name
)
VALUES
    (1, 1, 'Impreza Normal Maintenance'),
    (2, 1, 'Impreza Severe Service'),
    (3, 2, 'Forester Normal Maintenance');


-- ScheduleService
-- A schedule can recommend several service types,
-- and a service type can appear in several schedules.
INSERT INTO ScheduleService (
    maintenance_schedule_id,
    service_type_id,
    kilometre_interval,
    month_interval
)
VALUES
    (1, 1, 20000, 12),
    (1, 2, 10000, 6),

    (2, 1, 15000, 12),
    (2, 2, 5000, 3),

    (3, 1, 20000, 12),
    (3, 2, 10000, 6);


-- Sprint 2: additional service type and parts for realistic test coverage.
INSERT INTO ServiceType (service_type_id, service_name, description)
VALUES (3, 'Tire Rotation', 'Rotate tyres to balance tread wear');

INSERT INTO Part (part_id, part_name, manufacturer, part_number)
VALUES
    (3, 'Oil Filter', 'Subaru', '15208AA170'),
    (4, 'Brake Rotor', 'Brembo', '09A12311'),
    (5, 'Air Filter', 'Denso', '143-3606');


-- Sprint 2 Goal 1: at least five appointments over two vehicles.
INSERT INTO ServiceAppointment (
    appointment_id, vehicle_id, appointment_datetime, status, notes
)
VALUES
    (1, 1, '2026-11-10 09:00:00', 'Scheduled', 'Winter tire change'),
    (2, 1, '2026-10-01 08:30:00', 'Completed', 'Oil-change appointment'),
    (3, 1, '2026-11-12 13:00:00', 'Cancelled', 'Customer cancelled inspection'),
    (4, 2, '2026-11-16 10:00:00', 'Scheduled', 'Routine service'),
    (5, 2, '2026-10-15 14:00:00', 'Completed', 'Oil-change appointment'),
    (6, 2, '2026-11-20 11:00:00', 'Scheduled', 'Brake inspection');


-- Sprint 2 Goal 2: five parts, with parts 2, 3 and 5 at/below reorder levels.
INSERT INTO Inventory (part_id, quantity_in_stock, reorder_level)
VALUES
    (1, 12, 5),
    (2,  3, 3),
    (3,  0, 2),
    (4,  7, 5),
    (5,  2, 2);


-- Sprint 2 Goal 4: additional service histories for due-status testing.
-- Vehicle 2: oil change is due by km (31500 - 10000 >= 10000).
-- Vehicle 3: brake service is due by time (last done 2025-06-01).
-- Vehicle 3 has NO oil-change history.
INSERT INTO WorkOrder (
    work_order_id, vehicle_id, service_date, odometer, notes
)
VALUES
    (9, 2, '2026-10-15', 10000, 'Older mileage oil change for due-by-km example'),
    (10, 3, '2025-06-01', 67000, 'Brake inspection for due-by-time example');

INSERT INTO ServiceJob (
    service_job_id, work_order_id, service_type_id, labour_cost
)
VALUES
    (4, 9, 2, 95.00),
    (5, 10, 1, 125.00);

INSERT INTO JobPart (service_job_id, part_id, quantity, unit_cost)
VALUES
    (4, 2, 1, 42.00),
    (4, 3, 1, 19.00),
    (5, 1, 1, 65.00);

INSERT INTO JobTechnician (service_job_id, technician_id)
VALUES
    (4, 2),
    (5, 2);


-- Vehicle 3 gets one schedule to support due-by-time and no-history cases.
INSERT INTO MaintenanceSchedule (
    maintenance_schedule_id, model_id, schedule_name
)
VALUES
    (4, 3, 'CR-V Normal Maintenance');

INSERT INTO ScheduleService (
    maintenance_schedule_id, service_type_id, kilometre_interval, month_interval
)
VALUES
    (4, 1, 20000, 12),
    (4, 2, 10000, 6);


-- Sprint 2: inspect the populated tables.
SELECT * FROM Owner;
SELECT * FROM Make;
SELECT * FROM Model;
SELECT * FROM Vehicle;
SELECT * FROM ServiceType;
SELECT * FROM Part;
SELECT * FROM Technician;
SELECT * FROM WorkOrder;
SELECT * FROM ServiceJob;
SELECT * FROM JobPart;
SELECT * FROM JobTechnician;
SELECT * FROM MaintenanceSchedule;
SELECT * FROM ScheduleService;
SELECT * FROM ServiceAppointment ORDER BY appointment_datetime;
SELECT * FROM Inventory ORDER BY part_id;