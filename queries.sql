USE car_maintenance;

-- Show All Owners
SELECT * FROM Owner;

-- Show all vehicles with their Owners
SELECT
    Vehicle.vehicle_id,
    Make.make_name,
    Model.model_name,
    Vehicle.year,
    Vehicle.vin,
    Owner.first_name,
    Owner.last_name
FROM Vehicle
JOIN Owner
    ON Vehicle.owner_id = Owner.owner_id
JOIN Model
    ON Vehicle.model_id = Model.model_id
JOIN Make
    ON Model.make_id = Make.make_id;

-- Show all service records for vehicle with vehicle_id = 2
SELECT
    Vehicle.vehicle_id,
    ServiceRecord.service_id,
    ServiceRecord.service_date,
    ServiceType.service_name,
    ServiceType.description,
    ServiceRecord.labour_cost,
    ServicePart.quantity,
    Part.part_name
FROM ServiceRecord

JOIN Vehicle
    ON ServiceRecord.vehicle_id = Vehicle.vehicle_id

JOIN ServiceRecordType
    ON ServiceRecord.service_id = ServiceRecordType.service_id

JOIN ServiceType
    ON ServiceRecordType.service_type_id = ServiceType.service_type_id

LEFT JOIN ServicePart
    ON ServiceRecordType.service_id = ServicePart.service_id
    AND ServiceRecordType.service_type_id = ServicePart.service_type_id

LEFT JOIN Part
    ON ServicePart.part_id = Part.part_id

WHERE Vehicle.vehicle_id = 2;