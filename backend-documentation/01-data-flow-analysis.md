# Hospital Management System - Data Flow Analysis

## Overview
This document provides a comprehensive analysis of how data is fed into the database tables in the Hospital Management System. The system uses multiple SQL files and data generation strategies to populate the database with initial and test data.

## Data Sources and Flow

### 1. Primary Data Sources

#### A. `data.sql` (Main Data File)
- **Location**: `backend/src/main/resources/data.sql`
- **Purpose**: Primary data initialization file that runs automatically when the application starts
- **Content**: Contains comprehensive initial data including:
  - User accounts (patients, doctors, admins)
  - Doctor specializations
  - Doctor profiles and qualifications
  - Doctor slot templates
  - Doctor slots for the next 2 weeks
  - Sample appointments
  - Payment records
  - Complaint data

#### B. Additional SQL Generation Files
Located in the `backend/` directory:

1. **`generate-data.sql`**
   - **Purpose**: Generates additional test data for 12 doctors
   - **Content**: 
     - 5 additional doctors (IDs 8-12)
     - 5 new specializations
     - Comprehensive slot templates for all doctors
     - Doctor slots for next 2 weeks
     - Additional patient accounts

2. **`generate-appointments.sql`**
   - **Purpose**: Creates past and future appointment data
   - **Content**:
     - Past appointments (May-July 2025)
     - Future appointments (September-December 2025)
     - Various appointment statuses (SCHEDULED, COMPLETED, CANCELLED)

3. **`generate-complaints.sql`**
   - **Purpose**: Generates test complaint data
   - **Content**:
     - Various complaint categories (TREATMENT_ISSUE, SERVICE_ISSUE, etc.)
     - Different priority levels (LOW, MEDIUM, HIGH, CRITICAL)
     - Multiple statuses (OPEN, IN_PROGRESS, RESOLVED, CLOSED, REOPENED)

4. **`generate-slots.sql`**
   - **Purpose**: Generates doctor slots based on templates
   - **Content**: Creates available time slots for doctors

5. **`payment-appointment-migration.sql`**
   - **Purpose**: Database schema migration for payment-appointment integration
   - **Content**: Adds temporary appointment fields to payment table

6. **`populate-superadmin-complaints.sql`**
   - **Purpose**: Creates comprehensive complaint data for super admin testing
   - **Content**: Detailed complaint records with resolution tracking

### 2. Data Flow Process

#### Step 1: Application Startup
1. Spring Boot application starts
2. JPA/Hibernate initializes database schema
3. `data.sql` is automatically executed (if `spring.sql.init.mode` is set to `always` or `embedded`)

#### Step 2: Manual Data Generation (Optional)
1. Additional SQL files can be executed manually
2. `DataGenerator` utility class can generate slots and appointments programmatically
3. Admin endpoints can trigger data generation

#### Step 3: Runtime Data Creation
1. Users register through the application
2. Appointments are created through the API
3. Payments are processed
4. Complaints are submitted

### 3. Database Tables and Data Population

#### Core Tables:
- **`users`**: User accounts (patients, doctors, admins)
- **`doctors`**: Doctor profiles and specializations
- **`specialization`**: Medical specializations
- **`doctor_slot_templates`**: Recurring schedule templates
- **`doctor_slots`**: Available time slots
- **`appointments`**: Patient appointments
- **`payments`**: Payment records
- **`complaints`**: Patient complaints and feedback

#### Data Relationships:
```
users (1) ←→ (1) doctors
doctors (1) ←→ (M) doctor_slot_templates
doctor_slot_templates (1) ←→ (M) doctor_slots
doctors (1) ←→ (M) appointments
users (1) ←→ (M) appointments
appointments (1) ←→ (1) payments
users (1) ←→ (M) complaints
```

### 4. Data Generation Strategies

#### A. Static Data (data.sql)
- Predefined user accounts
- Fixed specializations
- Initial doctor profiles
- Sample appointments

#### B. Template-Based Generation
- Doctor slot templates define recurring schedules
- Slots are generated based on templates for specific date ranges
- Supports different slot durations (30, 45, 60 minutes)

#### C. Programmatic Generation
- `DataGenerator` utility class
- Generates slots for next 2 weeks
- Creates sample appointments
- Handles date calculations and conflicts

### 5. Data Validation and Constraints

#### Database Level:
- Foreign key constraints
- Unique constraints
- Not null constraints
- Check constraints for enums

#### Application Level:
- JPA entity validations
- Custom validation annotations
- Business logic validation in services

### 6. Data Maintenance

#### Automatic:
- Audit fields (created_at, updated_at, created_by, updated_by)
- Soft deletes (deleted_at, deleted_by)
- JPA auditing

#### Manual:
- Admin can manage data through API endpoints
- Data generation utilities for testing
- SQL scripts for bulk operations

## Summary

The Hospital Management System uses a multi-layered approach to data population:

1. **Initial Setup**: `data.sql` provides core data
2. **Extended Testing**: Additional SQL files add comprehensive test data
3. **Runtime Generation**: Application creates data through user interactions
4. **Utility Tools**: Programmatic data generation for testing and development

This approach ensures the system has sufficient data for development, testing, and demonstration purposes while maintaining data integrity and relationships.
