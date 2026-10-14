DROP DATABASE IF EXISTS car_maintenance;

CREATE DATABASE car_maintenance;

USE car_maintenance;


CREATE TABLE Owner (
    owner_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254),
    phone VARCHAR(32)
);


CREATE TABLE Part (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    manufacturer VARCHAR(255),
    part_number VARCHAR(100)
);


CREATE TABLE Technician (
    technician_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
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


CREATE TABLE WorkOrder (
    work_order_id INT PRIMARY KEY,
    vehicle_id INT,
    service_date DATE,
    odometer INT,
    notes VARCHAR(500),

    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);


CREATE TABLE ServiceType (
    service_type_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    description VARCHAR(255)
);


CREATE TABLE ServiceJob (
    service_job_id INT PRIMARY KEY,
    work_order_id INT,
    service_type_id INT,
    labour_cost DECIMAL(10,2),

    FOREIGN KEY (work_order_id) REFERENCES WorkOrder(work_order_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id)
);


CREATE TABLE JobPart (
    service_job_id INT,
    part_id INT,
    quantity INT,
    unit_cost DECIMAL(10,2),

    PRIMARY KEY (service_job_id, part_id),

    FOREIGN KEY (service_job_id) REFERENCES ServiceJob(service_job_id),
    FOREIGN KEY (part_id) REFERENCES Part(part_id)
);


CREATE TABLE JobTechnician (
    service_job_id INT,
    technician_id INT,

    PRIMARY KEY (service_job_id, technician_id),

    FOREIGN KEY (service_job_id) REFERENCES ServiceJob(service_job_id),
    FOREIGN KEY (technician_id) REFERENCES Technician(technician_id)
);


CREATE TABLE MaintenanceSchedule (
    maintenance_schedule_id INT PRIMARY KEY,
    model_id INT,
    schedule_name VARCHAR(100),

    FOREIGN KEY (model_id) REFERENCES  Model(model_id)
);


CREATE TABLE ScheduleService (
    maintenance_schedule_id INT,
    service_type_id INT,
    kilometre_interval INT,
    month_interval INT,

    PRIMARY KEY (maintenance_schedule_id, service_type_id),

    FOREIGN KEY (maintenance_schedule_id) REFERENCES MaintenanceSchedule(maintenance_schedule_id),
    FOREIGN KEY (service_type_id) REFERENCES ServiceType(service_type_id)
);
