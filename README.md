# Travel Request Management System using SAP RAP

## Overview

This project is a Travel Request Management System built using the SAP RESTful Application Programming Model (RAP) on SAP BTP ABAP Environment.

The application enables employees to create and manage travel requests along with related flight bookings. Travel requests can then be submitted for approval, where administrators can approve or reject them through a Fiori Elements application.

---

## Features

### Travel Management

- Create Travel Requests
- Update Travel Requests
- Delete Travel Requests
- Submit Travel Requests
- View Travel Details

### Booking Management

- Create Flight Bookings for a Travel Request
- Update Booking Details
- Delete Bookings
- Parent-Child Composition between Travel and Booking

### Approval Workflow

- Submit Travel Request
- Approve Travel Request
- Reject Travel Request
- Status-based Action Control

### Validations

- Prevents End Date from being earlier than Start Date
- Only submitted requests can be approved
- Only submitted requests can be rejected

---

## Workflow

```text
Open (O)
    |
    | Submit
    ↓
Submitted (S)
   / \
  /   \
Approve Reject
  |      |
  ↓      ↓
Approved Rejected
(A)      (R)
```

---

## Technical Architecture

### Database Tables

- ZTRAVEL_HEADER
- ZTRAVEL_BOOK

### CDS Interface Views

- ZI_TRAVEL_TAB
- ZI_BOOKING_TAB

### CDS Consumption Views

- ZC_TRAVEL_TAB
- ZC_BOOKING_TAB

### Behavior Definitions

Implemented using Managed RAP BO:

- Create
- Update
- Delete
- Actions
- Determinations
- Validations
- Feature Control

### Actions

- SubmitTravel
- ApproveTravel
- RejectTravel

### Validations

- ValidateDates

### Determinations

- SetRequestorUser

---

## SAP Technologies Used

- SAP BTP ABAP Environment
- ABAP RESTful Application Programming Model (RAP)
- Core Data Services (CDS)
- OData V4
- Fiori Elements
- Managed Business Objects
- Metadata Extensions

---

## UI Features

### List Report

- Travel ID
- Employee ID
- Employee Name
- Start Date
- End Date
- Booking Fee
- Total Price
- Status

### Object Page

#### Travel Details

- Travel ID
- Employee ID
- Employee Name
- Travel Dates
- Currency
- Booking Fee
- Total Price
- Status

#### Bookings

- Carrier
- Flight Number
- Flight Date
- Booking Price

---

## Business Rules

### Submit Travel

A travel request can be submitted only when its status is:

```text
Open (O)
```

After submission:

```text
Status = Submitted (S)
```

### Approve Travel

A request can be approved only when:

```text
Status = Submitted (S)
```

After approval:

```text
Status = Approved (A)
```

### Reject Travel

A request can be rejected only when:

```text
Status = Submitted (S)
```

After rejection:

```text
Status = Rejected (R)
```

---

## RAP Concepts Implemented

✅ CDS View Entities

✅ Root and Child Entities

✅ Composition Relationships

✅ Managed RAP Business Objects

✅ Behavior Definitions

✅ Behavior Projections

✅ Actions

✅ Determinations

✅ Validations

✅ Feature Control

✅ Metadata Extensions

✅ OData V4 Service Binding

✅ Fiori Elements UI

---

## Future Enhancements

- Role-Based Authorization
- Employee Master Maintenance Application
- Value Helps
- Draft Handling
- Email Notifications
- Travel Approval Dashboard
- KPI Analytics
- Multi-Level Approval Workflow
