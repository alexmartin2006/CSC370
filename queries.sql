USE car_maintenance;

-- Return all work orders for a given vehicle
SELECT
    Owner.owner_id,
    Owner.first_name,
    Owner.last_name,
    Vehicle.vehicle_id,
    Make.make_name,
    Model.model_name,
    Vehicle.vin,
    Vehicle.licence_plate,
    Vehicle.current_odometer,
    WorkOrder.work_order_id,
    WorkOrder.service_date,
    WorkOrder.odometer,
    WorkOrder.notes
FROM Vehicle
JOIN Owner
    ON Vehicle.owner_id = Owner.owner_id
JOIN Model
    ON Vehicle.model_id = Model.model_id
JOIN Make
    ON Model.make_id = Make.make_id
JOIN WorkOrder
    ON Vehicle.vehicle_id = WorkOrder.vehicle_id
WHERE Vehicle.vehicle_id = 1;

-- Return all ServiceJobs (including the Technicians, JobParts and Parts) belonging to one WorkOrder
SELECT
    WorkOrder.work_order_id,
    WorkOrder.service_date,
    WorkOrder.odometer,
    ServiceJob.labour_cost,
    JobPart.quantity,
    JobPart.unit_cost,
    Part.part_name,
    Part.manufacturer,
    Part.part_number,
    Technician.first_name,
    Technician.last_name,
    ServiceType.service_name,
    ServiceType.description
FROM WorkOrder
JOIN ServiceJob
    ON WorkOrder.work_order_id = ServiceJob.work_order_id
JOIN JobPart
    ON ServiceJob.service_job_id = JobPart.service_job_id
JOIN Part
    ON JobPart.part_id = Part.part_id
JOIN JobTechnician
    ON ServiceJob.service_job_id = JobTechnician.service_job_id
JOIN ServiceType
    ON ServiceJob.service_type_id = ServiceType.service_type_id
JOIN Technician
    ON JobTechnician.technician_id = Technician.technician_id
WHERE WorkOrder.work_order_id = 7;

-- Return the Maintenance Schedule for a specific Model
SELECT
    Model.model_name,
    MaintenanceSchedule.schedule_name,
    ScheduleService.kilometre_interval,
    ScheduleService.month_interval,
    ServiceType.service_name,
    ServiceType.description
FROM Model
JOIN MaintenanceSchedule
    ON Model.model_id = MaintenanceSchedule.model_id
JOIN ScheduleService
    ON MaintenanceSchedule.maintenance_schedule_id = ScheduleService.maintenance_schedule_id
JOIN ServiceType
    ON ScheduleService.service_type_id = ServiceType.service_type_id
WHERE Model.model_id = 1;

