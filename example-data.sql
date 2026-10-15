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
-- Parts are now associated directly with the job in which they were used.
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


-- Test the data
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