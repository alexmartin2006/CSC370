USE car_maintenance;

-- Owner
INSERT INTO Owner (
    owner_id,
    first_name,
    last_name,
    email,
    phone
)
VALUES (
    1,
    'John',
    'Smith',
    'jsmith@mail.com',
    '123-456-7890'
);


-- Make
INSERT INTO Make (
    make_id,
    make_name
)
VALUES (
    1,
    'Subaru'
);


-- Model
INSERT INTO Model (
    model_id,
    make_id,
    model_name
)
VALUES
    (1, 1, 'Impreza'),
    (2, 1, 'Forester');


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
VALUES (
    2,
    1,
    1,
    2006,
    'JF1GD706X6L512345',
    'ABC123',
    102503
);


-- ServiceType
INSERT INTO ServiceType (
    service_type_id,
    service_name,
    description
)
VALUES
    (1, 'Brakes', 'Brake pads/rotors'),
    (2, 'Oil', 'Oil Change');


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


-- ServiceRecord
INSERT INTO ServiceRecord (
    service_id,
    vehicle_id,
    service_date,
    odometer,
    labour_cost,
    notes
)
VALUES (
    7,
    2,
    '2026-09-15',
    102503,
    430.85,
    'Oil change and front pads'
);


-- ServiceRecordType
INSERT INTO ServiceRecordType (
    service_id,
    service_type_id
)
VALUES
    (7, 1),
    (7, 2);


-- ServicePart
INSERT INTO ServicePart (
    service_id,
    part_id,
    service_type_id,
    quantity,
    unit_cost
)
VALUES
    (7, 1, 1, 1, 60.43),
    (7, 2, 2, 1, 40.44);


-- Test the data
SELECT * FROM Owner;
SELECT * FROM Make;
SELECT * FROM Model;
SELECT * FROM Vehicle;
SELECT * FROM ServiceType;
SELECT * FROM Part;
SELECT * FROM ServiceRecord;
SELECT * FROM ServiceRecordType;
SELECT * FROM ServicePart;