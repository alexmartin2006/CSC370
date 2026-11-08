
USE car_maintenance;

-- =========================================================
-- GOAL 3: MAINTENANCE COST ANALYSIS
-- =========================================================

-- Query 1: Total parts cost per service job
SELECT
    ServiceJob.service_job_id,
    SUM(JobPart.quantity * JobPart.unit_cost) AS parts_cost
FROM ServiceJob
JOIN JobPart
    ON ServiceJob.service_job_id = JobPart.service_job_id
GROUP BY ServiceJob.service_job_id;


-- Query 2: Total labour and parts cost per service job
SELECT
    ServiceJob.service_job_id,
    ServiceJob.labour_cost,
    COALESCE(Parts.parts_cost, 0) AS parts_cost,
    ServiceJob.labour_cost + COALESCE(Parts.parts_cost, 0) AS total_cost
FROM ServiceJob

-- Aggregate parts separately to avoid duplicating labour costs
LEFT JOIN (
    SELECT
        JobPart.service_job_id,
        SUM(JobPart.quantity * JobPart.unit_cost) AS parts_cost
    FROM JobPart
    GROUP BY JobPart.service_job_id
) AS Parts
    ON ServiceJob.service_job_id = Parts.service_job_id;


-- Query 3: Total maintenance cost per work order
SELECT
    WorkOrder.work_order_id,
    SUM(Costs.total_cost) AS total_cost
FROM WorkOrder

-- Calculate job costs before aggregating by work order
JOIN (
    SELECT
        ServiceJob.work_order_id,
        ServiceJob.labour_cost + COALESCE(Parts.parts_cost, 0) AS total_cost
    FROM ServiceJob
    LEFT JOIN (
        SELECT
            JobPart.service_job_id,
            SUM(JobPart.quantity * JobPart.unit_cost) AS parts_cost
        FROM JobPart
        GROUP BY JobPart.service_job_id
    ) AS Parts
        ON ServiceJob.service_job_id = Parts.service_job_id
) AS Costs
    ON WorkOrder.work_order_id = Costs.work_order_id
GROUP BY WorkOrder.work_order_id;


-- Query 4: Total historical maintenance spending per vehicle
SELECT
    Vehicle.vehicle_id,
    SUM(Costs.total_cost) AS total_spending
FROM Vehicle
JOIN WorkOrder
    ON Vehicle.vehicle_id = WorkOrder.vehicle_id

-- Calculate job costs separately to prevent duplicate cost calculations
JOIN (
    SELECT
        ServiceJob.work_order_id,
        ServiceJob.labour_cost + COALESCE(Parts.parts_cost, 0) AS total_cost
    FROM ServiceJob
    LEFT JOIN (
        SELECT
            JobPart.service_job_id,
            SUM(JobPart.quantity * JobPart.unit_cost) AS parts_cost
        FROM JobPart
        GROUP BY JobPart.service_job_id
    ) AS Parts
        ON ServiceJob.service_job_id = Parts.service_job_id
) AS Costs
    ON WorkOrder.work_order_id = Costs.work_order_id
GROUP BY Vehicle.vehicle_id;


-- =========================================================
-- GOAL 4: UPCOMING MAINTENANCE EVALUATION
-- =========================================================

-- Test Case 1: Vehicle 1 oil change - Not due
SELECT
    Vehicle.vehicle_id,
    ServiceType.service_name,
    WorkOrder.service_date,
    Vehicle.current_odometer - WorkOrder.odometer AS km_since_service,
    ScheduleService.kilometre_interval,
    ScheduleService.month_interval
FROM Vehicle
JOIN WorkOrder
    ON Vehicle.vehicle_id = WorkOrder.vehicle_id
JOIN ServiceJob
    ON WorkOrder.work_order_id = ServiceJob.work_order_id
JOIN ServiceType
    ON ServiceJob.service_type_id = ServiceType.service_type_id
JOIN MaintenanceSchedule
    ON Vehicle.model_id = MaintenanceSchedule.model_id
JOIN ScheduleService
    ON MaintenanceSchedule.maintenance_schedule_id =
       ScheduleService.maintenance_schedule_id
    AND ServiceType.service_type_id = ScheduleService.service_type_id
WHERE Vehicle.vehicle_id = 1
    AND ServiceType.service_type_id = 2
    AND MaintenanceSchedule.maintenance_schedule_id = 1
ORDER BY WorkOrder.service_date DESC
LIMIT 1;


-- Test Case 2: Vehicle 2 oil change - Due by kilometres
SELECT
    Vehicle.vehicle_id,
    ServiceType.service_name,
    WorkOrder.service_date,
    Vehicle.current_odometer - WorkOrder.odometer AS km_since_service,
    ScheduleService.kilometre_interval,
    ScheduleService.month_interval
FROM Vehicle
JOIN WorkOrder
    ON Vehicle.vehicle_id = WorkOrder.vehicle_id
JOIN ServiceJob
    ON WorkOrder.work_order_id = ServiceJob.work_order_id
JOIN ServiceType
    ON ServiceJob.service_type_id = ServiceType.service_type_id
JOIN MaintenanceSchedule
    ON Vehicle.model_id = MaintenanceSchedule.model_id
JOIN ScheduleService
    ON MaintenanceSchedule.maintenance_schedule_id =
       ScheduleService.maintenance_schedule_id
    AND ServiceType.service_type_id = ScheduleService.service_type_id
WHERE Vehicle.vehicle_id = 2
    AND ServiceType.service_type_id = 2
    AND MaintenanceSchedule.maintenance_schedule_id = 3
ORDER BY WorkOrder.service_date DESC
LIMIT 1;


-- Test Case 3: Vehicle 3 brake service - Due by time
SELECT
    Vehicle.vehicle_id,
    ServiceType.service_name,
    WorkOrder.service_date,
    Vehicle.current_odometer - WorkOrder.odometer AS km_since_service,
    ScheduleService.kilometre_interval,
    ScheduleService.month_interval
FROM Vehicle
JOIN WorkOrder
    ON Vehicle.vehicle_id = WorkOrder.vehicle_id
JOIN ServiceJob
    ON WorkOrder.work_order_id = ServiceJob.work_order_id
JOIN ServiceType
    ON ServiceJob.service_type_id = ServiceType.service_type_id
JOIN MaintenanceSchedule
    ON Vehicle.model_id = MaintenanceSchedule.model_id
JOIN ScheduleService
    ON MaintenanceSchedule.maintenance_schedule_id =
       ScheduleService.maintenance_schedule_id
    AND ServiceType.service_type_id = ScheduleService.service_type_id
WHERE Vehicle.vehicle_id = 3
    AND ServiceType.service_type_id = 1
    AND MaintenanceSchedule.maintenance_schedule_id = 4
ORDER BY WorkOrder.service_date DESC
LIMIT 1;


-- Test Case 4: Vehicle 3 oil change - No recorded history
SELECT
    Vehicle.vehicle_id,
    ServiceType.service_name
FROM Vehicle
JOIN ServiceType
    ON ServiceType.service_type_id = 2
WHERE Vehicle.vehicle_id = 3

-- Exclude vehicles with an existing record for this service type
    AND NOT EXISTS (
        SELECT *
        FROM WorkOrder
        JOIN ServiceJob
            ON WorkOrder.work_order_id = ServiceJob.work_order_id
        WHERE WorkOrder.vehicle_id = Vehicle.vehicle_id
            AND ServiceJob.service_type_id = ServiceType.service_type_id
    );
