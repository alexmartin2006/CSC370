-- CSC 370 Car Maintenance Tracker - Sprint 1
-- WARNING: Running this script deletes and recreates car_maintenance.
DROP DATABASE IF EXISTS car_maintenance;
CREATE DATABASE car_maintenance;
USE car_maintenance;

CREATE TABLE Owner (
    owner_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(254),
    phone VARCHAR(32)
);

CREATE TABLE Part (
    part_id INT NOT NULL PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(255),
    part_number VARCHAR(100)
);

CREATE TABLE Technician (
    technician_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE Make (
    make_id INT NOT NULL PRIMARY KEY,
    make_name VARCHAR(50) NOT NULL
);

CREATE TABLE Model (
    model_id INT NOT NULL PRIMARY KEY,
    make_id INT NOT NULL,
    model_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (make_id) REFERENCES Make(make_id)
);

CREATE TABLE Vehicle (
    vehicle_id INT NOT NULL PRIMARY KEY,
    owner_id INT NOT NULL,
    model_id INT NOT NULL,
    year INT NOT NULL,
    vin CHAR(17) NOT NULL UNIQUE,
    licence_plate VARCHAR(20),
    current_odometer INT NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id),
    FOREIGN KEY (model_id) REFERENCES Model(model_id),
    CHECK (current_odometer >= 0)
);

CREATE TABLE WorkOrder (
    work_order_id INT NOT NULL PRIMARY KEY,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    odometer INT NOT NULL,
    notes VARCHAR(500),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
    CHECK (odometer >= 0)
);

CREATE TABLE ServiceType (
    service_type_id INT NOT NULL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE ServiceJob (
    service_job_id INT NOT NULL PRIMARY KEY,
    work_order_id INT NOT NULL,
    service_type_id INT NOT NULL,
    labour_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (work_order_id) REFERENCES WorkOrder(work_order_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id),
    CHECK (labour_cost >= 0)
);

CREATE TABLE JobPart (
    service_job_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (service_job_id, part_id),
    FOREIGN KEY (service_job_id) REFERENCES ServiceJob(service_job_id),
    FOREIGN KEY (part_id) REFERENCES Part(part_id),
    CHECK (quantity > 0),
    CHECK (unit_cost >= 0)
);

CREATE TABLE JobTechnician (
    service_job_id INT NOT NULL,
    technician_id INT NOT NULL,
    PRIMARY KEY (service_job_id, technician_id),
    FOREIGN KEY (service_job_id) REFERENCES ServiceJob(service_job_id),
    FOREIGN KEY (technician_id) REFERENCES Technician(technician_id)
);

CREATE TABLE MaintenanceSchedule (
    maintenance_schedule_id INT NOT NULL PRIMARY KEY,
    model_id INT NOT NULL,
    schedule_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (model_id) REFERENCES Model(model_id)
);

CREATE TABLE ScheduleService (
    maintenance_schedule_id INT NOT NULL,
    service_type_id INT NOT NULL,
    kilometre_interval INT NOT NULL,
    month_interval INT NOT NULL,
    PRIMARY KEY (maintenance_schedule_id, service_type_id),
    FOREIGN KEY (maintenance_schedule_id) REFERENCES MaintenanceSchedule(maintenance_schedule_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id),
    CHECK (kilometre_interval > 0),
    CHECK (month_interval > 0)
);
