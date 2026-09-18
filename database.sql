DROP DATABASE IF EXISTS car_maintenance;

CREATE DATABASE car_maintenance;

USE car_maintenance;

CREATE TABLE Owner (
    owner_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255),
    phone VARCHAR(32)
);

CREATE TABLE Make (
    make_id INT PRIMARY KEY,
    make_name VARCHAR(50)
);

CREATE TABLE Model (
    model_id INT PRIMARY KEY,
    make_id INT,
    model_name VARCHAR(50),

    FOREIGN KEY (make_id) REFERENCES Make(make_id)
);

CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY,
    owner_id INT,
    model_id INT,
    year INT,
    vin CHAR(17),
    licence_plate VARCHAR(20),
    current_odometer INT,

    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
    FOREIGN KEY (model_id) REFERENCES Model(model_id)
);

CREATE TABLE ServiceType (
    service_type_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    description VARCHAR(255)
);

CREATE TABLE ServiceRecord (
    service_id INT PRIMARY KEY,
    vehicle_id INT,
    service_date DATE,
    odometer INT,
    labour_cost FLOAT,
    notes VARCHAR(500),

    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Part (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    manufacturer VARCHAR(255),
    part_number VARCHAR(100)
);

CREATE TABLE ServiceRecordType (
    service_id INT,
    service_type_id INT,

    PRIMARY KEY (service_id, service_type_id),

    FOREIGN KEY (service_id) REFERENCES ServiceRecord(service_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id)
);

CREATE TABLE ServicePart (
    service_id INT,
    part_id INT,
    service_type_id INT,
    quantity INT,
    unit_cost FLOAT,

    PRIMARY KEY (service_id, part_id, service_type_id),

    FOREIGN KEY (service_id) REFERENCES ServiceRecord(service_id),
    FOREIGN KEY (part_id) REFERENCES Part(part_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id)
);