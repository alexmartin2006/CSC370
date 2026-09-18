USE car_maintenance;

-- Show All Owners
SELECT * FROM Owner;

-- Show all vehicles with their Owners
SELECT
    vehicle.vehicle_id,
    make.make_name,
    model.model_name,
    vehicle.year,
    vehicle.vin,
    owner.first_name,
    owner.last_name
FROM Vehicle
JOIN owner
    ON vehicle.owner_id = owner.owner_id
JOIN model
    ON vehicle.model_id = model.model_id
JOIN Make
    ON model.make_id = make.make_id;

-- Show all service records for vehicle with vehicle_id = 2
SELECT
    vehicle.vehicle_id,
    servicetype.service_name,
    servicetype.description,
    servicerecord.labour_cost,
    servicepart.quantity,
    part.part_name
FROM servicerecord

JOIN vehicle
    ON servicerecord.vehicle_id = vehicle.vehicle_id

JOIN servicerecordtype
    ON servicerecord.service_id = servicerecordtype.service_id

JOIN servicetype
    ON servicerecordtype.service_type_id = servicetype.service_type_id

JOIN servicepart
    ON servicerecordtype.service_id = servicepart.service_id
    AND servicerecordtype.service_type_id = servicepart.service_type_id

JOIN part
    ON servicepart.part_id = part.part_id

WHERE vehicle.vehicle_id = 2;









