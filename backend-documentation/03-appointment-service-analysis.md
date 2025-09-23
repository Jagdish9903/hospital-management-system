# AppointmentService - Line by Line Analysis

## File: `backend/src/main/java/com/example/SpringDemo/service/AppointmentService.java`

### Overview
The `AppointmentService` is the business logic layer that handles all appointment-related operations. It manages appointment creation, retrieval, updates, cancellations, and complex queries while ensuring data integrity and business rules.

---

## Package and Imports (Lines 1-24)

```java
package com.example.SpringDemo.service;

import com.example.SpringDemo.dto.AppointmentRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Doctor;
import com.example.SpringDemo.entity.DoctorSlot;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.AppointmentRepository;
import com.example.SpringDemo.repository.DoctorRepository;
import com.example.SpringDemo.repository.DoctorSlotRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
```

**Explanation:**
- **Line 1**: Package declaration for the service layer
- **Lines 3-7**: Imports for DTOs and entities used in appointment operations
- **Lines 8-11**: Imports for repository interfaces for data access
- **Lines 12-14**: Spring framework imports for dependency injection and pagination
- **Line 15**: `@Service` annotation marks this as a Spring service component
- **Lines 17-23**: Java time and collection imports for date/time handling and data structures

---

## Class Declaration and Dependencies (Lines 25-38)

```java
@Service
public class AppointmentService {
    
    @Autowired
    private AppointmentRepository appointmentRepository;
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private DoctorSlotRepository doctorSlotRepository;
```

**Explanation:**
- **Line 25**: `@Service` annotation makes this class a Spring-managed service bean
- **Lines 28-38**: Dependency injection of all required repositories
- **Line 29**: `AppointmentRepository` for appointment data operations
- **Line 32**: `DoctorRepository` for doctor-related queries
- **Line 35**: `UserRepository` for patient/user operations
- **Line 38**: `DoctorSlotRepository` for slot management

---

## Create Appointment Method (Lines 40-95)

```java
public Appointment createAppointment(AppointmentRequest request) {
    User patient = userRepository.findById(request.getPatientId())
            .orElseThrow(() -> new RuntimeException("Patient not found"));
    
    Doctor doctor = doctorRepository.findById(request.getDoctorId())
            .orElseThrow(() -> new RuntimeException("Doctor not found"));
    
    // Check if appointment date is in the future
    if (request.getAppointmentDate().isBefore(LocalDate.now())) {
        throw new RuntimeException("Appointment date cannot be in the past");
    }
    
    // Find available slot for the doctor at the specified time
    List<DoctorSlot> availableSlots = doctorSlotRepository.findAvailableSlotsByDoctorAndDate(
        request.getDoctorId(), request.getAppointmentDate());
    
    DoctorSlot selectedSlot = null;
    for (DoctorSlot slot : availableSlots) {
        if (slot.getStartTime().equals(request.getAppointmentTime()) && 
            slot.getEndTime().equals(request.getEndTime())) {
            selectedSlot = slot;
            break;
        }
    }
    
    if (selectedSlot == null) {
        throw new RuntimeException("No available slot found for the selected time");
    }
    
    // Check for conflicts
    List<Appointment> conflictingAppointments = appointmentRepository.findByDoctorAndDateTime(
        doctor, request.getAppointmentDate(), request.getAppointmentTime());
    
    if (!conflictingAppointments.isEmpty()) {
        throw new RuntimeException("Doctor is not available at the selected time");
    }
    
    // Book the slot
    selectedSlot.setStatus(DoctorSlot.SlotStatus.BOOKED);
    doctorSlotRepository.save(selectedSlot);
    
    Appointment appointment = new Appointment();
    appointment.setPatient(patient);
    appointment.setDoctor(doctor);
    appointment.setDoctorSlot(selectedSlot);
    appointment.setAppointmentDate(request.getAppointmentDate());
    appointment.setAppointmentTime(request.getAppointmentTime());
    appointment.setEndTime(request.getEndTime());
    appointment.setStatus(Appointment.Status.SCHEDULED);
    appointment.setAppointmentType(Appointment.AppointmentType.valueOf(request.getAppointmentType()));
    appointment.setConsultationFee(request.getConsultationFee());
    appointment.setSymptoms(request.getSymptoms());
    appointment.setNotes(request.getNotes());
    
    return appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 40**: Method signature takes `AppointmentRequest` DTO and returns `Appointment` entity
- **Lines 41-42**: Validate patient exists, throw exception if not found
- **Lines 44-45**: Validate doctor exists, throw exception if not found
- **Lines 47-49**: Business rule: appointment date must be in the future
- **Lines 51-52**: Query available slots for the doctor on the specified date
- **Lines 54-61**: Find the specific slot that matches the requested time
- **Lines 63-65**: Validate that a matching slot exists
- **Lines 67-70**: Check for existing appointments at the same time (conflict detection)
- **Lines 72-73**: Business rule: prevent double-booking
- **Lines 75-76**: Mark the slot as booked to prevent conflicts
- **Lines 78-90**: Create new appointment entity with all required fields
- **Line 92**: Save and return the appointment

---

## Get Appointments by Patient (Lines 97-99)

```java
public Page<Appointment> getAppointmentsByPatient(Long patientId, Pageable pageable) {
    return appointmentRepository.findByPatientId(patientId, pageable);
}
```

**Explanation:**
- **Line 97**: Method to get paginated appointments for a specific patient
- **Line 98**: Delegate to repository with patient ID and pagination parameters

---

## Get Appointments by Doctor (Lines 101-103)

```java
public Page<Appointment> getAppointmentsByDoctor(Long doctorId, Pageable pageable) {
    return appointmentRepository.findByDoctorId(doctorId, pageable);
}
```

**Explanation:**
- **Line 101**: Method to get paginated appointments for a specific doctor
- **Line 102**: Delegate to repository with doctor ID and pagination parameters

---

## Search Appointments (Lines 105-114)

```java
public Page<Appointment> searchAppointments(Long patientId, Long doctorId, String status, 
                                           String appointmentType, LocalDate fromDate, 
                                           LocalDate toDate, Pageable pageable) {
    Appointment.Status statusEnum = status != null ? Appointment.Status.valueOf(status) : null;
    Appointment.AppointmentType typeEnum = appointmentType != null ? 
        Appointment.AppointmentType.valueOf(appointmentType) : null;
    
    return appointmentRepository.findAppointmentsWithFilters(patientId, doctorId, statusEnum, 
                                                           typeEnum, fromDate, toDate, pageable);
}
```

**Explanation:**
- **Lines 105-107**: Method signature with multiple optional search parameters
- **Line 108**: Convert string status to enum if provided
- **Lines 109-110**: Convert string appointment type to enum if provided
- **Lines 112-113**: Delegate to repository with all search criteria

---

## Get Appointment by ID (Lines 116-118)

```java
public Optional<Appointment> getAppointmentById(Long id) {
    return appointmentRepository.findById(id);
}
```

**Explanation:**
- **Line 116**: Method to get a specific appointment by ID
- **Line 117**: Delegate to repository, returns Optional for null safety

---

## Update Appointment (Lines 120-142)

```java
public Appointment updateAppointment(Long id, AppointmentRequest request) {
    Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
    
    Doctor doctor = doctorRepository.findById(request.getDoctorId())
            .orElseThrow(() -> new RuntimeException("Doctor not found"));
    
    // Check if appointment date is in the future
    if (request.getAppointmentDate().isBefore(LocalDate.now())) {
        throw new RuntimeException("Appointment date cannot be in the past");
    }
    
    appointment.setDoctor(doctor);
    appointment.setAppointmentDate(request.getAppointmentDate());
    appointment.setAppointmentTime(request.getAppointmentTime());
    appointment.setEndTime(request.getEndTime());
    appointment.setAppointmentType(Appointment.AppointmentType.valueOf(request.getAppointmentType()));
    appointment.setConsultationFee(request.getConsultationFee());
    appointment.setSymptoms(request.getSymptoms());
    appointment.setNotes(request.getNotes());
    
    return appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 120**: Method to update an existing appointment
- **Lines 121-122**: Find appointment by ID, exclude soft-deleted records
- **Lines 124-125**: Validate new doctor exists
- **Lines 127-129**: Business rule: updated date must be in the future
- **Lines 131-139**: Update all appointment fields with new values
- **Line 141**: Save and return updated appointment

---

## Cancel Appointment (Lines 144-164)

```java
public Appointment cancelAppointment(Long id, String reason) {
    Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
    
    if (appointment.getStatus() == Appointment.Status.CANCELLED) {
        throw new RuntimeException("Appointment is already cancelled");
    }
    
    // Free up the slot
    if (appointment.getDoctorSlot() != null) {
        DoctorSlot slot = appointment.getDoctorSlot();
        slot.setStatus(DoctorSlot.SlotStatus.AVAILABLE);
        doctorSlotRepository.save(slot);
    }
    
    appointment.setStatus(Appointment.Status.CANCELLED);
    appointment.setCancellationReason(reason);
    appointment.setCancelledAt(LocalDateTime.now());
    
    return appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 144**: Method to cancel an appointment with reason
- **Lines 145-146**: Find appointment by ID, exclude soft-deleted records
- **Lines 148-150**: Business rule: prevent double cancellation
- **Lines 152-156**: Free up the associated slot for other appointments
- **Lines 158-160**: Update appointment status and cancellation details
- **Line 162**: Save and return cancelled appointment

---

## Get Upcoming Appointments (Lines 166-175)

```java
public List<Appointment> getUpcomingAppointmentsByPatient(Long patientId) {
    try {
        List<Appointment> appointments = appointmentRepository.findUpcomingAppointmentsByPatient(patientId, LocalDate.now());
        return appointments;
    } catch (Exception e) {
        System.err.println("ERROR in getUpcomingAppointmentsByPatient: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Failed to retrieve upcoming appointments: " + e.getMessage(), e);
    }
}
```

**Explanation:**
- **Line 166**: Method to get upcoming appointments for a patient
- **Line 168**: Query repository for appointments from today onwards
- **Line 169**: Return the list of upcoming appointments
- **Lines 170-174**: Exception handling with detailed logging and error wrapping

---

## Get Past Appointments (Lines 177-186)

```java
public List<Appointment> getPastAppointmentsByPatient(Long patientId) {
    try {
        List<Appointment> appointments = appointmentRepository.findPastAppointmentsByPatient(patientId, LocalDate.now());
        return appointments;
    } catch (Exception e) {
        System.err.println("ERROR in getPastAppointmentsByPatient: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Failed to retrieve past appointments: " + e.getMessage(), e);
    }
}
```

**Explanation:**
- **Line 177**: Method to get past appointments for a patient
- **Line 179**: Query repository for appointments before today
- **Line 180**: Return the list of past appointments
- **Lines 181-185**: Exception handling with detailed logging

---

## Get All Appointments (Lines 188-205)

```java
public Map<String, Object> getAllAppointmentsByPatient(Long patientId) {
    try {
        List<Appointment> upcoming = getUpcomingAppointmentsByPatient(patientId);
        List<Appointment> past = getPastAppointmentsByPatient(patientId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("upcoming", upcoming);
        result.put("past", past);
        result.put("totalUpcoming", upcoming.size());
        result.put("totalPast", past.size());
        
        return result;
    } catch (Exception e) { 
        System.err.println("ERROR in getAllAppointmentsByPatient: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Failed to retrieve appointments: " + e.getMessage(), e);
    }
}
```

**Explanation:**
- **Line 188**: Method to get both upcoming and past appointments
- **Lines 190-191**: Get both upcoming and past appointments
- **Lines 193-197**: Create result map with both lists and counts
- **Line 199**: Return comprehensive appointment data
- **Lines 200-204**: Exception handling with detailed logging

---

## Get Paginated Appointments (Lines 207-241)

```java
public Map<String, Object> getAppointmentsByPatientPaginated(Long patientId, String status, org.springframework.data.domain.Pageable pageable) {
    try {
        // Convert string to enum if not null
        Appointment.Status statusEnum = null;
        
        if (status != null && !status.trim().isEmpty()) {
            try {
                statusEnum = Appointment.Status.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                // If invalid status, treat as null (no filter)
                statusEnum = null;
            }
        }
        
        // Get paginated appointments
        org.springframework.data.domain.Page<Appointment> appointmentPage = appointmentRepository.findByPatientIdAndStatusAndDeletedAtIsNull(
            patientId, status, statusEnum, pageable);
        
        Map<String, Object> result = new HashMap<>();
        result.put("appointments", appointmentPage.getContent());
        result.put("currentPage", appointmentPage.getNumber());
        result.put("totalPages", appointmentPage.getTotalPages());
        result.put("totalElements", appointmentPage.getTotalElements());
        result.put("size", appointmentPage.getSize());
        result.put("first", appointmentPage.isFirst());
        result.put("last", appointmentPage.isLast());
        result.put("numberOfElements", appointmentPage.getNumberOfElements());
        
        return result;
    } catch (Exception e) {
        System.err.println("ERROR in getAppointmentsByPatientPaginated: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Failed to retrieve paginated appointments: " + e.getMessage(), e);
    }
}
```

**Explanation:**
- **Line 207**: Method for paginated appointments with status filtering
- **Lines 209-220**: Convert string status to enum with error handling
- **Lines 222-223**: Query repository with patient ID, status, and pagination
- **Lines 225-234**: Build result map with pagination metadata
- **Line 236**: Return paginated results with metadata
- **Lines 237-241**: Exception handling with detailed logging

---

## Get Paginated Appointments with Date Filter (Lines 243-288)

```java
public Map<String, Object> getAppointmentsByPatientPaginatedWithDateFilter(Long patientId, String status, String type, org.springframework.data.domain.Pageable pageable) {
    try {
        // Convert string to enum if not null
        Appointment.Status statusEnum = null;
        
        if (status != null && !status.trim().isEmpty()) {
            try {
                statusEnum = Appointment.Status.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                // If invalid status, treat as null (no filter)
                statusEnum = null;
            }
        }
        
        java.time.LocalDate today = java.time.LocalDate.now();
        org.springframework.data.domain.Page<Appointment> appointmentPage;
        
        if ("upcoming".equalsIgnoreCase(type)) {
            appointmentPage = appointmentRepository.findUpcomingAppointmentsByPatient(
                patientId, status, statusEnum, today, pageable);
        } else if ("past".equalsIgnoreCase(type)) {
            appointmentPage = appointmentRepository.findPastAppointmentsByPatient(
                patientId, status, statusEnum, today, pageable);
        } else {
            // Fallback to all appointments
            appointmentPage = appointmentRepository.findByPatientIdAndStatusAndDeletedAtIsNull(
                patientId, status, statusEnum, pageable);
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("appointments", appointmentPage.getContent());
        result.put("currentPage", appointmentPage.getNumber());
        result.put("totalPages", appointmentPage.getTotalPages());
        result.put("totalElements", appointmentPage.getTotalElements());
        result.put("size", appointmentPage.getSize());
        result.put("first", appointmentPage.isFirst());
        result.put("last", appointmentPage.isLast());
        result.put("numberOfElements", appointmentPage.getNumberOfElements());
        
        return result;
    } catch (Exception e) {
        System.err.println("ERROR in getAppointmentsByPatientPaginatedWithDateFilter: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Failed to retrieve paginated appointments: " + e.getMessage(), e);
    }
}
```

**Explanation:**
- **Line 243**: Method for paginated appointments with date and status filtering
- **Lines 245-256**: Convert string status to enum with error handling
- **Line 258**: Get current date for filtering
- **Lines 260-270**: Route to appropriate repository method based on type filter
- **Lines 272-281**: Build result map with pagination metadata
- **Line 283**: Return filtered and paginated results
- **Lines 284-288**: Exception handling with detailed logging

---

## Reschedule Appointment (Lines 290-347)

```java
public Appointment rescheduleAppointment(Long id, LocalDate newDate, LocalTime newTime, LocalTime newEndTime) {
    Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
    
    if (appointment.getStatus() == Appointment.Status.CANCELLED) {
        throw new RuntimeException("Cannot reschedule a cancelled appointment");
    }
    
    if (newDate.isBefore(LocalDate.now())) {
        throw new RuntimeException("Cannot reschedule to a past date");
    }
    
    // Free up the current slot
    if (appointment.getDoctorSlot() != null) {
        DoctorSlot currentSlot = appointment.getDoctorSlot();
        currentSlot.setStatus(DoctorSlot.SlotStatus.AVAILABLE);
        doctorSlotRepository.save(currentSlot);
    }
    
    // Find new available slot
    List<DoctorSlot> availableSlots = doctorSlotRepository.findAvailableSlotsByDoctorAndDate(
        appointment.getDoctor().getDoctorId(), newDate);
    
    DoctorSlot newSlot = null;
    for (DoctorSlot slot : availableSlots) {
        if (slot.getStartTime().equals(newTime) && slot.getEndTime().equals(newEndTime)) {
            newSlot = slot;
            break;
        }
    }
    
    if (newSlot == null) {
        throw new RuntimeException("No available slot found for the selected time");
    }
    
    // Check for conflicts with new time
    List<Appointment> conflictingAppointments = appointmentRepository.findByDoctorAndDateTime(
        appointment.getDoctor(), newDate, newTime);
    
    // Remove current appointment from conflict check
    conflictingAppointments.removeIf(conflict -> conflict.getId().equals(id));
    
    if (!conflictingAppointments.isEmpty()) {
        throw new RuntimeException("Doctor is not available at the selected time");
    }
    
    // Book the new slot
    newSlot.setStatus(DoctorSlot.SlotStatus.BOOKED);
    doctorSlotRepository.save(newSlot);
    
    appointment.setDoctorSlot(newSlot);
    appointment.setAppointmentDate(newDate);
    appointment.setAppointmentTime(newTime);
    appointment.setEndTime(newEndTime);
    appointment.setStatus(Appointment.Status.SCHEDULED); // Reset to scheduled
    
    return appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 290**: Method to reschedule an appointment to new date/time
- **Lines 291-292**: Find appointment by ID, exclude soft-deleted records
- **Lines 294-296**: Business rule: cannot reschedule cancelled appointments
- **Lines 298-300**: Business rule: cannot reschedule to past dates
- **Lines 302-306**: Free up the current slot for other appointments
- **Lines 308-309**: Find available slots for the new date
- **Lines 311-317**: Find the specific slot matching new time
- **Lines 319-321**: Validate that a matching slot exists
- **Lines 323-325**: Check for conflicts with other appointments
- **Lines 327-328**: Exclude current appointment from conflict check
- **Lines 330-332**: Business rule: prevent double-booking
- **Lines 334-335**: Book the new slot
- **Lines 337-342**: Update appointment with new schedule
- **Line 344**: Save and return rescheduled appointment

---

## Get All Appointments (Admin) (Lines 349-351)

```java
public Page<Appointment> getAllAppointments(Pageable pageable) {
    return appointmentRepository.findAll(pageable);
}
```

**Explanation:**
- **Line 349**: Method to get all appointments (admin function)
- **Line 350**: Delegate to repository for all appointments with pagination

---

## Get All Appointments with Filters (Lines 353-396)

```java
public Page<Appointment> getAllAppointments(String patientName, String doctorName, String status, 
                                           String appointmentType, String dateFrom, String dateTo, Pageable pageable) {
    // Convert string parameters to proper types
    Appointment.Status statusEnum = null;
    if (status != null && !status.isEmpty()) {
        try {
            statusEnum = Appointment.Status.valueOf(status.toUpperCase());
        } catch (IllegalArgumentException e) {
            // Invalid status, will be ignored
        }
    }
    
    Appointment.AppointmentType appointmentTypeEnum = null;
    if (appointmentType != null && !appointmentType.isEmpty()) {
        try {
            appointmentTypeEnum = Appointment.AppointmentType.valueOf(appointmentType.toUpperCase());
        } catch (IllegalArgumentException e) {
            // Invalid appointment type, will be ignored
        }
    }
    
    LocalDate dateFromParsed = null;
    if (dateFrom != null && !dateFrom.isEmpty()) {
        try {
            dateFromParsed = LocalDate.parse(dateFrom);
        } catch (Exception e) {
            // Invalid date format, will be ignored
        }
    }
    
    LocalDate dateToParsed = null;
    if (dateTo != null && !dateTo.isEmpty()) {
        try {
            dateToParsed = LocalDate.parse(dateTo);
        } catch (Exception e) {
            // Invalid date format, will be ignored
        }
    }
    
    // Use the method that includes deleted records for display purposes
    return appointmentRepository.findAppointmentsWithFiltersIncludingDeleted(patientName, doctorName, status, statusEnum,
                                                                            appointmentType, appointmentTypeEnum, 
                                                                            dateFrom, dateFromParsed, dateTo, dateToParsed, pageable);
}
```

**Explanation:**
- **Line 353**: Method for admin to get all appointments with comprehensive filtering
- **Lines 355-363**: Convert string status to enum with error handling
- **Lines 365-373**: Convert string appointment type to enum with error handling
- **Lines 375-383**: Parse date from string with error handling
- **Lines 385-393**: Parse date to string with error handling
- **Lines 395-396**: Query repository with all filters including deleted records

---

## Update Appointment (Map-based) (Lines 398-454)

```java
public Appointment updateAppointment(Long id, Map<String, Object> updateData) {
    Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
    
    // Only update fields that are provided and not null
    if (updateData.containsKey("appointmentDate") && updateData.get("appointmentDate") != null) {
        appointment.setAppointmentDate(java.time.LocalDate.parse(updateData.get("appointmentDate").toString()));
    }
    if (updateData.containsKey("appointmentTime") && updateData.get("appointmentTime") != null) {
        LocalTime newAppointmentTime = java.time.LocalTime.parse(updateData.get("appointmentTime").toString());
        appointment.setAppointmentTime(newAppointmentTime);
        
        // If endTime is not provided, calculate it (default 30 minutes after start time)
        if (!updateData.containsKey("endTime") || updateData.get("endTime") == null) {
            appointment.setEndTime(newAppointmentTime.plusMinutes(30));
        }
    }
    if (updateData.containsKey("endTime") && updateData.get("endTime") != null) {
        appointment.setEndTime(java.time.LocalTime.parse(updateData.get("endTime").toString()));
    }
    if (updateData.containsKey("appointmentType") && updateData.get("appointmentType") != null) {
        String typeStr = updateData.get("appointmentType").toString();
        try {
            appointment.setAppointmentType(Appointment.AppointmentType.valueOf(typeStr.toUpperCase()));
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid appointment type: " + typeStr);
        }
    }
    if (updateData.containsKey("status") && updateData.get("status") != null) {
        String statusStr = updateData.get("status").toString();
        try {
            appointment.setStatus(Appointment.Status.valueOf(statusStr.toUpperCase()));
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid status: " + statusStr);
        }
    }
    if (updateData.containsKey("consultationFee") && updateData.get("consultationFee") != null) {
        Object fee = updateData.get("consultationFee");
        if (fee instanceof Number) {
            appointment.setConsultationFee(java.math.BigDecimal.valueOf(((Number) fee).doubleValue()));
        } else if (fee instanceof String) {
            appointment.setConsultationFee(new java.math.BigDecimal((String) fee));
        }
    }
    if (updateData.containsKey("symptoms") && updateData.get("symptoms") != null) {
        appointment.setSymptoms((String) updateData.get("symptoms"));
    }
    if (updateData.containsKey("notes") && updateData.get("notes") != null) {
        appointment.setNotes((String) updateData.get("notes"));
    }
    
    // Update audit fields
    appointment.setUpdatedAt(LocalDateTime.now());
    appointment.setUpdatedBy(appointment.getPatient().getId());
    
    return appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 398**: Method to update appointment with flexible field updates
- **Lines 399-400**: Find appointment by ID, exclude soft-deleted records
- **Lines 402-404**: Update appointment date if provided
- **Lines 405-412**: Update appointment time with automatic end time calculation
- **Lines 413-415**: Update end time if explicitly provided
- **Lines 416-423**: Update appointment type with validation
- **Lines 424-431**: Update status with validation
- **Lines 432-439**: Update consultation fee with type conversion
- **Lines 440-442**: Update symptoms if provided
- **Lines 443-445**: Update notes if provided
- **Lines 447-449**: Update audit fields
- **Line 451**: Save and return updated appointment

---

## Delete Appointment (Lines 456-462)

```java
public void deleteAppointment(Long id) {
    Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
    
    appointment.setDeletedAt(LocalDateTime.now());
    appointmentRepository.save(appointment);
}
```

**Explanation:**
- **Line 456**: Method to soft-delete an appointment
- **Lines 457-458**: Find appointment by ID, exclude soft-deleted records
- **Line 460**: Set deletion timestamp (soft delete)
- **Line 461**: Save the appointment with deletion timestamp

---

## Get Appointment Statistics (Lines 464-473)

```java
public Object getAppointmentStats() {
    Map<String, Object> stats = new HashMap<>();
    
    stats.put("totalAppointments", appointmentRepository.count());
    stats.put("pendingAppointments", appointmentRepository.countByStatus(Appointment.Status.SCHEDULED));
    stats.put("completedAppointments", appointmentRepository.countByStatus(Appointment.Status.COMPLETED));
    stats.put("cancelledAppointments", appointmentRepository.countByStatus(Appointment.Status.CANCELLED));
    
    return stats;
}
```

**Explanation:**
- **Line 464**: Method to get appointment statistics for dashboard
- **Line 465**: Create result map
- **Lines 467-470**: Count appointments by status
- **Line 472**: Return statistics map

---

## Create Appointment from Slot (Lines 475-505)

```java
public Map<String, Object> createAppointmentFromSlot(DoctorSlot slot, Long patientId, String symptoms, String notes) {
    User patient = userRepository.findById(patientId)
            .orElseThrow(() -> new RuntimeException("Patient not found"));
    
    Appointment appointment = new Appointment();
    appointment.setPatient(patient);
    appointment.setDoctor(slot.getDoctor());
    appointment.setDoctorSlot(slot);
    appointment.setAppointmentDate(slot.getSlotDate());
    appointment.setAppointmentTime(slot.getStartTime());
    appointment.setEndTime(slot.getEndTime());
    appointment.setStatus(Appointment.Status.SCHEDULED);
    appointment.setAppointmentType(Appointment.AppointmentType.CONSULTATION);
    appointment.setConsultationFee(slot.getDoctor().getConsultationFee());
    appointment.setSymptoms(symptoms);
    appointment.setNotes(notes);
    appointment.setCreatedBy(patientId);
    
    Appointment savedAppointment = appointmentRepository.save(appointment);
    
    Map<String, Object> result = new HashMap<>();
    result.put("appointmentId", savedAppointment.getId());
    result.put("appointmentDate", savedAppointment.getAppointmentDate());
    result.put("appointmentTime", savedAppointment.getAppointmentTime());
    result.put("doctorName", savedAppointment.getDoctor().getUser().getName());
    result.put("specialization", savedAppointment.getDoctor().getSpecialization().getName());
    result.put("consultationFee", savedAppointment.getConsultationFee());
    result.put("status", savedAppointment.getStatus());
    
    return result;
}
```

**Explanation:**
- **Line 475**: Method to create appointment directly from a doctor slot
- **Lines 476-477**: Validate patient exists
- **Lines 479-490**: Create appointment with slot details
- **Line 492**: Save the appointment
- **Lines 494-503**: Build result map with appointment details
- **Line 505**: Return appointment summary

---

## Summary

The `AppointmentService` provides comprehensive business logic for appointment management with the following key features:

1. **CRUD Operations**: Complete create, read, update, and delete functionality
2. **Business Rules**: Date validation, conflict detection, and status management
3. **Slot Management**: Integration with doctor slots for availability tracking
4. **Flexible Querying**: Multiple search and filter options
5. **Pagination Support**: Efficient handling of large datasets
6. **Error Handling**: Comprehensive exception handling and logging
7. **Audit Trail**: Tracking of creation, updates, and deletions
8. **Data Validation**: Input validation and type conversion
9. **Statistics**: Dashboard statistics for administrative purposes
10. **Soft Deletes**: Safe deletion with audit trail preservation

The service layer ensures data integrity, enforces business rules, and provides a clean interface between the controller and repository layers.
