# Car Maintenance Tracker - Sprint 1 Goals

## Sprint Overview

The goal of Sprint 1 is to improve the initial database design and expand it into a more realistic automotive service system.

The main focus will be improving the service relationships, strengthening referential integrity, and applying concepts from Advanced Relational Design.

---

## Goal 1 - Improve the Service Structure

The current design links service records, service types, and parts, but the relationship between them can be improved.

### Planned Improvement

Introduce a more specific structure for service work:

- `WorkOrder` - represents a vehicle visit
- `ServiceJob` - represents an individual service performed
- `JobPart` - represents parts used for a specific job

This will replace the current need to associate parts with both a service record and service type.

### Success Criteria

- Design the new relationships and keys.
- Update visual diagrams.
- Update `database.sql`.
- Demonstrate a work order with multiple service jobs.
- Demonstrate different parts belonging to different jobs.

---

## Goal 2 - Add Technician Tracking

Add technicians to the database and associate them with individual service jobs.

### Success Criteria

- Create a `Technician` relation.
- Connect technicians to `ServiceJob`.
- Add sample technician data.
- Retrieve the technician responsible for a service job.

---

## Goal 3 - Add Maintenance Scheduling

Add recommended maintenance intervals so the database can store when different services should be performed.

A possible `MaintenanceSchedule` relation could connect:

- vehicle model;
- service type;
- kilometre interval;
- time interval.

### Success Criteria

- Create the maintenance schedule relation.
- Associate schedules with models and service types.
- Add example maintenance intervals.
- Retrieve the recommended maintenance schedule for a vehicle.

---

## Goal 4 - Review and Test the Relational Design

Review the expanded schema using relational design concepts covered in CSC 370.

### Success Criteria

- Check for unnecessary redundancy.
- Review primary and foreign keys.
- Review functional dependencies.
- Test referential integrity.
- Update `schema.md` to match the final design.


