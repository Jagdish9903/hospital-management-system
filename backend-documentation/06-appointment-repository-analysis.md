# AppointmentRepository - Line by Line Analysis

## File: `backend/src/main/java/com/example/SpringDemo/repository/AppointmentRepository.java`

### Overview
The `AppointmentRepository` is a Spring Data JPA repository interface that provides data access methods for the `Appointment` entity. It extends `JpaRepository` to inherit basic CRUD operations and defines custom query methods for complex appointment searches and filtering.

---

## Package and Imports (Lines 1-16)

```java
package com.example.SpringDemo.repository;

import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Doctor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
```

**Explanation:**
- **Line 1**: Package declaration for repository interfaces
- **Line 3**: Import the Appointment entity class
- **Line 4**: Import the Doctor entity class for relationship queries
- **Lines 5-6**: Import Spring Data classes for pagination support
- **Line 7**: Import JpaRepository interface for basic CRUD operations
- **Lines 8-9**: Import Spring Data JPA annotations for custom queries
- **Line 10**: Import Repository annotation for Spring component scanning
- **Lines 12-15**: Import Java classes for date/time handling and collections

---

## Interface Declaration (Lines 17-18)

```java
@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
```

**Explanation:**
- **Line 17**: `@Repository` annotation marks this as a Spring repository component
- **Line 18**: Interface extends `JpaRepository<Appointment, Long>`
  - `Appointment`: The entity type this repository manages
  - `Long`: The type of the primary key
  - Inherits basic CRUD operations: save, findById, findAll, delete, etc.

---

## Find Appointments by Patient ID (Lines 20-21)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.deletedAt IS NULL")
Page<Appointment> findByPatientId(@Param("patientId") Long patientId, Pageable pageable);
```

**Explanation:**
- **Line 20**: `@Query` annotation defines a custom JPQL query
- **Line 20**: JPQL query selects appointments where patient ID matches and not soft-deleted
- **Line 21**: Method signature with patient ID parameter and pagination support
- **Purpose**: Get all appointments for a specific patient with pagination
- **Filter**: Excludes soft-deleted appointments (`deletedAt IS NULL`)

---

## Find Appointments by Patient ID with Status Filter (Lines 23-29)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND " +
       "(:status IS NULL OR a.status = :statusEnum) AND " +
       "a.deletedAt IS NULL")
Page<Appointment> findByPatientIdAndStatusAndDeletedAtIsNull(@Param("patientId") Long patientId, 
                                                             @Param("status") String status,
                                                             @Param("statusEnum") Appointment.Status statusEnum, 
                                                             Pageable pageable);
```

**Explanation:**
- **Lines 23-25**: JPQL query with patient ID and optional status filtering
- **Line 24**: `(:status IS NULL OR a.status = :statusEnum)` allows null status (no filter)
- **Line 25**: Excludes soft-deleted appointments
- **Lines 26-29**: Method signature with multiple parameters
- **Purpose**: Get appointments for a patient with optional status filtering
- **Flexibility**: Status can be null (no filter) or specific enum value

---

## Find Upcoming Appointments by Patient (Lines 31-39)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND " +
       "(:status IS NULL OR a.status = :statusEnum) AND " +
       "a.appointmentDate >= :today AND " +
       "a.deletedAt IS NULL")
Page<Appointment> findUpcomingAppointmentsByPatient(@Param("patientId") Long patientId, 
                                                    @Param("status") String status,
                                                    @Param("statusEnum") Appointment.Status statusEnum,
                                                    @Param("today") java.time.LocalDate today,
                                                    Pageable pageable);
```

**Explanation:**
- **Lines 31-34**: JPQL query for upcoming appointments
- **Line 32**: Optional status filtering
- **Line 33**: `a.appointmentDate >= :today` filters for future or today's appointments
- **Line 34**: Excludes soft-deleted appointments
- **Lines 35-39**: Method signature with pagination support
- **Purpose**: Get future appointments for a patient with optional status filtering

---

## Find Past Appointments by Patient (Lines 41-49)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND " +
       "(:status IS NULL OR a.status = :statusEnum) AND " +
       "a.appointmentDate < :today AND " +
       "a.deletedAt IS NULL")
Page<Appointment> findPastAppointmentsByPatient(@Param("patientId") Long patientId, 
                                                @Param("status") String status,
                                                @Param("statusEnum") Appointment.Status statusEnum,
                                                @Param("today") java.time.LocalDate today,
                                                Pageable pageable);
```

**Explanation:**
- **Lines 41-44**: JPQL query for past appointments
- **Line 42**: Optional status filtering
- **Line 43**: `a.appointmentDate < :today` filters for past appointments
- **Line 44**: Excludes soft-deleted appointments
- **Lines 45-49**: Method signature with pagination support
- **Purpose**: Get past appointments for a patient with optional status filtering

---

## Find Appointments by Doctor ID (Lines 51-52)

```java
@Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.deletedAt IS NULL")
Page<Appointment> findByDoctorId(@Param("doctorId") Long doctorId, Pageable pageable);
```

**Explanation:**
- **Line 51**: JPQL query for appointments by doctor ID
- **Line 51**: Excludes soft-deleted appointments
- **Line 52**: Method signature with pagination support
- **Purpose**: Get all appointments for a specific doctor with pagination

---

## Find Appointments by Doctor and Date (Lines 54-55)

```java
@Query("SELECT a FROM Appointment a WHERE a.doctor = :doctor AND a.appointmentDate = :date AND a.status != 'CANCELLED' AND a.deletedAt IS NULL")
List<Appointment> findByDoctorAndDate(@Param("doctor") Doctor doctor, @Param("date") LocalDate date);
```

**Explanation:**
- **Line 54**: JPQL query for appointments by doctor and specific date
- **Line 54**: `a.status != 'CANCELLED'` excludes cancelled appointments
- **Line 54**: Excludes soft-deleted appointments
- **Line 55**: Method signature returns List (not paginated)
- **Purpose**: Get all non-cancelled appointments for a doctor on a specific date

---

## Find Appointments by Doctor, Date, and Time (Lines 57-60)

```java
@Query("SELECT a FROM Appointment a WHERE a.doctor = :doctor AND a.appointmentDate = :date AND a.appointmentTime = :time AND a.status != 'CANCELLED' AND a.deletedAt IS NULL")
List<Appointment> findByDoctorAndDateTime(@Param("doctor") Doctor doctor, 
                                          @Param("date") LocalDate date, 
                                          @Param("time") LocalTime time);
```

**Explanation:**
- **Line 57**: JPQL query for appointments by doctor, date, and time
- **Line 57**: `a.status != 'CANCELLED'` excludes cancelled appointments
- **Line 57**: Excludes soft-deleted appointments
- **Lines 58-60**: Method signature with three parameters
- **Purpose**: Check for appointment conflicts at specific date/time
- **Use Case**: Prevents double-booking of doctors

---

## Find Appointments with Multiple Filters (Lines 62-76)

```java
@Query("SELECT a FROM Appointment a WHERE " +
       "(:patientId IS NULL OR a.patient.id = :patientId) AND " +
       "(:doctorId IS NULL OR a.doctor.id = :doctorId) AND " +
       "(:status IS NULL OR a.status = :status) AND " +
       "(:appointmentType IS NULL OR a.appointmentType = :appointmentType) AND " +
       "(:fromDate IS NULL OR a.appointmentDate >= :fromDate) AND " +
       "(:toDate IS NULL OR a.appointmentDate <= :toDate) AND " +
       "a.deletedAt IS NULL")
Page<Appointment> findAppointmentsWithFilters(@Param("patientId") Long patientId,
                                             @Param("doctorId") Long doctorId,
                                             @Param("status") Appointment.Status status,
                                             @Param("appointmentType") Appointment.AppointmentType appointmentType,
                                             @Param("fromDate") LocalDate fromDate,
                                             @Param("toDate") LocalDate toDate,
                                             Pageable pageable);
```

**Explanation:**
- **Lines 62-68**: JPQL query with multiple optional filters
- **Line 63**: Optional patient ID filter
- **Line 64**: Optional doctor ID filter
- **Line 65**: Optional status filter
- **Line 66**: Optional appointment type filter
- **Line 67**: Optional date range start filter
- **Line 68**: Optional date range end filter
- **Line 68**: Excludes soft-deleted appointments
- **Lines 69-76**: Method signature with all filter parameters
- **Purpose**: Advanced search with multiple optional criteria

---

## Count Scheduled Appointments by Doctor and Date (Lines 78-79)

```java
@Query("SELECT COUNT(a) FROM Appointment a WHERE a.doctor = :doctor AND a.appointmentDate = :date AND a.status = 'SCHEDULED' AND a.deletedAt IS NULL")
Long countScheduledAppointmentsByDoctorAndDate(@Param("doctor") Doctor doctor, @Param("date") LocalDate date);
```

**Explanation:**
- **Line 78**: JPQL query to count scheduled appointments
- **Line 78**: `a.status = 'SCHEDULED'` only counts scheduled appointments
- **Line 78**: Excludes soft-deleted appointments
- **Line 79**: Method signature returns Long count
- **Purpose**: Get count of scheduled appointments for a doctor on a specific date

---

## Find Upcoming Appointments by Patient (List) (Lines 81-82)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.status != 'CANCELLED' AND a.appointmentDate >= :fromDate AND a.deletedAt IS NULL ORDER BY a.appointmentDate ASC, a.appointmentTime ASC")
List<Appointment> findUpcomingAppointmentsByPatient(@Param("patientId") Long patientId, @Param("fromDate") LocalDate fromDate);
```

**Explanation:**
- **Line 81**: JPQL query for upcoming appointments (non-paginated)
- **Line 81**: `a.status != 'CANCELLED'` excludes cancelled appointments
- **Line 81**: `a.appointmentDate >= :fromDate` filters for future appointments
- **Line 81**: `ORDER BY a.appointmentDate ASC, a.appointmentTime ASC` sorts by date and time
- **Line 82**: Method signature returns List
- **Purpose**: Get upcoming appointments for a patient in chronological order

---

## Find Past Appointments by Patient (List) (Lines 84-85)

```java
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.status != 'CANCELLED' AND a.appointmentDate < :toDate AND a.deletedAt IS NULL ORDER BY a.appointmentDate DESC, a.appointmentTime DESC")
List<Appointment> findPastAppointmentsByPatient(@Param("patientId") Long patientId, @Param("toDate") LocalDate toDate);
```

**Explanation:**
- **Line 84**: JPQL query for past appointments (non-paginated)
- **Line 84**: `a.status != 'CANCELLED'` excludes cancelled appointments
- **Line 84**: `a.appointmentDate < :toDate` filters for past appointments
- **Line 84**: `ORDER BY a.appointmentDate DESC, a.appointmentTime DESC` sorts by date and time (descending)
- **Line 85**: Method signature returns List
- **Purpose**: Get past appointments for a patient in reverse chronological order

---

## Find All Appointments by Patient (Debug) (Lines 87-89)

```java
// Debug query to get ALL appointments for a patient
@Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId AND a.deletedAt IS NULL ORDER BY a.appointmentDate DESC, a.appointmentTime DESC")
List<Appointment> findAllAppointmentsByPatient(@Param("patientId") Long patientId);
```

**Explanation:**
- **Line 87**: Comment indicating this is a debug query
- **Line 88**: JPQL query for all appointments (including cancelled)
- **Line 88**: Excludes soft-deleted appointments
- **Line 88**: Orders by date and time (descending)
- **Line 89**: Method signature returns List
- **Purpose**: Debug method to get all appointments for a patient

---

## Count Appointments by Status (Lines 91-92)

```java
@Query("SELECT COUNT(a) FROM Appointment a WHERE a.status = :status AND a.deletedAt IS NULL")
Long countByStatus(@Param("status") Appointment.Status status);
```

**Explanation:**
- **Line 91**: JPQL query to count appointments by status
- **Line 91**: Excludes soft-deleted appointments
- **Line 92**: Method signature returns Long count
- **Purpose**: Get count of appointments with specific status (for statistics)

---

## Find Appointments with Name Filters (Lines 94-112)

```java
@Query("SELECT a FROM Appointment a JOIN a.patient p JOIN a.doctor d JOIN d.user u WHERE " +
       "(:patientName IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :patientName, '%'))) AND " +
       "(:doctorName IS NULL OR LOWER(u.name) LIKE LOWER(CONCAT('%', :doctorName, '%'))) AND " +
       "(:status IS NULL OR a.status = :statusEnum) AND " +
       "(:appointmentType IS NULL OR a.appointmentType = :appointmentTypeEnum) AND " +
       "(:dateFrom IS NULL OR a.appointmentDate >= :dateFromParsed) AND " +
       "(:dateTo IS NULL OR a.appointmentDate <= :dateToParsed) AND " +
       "a.deletedAt IS NULL")
Page<Appointment> findAppointmentsWithFilters(@Param("patientName") String patientName,
                                             @Param("doctorName") String doctorName,
                                             @Param("status") String status,
                                             @Param("statusEnum") Appointment.Status statusEnum,
                                             @Param("appointmentType") String appointmentType,
                                             @Param("appointmentTypeEnum") Appointment.AppointmentType appointmentTypeEnum,
                                             @Param("dateFrom") String dateFrom,
                                             @Param("dateFromParsed") LocalDate dateFromParsed,
                                             @Param("dateTo") String dateTo,
                                             @Param("dateToParsed") LocalDate dateToParsed,
                                             Pageable pageable);
```

**Explanation:**
- **Lines 94-100**: JPQL query with name-based filtering
- **Line 95**: `JOIN a.patient p JOIN a.doctor d JOIN d.user u` joins related entities
- **Line 96**: `LOWER(p.name) LIKE LOWER(CONCAT('%', :patientName, '%'))` case-insensitive patient name search
- **Line 97**: `LOWER(u.name) LIKE LOWER(CONCAT('%', :doctorName, '%'))` case-insensitive doctor name search
- **Lines 98-100**: Optional filters for status, type, and date range
- **Line 100**: Excludes soft-deleted appointments
- **Lines 101-112**: Method signature with all filter parameters
- **Purpose**: Advanced search with name-based filtering for admin interface

---

## Find Appointment by ID (Non-deleted) (Lines 114-115)

```java
@Query("SELECT a FROM Appointment a WHERE a.id = :id AND a.deletedAt IS NULL")
Optional<Appointment> findByIdAndDeletedAtIsNull(@Param("id") Long id);
```

**Explanation:**
- **Line 114**: JPQL query to find appointment by ID
- **Line 114**: `a.deletedAt IS NULL` excludes soft-deleted appointments
- **Line 115**: Method signature returns Optional for null safety
- **Purpose**: Find appointment by ID, excluding soft-deleted records

---

## Find Appointments with Name Filters (Including Deleted) (Lines 117-135)

```java
// Method to include deleted records for display purposes
@Query("SELECT a FROM Appointment a JOIN a.patient p JOIN a.doctor d JOIN d.user u WHERE " +
       "(:patientName IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :patientName, '%'))) AND " +
       "(:doctorName IS NULL OR LOWER(u.name) LIKE LOWER(CONCAT('%', :doctorName, '%'))) AND " +
       "(:status IS NULL OR a.status = :statusEnum) AND " +
       "(:appointmentType IS NULL OR a.appointmentType = :appointmentTypeEnum) AND " +
       "(:dateFrom IS NULL OR a.appointmentDate >= :dateFromParsed) AND " +
       "(:dateTo IS NULL OR a.appointmentDate <= :dateToParsed)")
Page<Appointment> findAppointmentsWithFiltersIncludingDeleted(@Param("patientName") String patientName,
                                                             @Param("doctorName") String doctorName,
                                                             @Param("status") String status,
                                                             @Param("statusEnum") Appointment.Status statusEnum,
                                                             @Param("appointmentType") String appointmentType,
                                                             @Param("appointmentTypeEnum") Appointment.AppointmentType appointmentTypeEnum,
                                                             @Param("dateFrom") String dateFrom,
                                                             @Param("dateFromParsed") LocalDate dateFromParsed,
                                                             @Param("dateTo") String dateTo,
                                                             @Param("dateToParsed") LocalDate dateToParsed,
                                                             Pageable pageable);
```

**Explanation:**
- **Line 117**: Comment indicating this includes deleted records
- **Lines 118-124**: JPQL query similar to previous but without `deletedAt IS NULL` filter
- **Lines 125-135**: Method signature with all filter parameters
- **Purpose**: Admin interface method that includes soft-deleted records for display

---

## Summary

The `AppointmentRepository` provides comprehensive data access methods for appointment management with the following key features:

### Basic CRUD Operations:
- Inherited from `JpaRepository<Appointment, Long>`
- Automatic implementation of save, findById, findAll, delete, etc.

### Custom Query Methods:

1. **Patient-based Queries**:
   - `findByPatientId()` - Get appointments for a patient
   - `findByPatientIdAndStatusAndDeletedAtIsNull()` - With status filtering
   - `findUpcomingAppointmentsByPatient()` - Future appointments
   - `findPastAppointmentsByPatient()` - Past appointments
   - `findAllAppointmentsByPatient()` - All appointments (debug)

2. **Doctor-based Queries**:
   - `findByDoctorId()` - Get appointments for a doctor
   - `findByDoctorAndDate()` - Appointments on specific date
   - `findByDoctorAndDateTime()` - Check for conflicts
   - `countScheduledAppointmentsByDoctorAndDate()` - Count scheduled appointments

3. **Advanced Search Queries**:
   - `findAppointmentsWithFilters()` - Multiple optional filters
   - `findAppointmentsWithFilters()` (name-based) - With patient/doctor name search
   - `findAppointmentsWithFiltersIncludingDeleted()` - Admin view with deleted records

4. **Utility Queries**:
   - `findByIdAndDeletedAtIsNull()` - Find by ID excluding deleted
   - `countByStatus()` - Count appointments by status

### Key Design Features:

1. **Soft Delete Support**: Most queries exclude soft-deleted records
2. **Pagination Support**: Many methods support pagination for large datasets
3. **Flexible Filtering**: Optional parameters allow for various search combinations
4. **Case-Insensitive Search**: Name-based searches use LOWER() for case-insensitive matching
5. **Ordering**: Queries include appropriate ORDER BY clauses for consistent results
6. **Performance**: Uses JOINs efficiently to avoid N+1 query problems
7. **Null Safety**: Uses Optional for methods that might not find results
8. **Admin Support**: Separate methods for admin interface that include deleted records

### Query Patterns:

1. **Basic Filtering**: `WHERE condition AND deletedAt IS NULL`
2. **Optional Filtering**: `(:param IS NULL OR field = :param)`
3. **Date Range Filtering**: `dateField >= :fromDate AND dateField <= :toDate`
4. **Name Search**: `LOWER(field) LIKE LOWER(CONCAT('%', :search, '%'))`
5. **Status Filtering**: `status = :statusEnum`
6. **Conflict Detection**: `doctor = :doctor AND date = :date AND time = :time`

This repository provides a robust foundation for all appointment-related data operations in the hospital management system, supporting both user-facing features and administrative functions.
