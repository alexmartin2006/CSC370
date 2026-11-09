# Car Maintenance Tracker — Sprint 3 Goals

## Overview

Sprint 2 added service appointments, parts inventory, maintenance cost analysis, and queries for evaluating upcoming maintenance. The maintenance evaluation queries currently require manual interpretation of service dates and recommended intervals.

Sprint 3 will improve the existing database without adding new tables. The four goals focus on the remaining CSC 370 modules: Advanced SQL, ACID Transactions, Basic Security, and Analysing Query Algorithms. Each goal includes measurable tests to demonstrate progress.

---

## Goal 1 — Analyze and Improve Query Performance

**Current limitation:** The database contains queries with joins, grouping, and subqueries, but their execution plans have not been analyzed. It is unclear whether additional indexes would improve how these queries access data.

**Planned improvement:** Use MySQL's `EXPLAIN` command to investigate existing queries and compare execution plans before and after adding a suitable index.

**CSC 370 connection:** Analysing Query Algorithms, query execution plans, table scans, and index access.

**Success criteria:**
- Select **2 existing queries** involving joins, filtering, or subqueries.
- Record and explain their original `EXPLAIN` results.
- Add an appropriate index for at least **1 query**, if a useful candidate is identified.
- Compare access methods and estimated rows examined before and after indexing, and explain whether the change helped.

---

## Goal 2 — Use Transactions for Inventory Updates

**Current limitation:** Inventory quantities can be changed with `UPDATE`, but related changes to service jobs and inventory are not currently handled as one transaction.

**Planned improvement:** Use a transaction to record part usage for a service job and reduce the corresponding inventory quantity together. Demonstrate how `COMMIT` saves valid changes and `ROLLBACK` reverses changes when a problem occurs.

**CSC 370 connection:** ACID Transactions, atomicity, consistency, `COMMIT`, and `ROLLBACK`.

**Success criteria:**
- Write **1 transaction** that records part usage and decreases inventory stock.
- Demonstrate that `COMMIT` saves both changes.
- Demonstrate that `ROLLBACK` restores the original data when the transaction is not committed.
- Check that inventory remains nonnegative and explain how the transaction supports data consistency.

---

## Goal 3 — Implement Basic Database Security

**Current limitation:** The project does not demonstrate database access restrictions for different users.

**Planned improvement:** Create a MySQL user with limited permissions to demonstrate how database access can be controlled without changing the existing tables.

**CSC 370 connection:** Basic Security, database users, privileges, `GRANT`, and `REVOKE`.

**Success criteria:**
- Create **1 restricted MySQL user** for testing.
- Grant the user permission to `SELECT` from the relevant tables without allowing data changes.
- Verify that a permitted `SELECT` works and an unauthorized `INSERT` or `UPDATE` is rejected.
- Demonstrate how a permission can be changed using `GRANT` or `REVOKE` and document the result.

---

## Goal 4 — Automate Upcoming Maintenance Evaluation

**Current limitation:** Sprint 2 queries retrieve the most recent service date, kilometres since service, and recommended maintenance intervals, but the maintenance status must be determined manually.

**Planned improvement:** Extend the existing SQL queries to calculate elapsed time and return a maintenance status based on whether the recommended kilometre or month interval has been reached. Continue to identify services with no recorded history.

**CSC 370 connection:** Advanced SQL, joins, subqueries, date calculations, and conditional expressions.

**Success criteria:**
- Retrieve the most recent service record for a selected vehicle and service type.
- Calculate both kilometres and months elapsed since that service.
- Return a status such as `Due` or `Not Due` based on the recommended intervals.
- Verify the results using the **4 existing Sprint 2 test cases**: not due, due by kilometres, due by time, and no recorded service history.

---

## Expected Outcomes

Sprint 3 will build on the existing 15-table database without introducing new relations. The goals will demonstrate the use of query analysis, transactions, basic access control, and more advanced SQL while addressing practical limitations identified during Sprint 2.

Because the sample database is small, indexing may not produce a measurable improvement in execution time. Query plans and estimated rows examined will therefore be used to evaluate performance changes.
