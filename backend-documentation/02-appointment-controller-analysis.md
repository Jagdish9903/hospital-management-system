# AppointmentController - Line by Line Analysis

## File: `backend/src/main/java/com/example/SpringDemo/controller/AppointmentController.java`

### Overview
The `AppointmentController` is a REST controller that handles all HTTP requests related to appointment management. It provides endpoints for creating, reading, updating, and deleting appointments, as well as specialized queries for different user types.

---

## Package and Imports (Lines 1-21)

```java
package com.example.SpringDemo.controller;

import com.example.SpringDemo.dto.ApiResponse;
import com.example.SpringDemo.dto.AppointmentRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
```

**Explanation:**
- **Line 1**: Declares the package for the controller class
- **Lines 3-6**: Imports custom DTOs and entities specific to the application
- **Lines 7-11**: Imports Spring Data classes for pagination and sorting
- **Lines 12-14**: Imports Spring Web classes for REST controller functionality
- **Lines 16-20**: Imports Java time classes and collections for data handling

---

## Class Declaration and Dependencies (Lines 22-28)

```java
@RestController
@RequestMapping("/api/appointments")
@CrossOrigin(origins = "*")
public class AppointmentController {
    
    @Autowired
    private AppointmentService appointmentService;
```

**Explanation:**
- **Line 22**: `@RestController` annotation marks this class as a REST controller that automatically serializes return values to JSON
- **Line 23**: `@RequestMapping("/api/appointments")` sets the base URL path for all endpoints in this controller
- **Line 24**: `@CrossOrigin(origins = "*")` allows cross-origin requests from any domain (useful for frontend development)
- **Line 27-28**: `@Autowired` injects the `AppointmentService` dependency for business logic handling

---

## Create Appointment Endpoint (Lines 30-102)

```java
@PostMapping
public ResponseEntity<ApiResponse<Appointment>> createAppointment(@RequestBody Map<String, Object> requestData) {
    try {
        System.out.println("=== APPOINTMENT CREATION DEBUG ===");
        System.out.println("Received appointment request: " + requestData);
        
        // Extract and validate required fields
        Long patientId = extractLong(requestData, "patientId");
        Long doctorId = extractLong(requestData, "doctorId");
        String appointmentDateStr = extractString(requestData, "appointmentDate");
        Map<String, Object> appointmentTimeObj = extractTimeObject(requestData, "appointmentTime");
        Map<String, Object> endTimeObj = extractTimeObject(requestData, "endTime");
        String appointmentType = extractString(requestData, "appointmentType");
        Object consultationFeeObj = requestData.get("consultationFee");
        String symptoms = extractString(requestData, "symptoms");
        String notes = extractString(requestData, "notes");
```

**Explanation:**
- **Line 30**: `@PostMapping` maps HTTP POST requests to this method
- **Line 31**: Method signature returns a `ResponseEntity` wrapped `ApiResponse` containing an `Appointment` object
- **Line 32**: `@RequestBody Map<String, Object>` receives JSON data as a flexible map structure
- **Lines 33-35**: Debug logging to track appointment creation requests
- **Lines 37-46**: Extract individual fields from the request data using helper methods
- **Lines 37-38**: Extract patient and doctor IDs as Long values
- **Line 39**: Extract appointment date as string (will be parsed later)
- **Lines 40-41**: Extract time objects as maps (handles complex time structures from frontend)
- **Lines 42-45**: Extract remaining appointment details

### Validation Logic (Lines 47-79)

```java
        System.out.println("Extracted data:");
        System.out.println("Patient ID: " + patientId);
        System.out.println("Doctor ID: " + doctorId);
        System.out.println("Appointment Date: " + appointmentDateStr);
        System.out.println("Appointment Time: " + appointmentTimeObj);
        System.out.println("End Time: " + endTimeObj);
        System.out.println("Appointment Type: " + appointmentType);
        System.out.println("Consultation Fee: " + consultationFeeObj);
        System.out.println("Symptoms: " + symptoms);
        System.out.println("Notes: " + notes);
        
        // Validate required fields
        if (patientId == null) {
            throw new RuntimeException("Patient ID is required");
        }
        if (doctorId == null) {
            throw new RuntimeException("Doctor ID is required");
        }
        if (appointmentDateStr == null) {
            throw new RuntimeException("Appointment date is required");
        }
        if (appointmentTimeObj == null) {
            throw new RuntimeException("Appointment time is required");
        }
        if (endTimeObj == null) {
            throw new RuntimeException("End time is required");
        }
        if (appointmentType == null || appointmentType.trim().isEmpty()) {
            throw new RuntimeException("Appointment type is required");
        }
        if (consultationFeeObj == null) {
            throw new RuntimeException("Consultation fee is required");
        }
```

**Explanation:**
- **Lines 47-56**: Debug logging to verify extracted data
- **Lines 58-79**: Comprehensive validation of all required fields
- **Lines 59-61**: Check if patient ID is provided
- **Lines 62-64**: Check if doctor ID is provided
- **Lines 65-67**: Check if appointment date is provided
- **Lines 68-70**: Check if appointment time is provided
- **Lines 71-73**: Check if end time is provided
- **Lines 74-76**: Check if appointment type is provided and not empty
- **Lines 77-79**: Check if consultation fee is provided

### Appointment Creation (Lines 81-101)

```java
        // Create AppointmentRequest object
        AppointmentRequest request = new AppointmentRequest();
        request.setPatientId(patientId);
        request.setDoctorId(doctorId);
        request.setAppointmentDate(java.time.LocalDate.parse(appointmentDateStr));
        request.setAppointmentTime(parseTimeFromObject(appointmentTimeObj));
        request.setEndTime(parseTimeFromObject(endTimeObj));
        request.setAppointmentType(appointmentType);
        request.setConsultationFee(new java.math.BigDecimal(consultationFeeObj.toString()));
        request.setSymptoms(symptoms);
        request.setNotes(notes);
        
        Appointment appointment = appointmentService.createAppointment(request);
        System.out.println("Appointment created successfully with ID: " + appointment.getId());
        
        return ResponseEntity.ok(ApiResponse.success("Appointment created successfully", appointment));
    } catch (Exception e) {
        System.err.println("Error creating appointment: " + e.getMessage());
        e.printStackTrace();
        return ResponseEntity.badRequest().body(ApiResponse.error("Error creating appointment: " + e.getMessage()));
    }
}
```

**Explanation:**
- **Lines 82-91**: Create and populate an `AppointmentRequest` DTO object
- **Line 85**: Parse the date string into a `LocalDate` object
- **Lines 86-87**: Parse time objects into `LocalTime` objects using helper method
- **Line 89**: Convert consultation fee to `BigDecimal` for precise monetary calculations
- **Line 93**: Call the service layer to create the appointment
- **Line 96**: Return success response with the created appointment
- **Lines 97-101**: Exception handling with error logging and error response

---

## Helper Methods (Lines 104-137)

### Extract Long Values (Lines 105-112)

```java
private Long extractLong(Map<String, Object> data, String key) {
    Object value = data.get(key);
    if (value == null) return null;
    if (value instanceof Number) {
        return ((Number) value).longValue();
    }
    return Long.valueOf(value.toString());
}
```

**Explanation:**
- **Line 105**: Helper method to safely extract Long values from the request map
- **Line 106**: Get the value for the specified key
- **Line 107**: Return null if value doesn't exist
- **Lines 108-110**: If value is a Number, convert it to Long
- **Line 111**: Otherwise, convert string representation to Long

### Extract String Values (Lines 114-117)

```java
private String extractString(Map<String, Object> data, String key) {
    Object value = data.get(key);
    return value != null ? value.toString() : null;
}
```

**Explanation:**
- **Line 114**: Helper method to safely extract String values
- **Line 115**: Get the value for the specified key
- **Line 116**: Convert to string if not null, otherwise return null

### Extract Time Objects (Lines 119-126)

```java
@SuppressWarnings("unchecked")
private Map<String, Object> extractTimeObject(Map<String, Object> data, String key) {
    Object value = data.get(key);
    if (value instanceof Map) {
        return (Map<String, Object>) value;
    }
    return null;
}
```

**Explanation:**
- **Line 119**: Suppress unchecked cast warnings
- **Line 120**: Helper method to extract time objects as maps
- **Line 121**: Get the value for the specified key
- **Lines 122-124**: If value is a Map, cast and return it
- **Line 125**: Otherwise return null

### Parse Time from Object (Lines 128-137)

```java
private java.time.LocalTime parseTimeFromObject(Map<String, Object> timeObj) {
    if (timeObj == null) return null;
    
    int hour = ((Number) timeObj.get("hour")).intValue();
    int minute = ((Number) timeObj.get("minute")).intValue();
    int second = timeObj.containsKey("second") ? ((Number) timeObj.get("second")).intValue() : 0;
    int nano = timeObj.containsKey("nano") ? ((Number) timeObj.get("nano")).intValue() : 0;
    
    return java.time.LocalTime.of(hour, minute, second, nano);
}
```

**Explanation:**
- **Line 128**: Helper method to parse time from object structure
- **Line 129**: Return null if time object is null
- **Lines 131-132**: Extract hour and minute (required fields)
- **Lines 133-134**: Extract second and nano (optional fields, default to 0)
- **Line 136**: Create and return LocalTime object

---

## Get Appointments by Patient (Lines 139-153)

```java
@GetMapping("/patient/{patientId}")
public ResponseEntity<ApiResponse<Page<Appointment>>> getAppointmentsByPatient(
        @PathVariable Long patientId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "appointmentDate") String sortBy,
        @RequestParam(defaultValue = "desc") String sortDir) {
    
    Sort sort = sortDir.equalsIgnoreCase("desc") ? 
        Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
    Pageable pageable = PageRequest.of(page, size, sort);
    
    Page<Appointment> appointments = appointmentService.getAppointmentsByPatient(patientId, pageable);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 139**: `@GetMapping("/patient/{patientId}")` maps GET requests with patient ID in URL path
- **Lines 140-145**: Method parameters for pagination and sorting
- **Line 141**: `@PathVariable` extracts patient ID from URL
- **Lines 142-144**: `@RequestParam` with default values for pagination and sorting
- **Lines 147-148**: Create Sort object based on sort direction
- **Line 149**: Create Pageable object with page, size, and sort
- **Line 151**: Call service to get paginated appointments
- **Line 152**: Return success response with appointments

---

## Get Appointments by Doctor (Lines 155-169)

```java
@GetMapping("/doctor/{doctorId}")
public ResponseEntity<ApiResponse<Page<Appointment>>> getAppointmentsByDoctor(
        @PathVariable Long doctorId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "appointmentDate") String sortBy,
        @RequestParam(defaultValue = "desc") String sortDir) {
    
    Sort sort = sortDir.equalsIgnoreCase("desc") ? 
        Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
    Pageable pageable = PageRequest.of(page, size, sort);
    
    Page<Appointment> appointments = appointmentService.getAppointmentsByDoctor(doctorId, pageable);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 155**: `@GetMapping("/doctor/{doctorId}")` maps GET requests with doctor ID in URL path
- **Lines 156-161**: Similar parameter structure to patient endpoint
- **Lines 163-167**: Same pagination and sorting logic as patient endpoint
- **Line 169**: Call service to get doctor's appointments
- **Line 170**: Return success response

---

## Search Appointments (Lines 171-191)

```java
@GetMapping("/search")
public ResponseEntity<ApiResponse<Page<Appointment>>> searchAppointments(
        @RequestParam(required = false) Long patientId,
        @RequestParam(required = false) Long doctorId,
        @RequestParam(required = false) String status,
        @RequestParam(required = false) String appointmentType,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "appointmentDate") String sortBy,
        @RequestParam(defaultValue = "desc") String sortDir) {
    
    Sort sort = sortDir.equalsIgnoreCase("desc") ? 
        Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
    Pageable pageable = PageRequest.of(page, size, sort);
    
    Page<Appointment> appointments = appointmentService.searchAppointments(patientId, doctorId, status, 
                                                                          appointmentType, fromDate, toDate, pageable);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 171**: `@GetMapping("/search")` maps GET requests to search endpoint
- **Lines 172-181**: Multiple optional search parameters
- **Lines 172-175**: Optional filters for patient, doctor, status, and type
- **Lines 176-177**: Optional date range filters with ISO date format
- **Lines 178-180**: Pagination and sorting parameters
- **Lines 183-186**: Same pagination logic as other endpoints
- **Lines 188-189**: Call service with all search parameters
- **Line 190**: Return filtered results

---

## Get Appointment by ID (Lines 193-201)

```java
@GetMapping("/{id}")
public ResponseEntity<ApiResponse<Appointment>> getAppointmentById(@PathVariable Long id) {
    Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
    if (appointment.isPresent()) {
        return ResponseEntity.ok(ApiResponse.success(appointment.get()));
    } else {
        return ResponseEntity.badRequest().body(ApiResponse.error("Appointment not found"));
    }
}
```

**Explanation:**
- **Line 193**: `@GetMapping("/{id}")` maps GET requests with appointment ID
- **Line 194**: Extract appointment ID from URL path
- **Line 195**: Call service to get appointment by ID
- **Lines 196-198**: If appointment exists, return success response
- **Lines 199-201**: If not found, return error response

---

## Update Appointment (Lines 203-212)

```java
@PutMapping("/{id}")
public ResponseEntity<ApiResponse<Appointment>> updateAppointment(@PathVariable Long id, 
                                                                 @RequestBody Map<String, Object> updateData) {
    try {
        Appointment appointment = appointmentService.updateAppointment(id, updateData);
        return ResponseEntity.ok(ApiResponse.success("Appointment updated successfully", appointment));
    } catch (Exception e) {
        return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
    }
}
```

**Explanation:**
- **Line 203**: `@PutMapping("/{id}")` maps PUT requests for updates
- **Line 204**: Extract appointment ID and update data from request
- **Lines 205-207**: Try to update appointment and return success
- **Lines 208-210**: Handle exceptions and return error response

---

## Cancel Appointment (Lines 214-223)

```java
@PutMapping("/{id}/cancel")
public ResponseEntity<ApiResponse<Appointment>> cancelAppointment(@PathVariable Long id, 
                                                                 @RequestParam String reason) {
    try {
        Appointment appointment = appointmentService.cancelAppointment(id, reason);
        return ResponseEntity.ok(ApiResponse.success("Appointment cancelled successfully", appointment));
    } catch (Exception e) {
        return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
    }
}
```

**Explanation:**
- **Line 214**: `@PutMapping("/{id}/cancel")` maps PUT requests to cancel endpoint
- **Line 215**: Extract appointment ID and cancellation reason
- **Lines 216-218**: Try to cancel appointment and return success
- **Lines 219-221**: Handle exceptions and return error response

---

## Get Upcoming Appointments (Lines 225-229)

```java
@GetMapping("/patient/{patientId}/upcoming")
public ResponseEntity<ApiResponse<List<Appointment>>> getUpcomingAppointmentsByPatient(@PathVariable Long patientId) {
    List<Appointment> appointments = appointmentService.getUpcomingAppointmentsByPatient(patientId);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 225**: `@GetMapping("/patient/{patientId}/upcoming")` maps GET requests for upcoming appointments
- **Line 226**: Extract patient ID from URL
- **Line 227**: Call service to get upcoming appointments (no pagination)
- **Line 228**: Return list of upcoming appointments

---

## Get Past Appointments (Lines 231-235)

```java
@GetMapping("/patient/{patientId}/past")
public ResponseEntity<ApiResponse<List<Appointment>>> getPastAppointmentsByPatient(@PathVariable Long patientId) {
    List<Appointment> appointments = appointmentService.getPastAppointmentsByPatient(patientId);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 231**: `@GetMapping("/patient/{patientId}/past")` maps GET requests for past appointments
- **Line 232**: Extract patient ID from URL
- **Line 233**: Call service to get past appointments
- **Line 234**: Return list of past appointments

---

## Get All Appointments (Lines 237-241)

```java
@GetMapping("/patient/{patientId}/all")
public ResponseEntity<ApiResponse<Map<String, Object>>> getAllAppointmentsByPatient(@PathVariable Long patientId) {
    Map<String, Object> appointments = appointmentService.getAllAppointmentsByPatient(patientId);
    return ResponseEntity.ok(ApiResponse.success(appointments));
}
```

**Explanation:**
- **Line 237**: `@GetMapping("/patient/{patientId}/all")` maps GET requests for all appointments
- **Line 238**: Extract patient ID from URL
- **Line 239**: Call service to get both upcoming and past appointments
- **Line 240**: Return map containing both lists and counts

---

## Get Paginated Appointments with Filters (Lines 243-271)

```java
@GetMapping("/patient/{patientId}/paginated")
public ResponseEntity<ApiResponse<Map<String, Object>>> getAppointmentsByPatientPaginated(
        @PathVariable Long patientId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "appointmentDate") String sortBy,
        @RequestParam(defaultValue = "desc") String sortDir,
        @RequestParam(required = false) String status,
        @RequestParam(required = false) String type) {
    try {
        System.out.println("Getting paginated appointments for patient: " + patientId + " page: " + page + " size: " + size + " status: " + status + " type: " + type);
        
        // Create Pageable object
        org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(
            page, 
            size, 
            sortDir.equalsIgnoreCase("desc") ? 
                org.springframework.data.domain.Sort.by(sortBy).descending() : 
                org.springframework.data.domain.Sort.by(sortBy).ascending()
        );
        
        Map<String, Object> appointments = appointmentService.getAppointmentsByPatientPaginatedWithDateFilter(patientId, status, type, pageable);
        return ResponseEntity.ok(ApiResponse.success(appointments));
    } catch (Exception e) {
        System.out.println("Error getting paginated appointments: " + e.getMessage());
        e.printStackTrace();
        return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
    }
}
```

**Explanation:**
- **Line 243**: `@GetMapping("/patient/{patientId}/paginated")` maps GET requests for paginated appointments
- **Lines 244-250**: Parameters for pagination, sorting, and filtering
- **Line 252**: Debug logging for troubleshooting
- **Lines 255-261**: Create Pageable object with sorting
- **Line 263**: Call service with filters and pagination
- **Line 264**: Return paginated results
- **Lines 265-269**: Exception handling with detailed logging

---

## Reschedule Appointment (Lines 273-286)

```java
@PutMapping("/{id}/reschedule")
public ResponseEntity<ApiResponse<Appointment>> rescheduleAppointment(@PathVariable Long id, 
                                                                      @RequestBody Map<String, Object> requestData) {
    try {
        LocalDate newDate = LocalDate.parse(requestData.get("appointmentDate").toString());
        LocalTime newTime = parseTimeFromObject(extractTimeObject(requestData, "appointmentTime"));
        LocalTime newEndTime = parseTimeFromObject(extractTimeObject(requestData, "endTime"));
        
        Appointment appointment = appointmentService.rescheduleAppointment(id, newDate, newTime, newEndTime);
        return ResponseEntity.ok(ApiResponse.success("Appointment rescheduled successfully", appointment));
    } catch (Exception e) {
        return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
    }
}
```

**Explanation:**
- **Line 273**: `@PutMapping("/{id}/reschedule")` maps PUT requests to reschedule endpoint
- **Line 274**: Extract appointment ID and new schedule data
- **Lines 276-278**: Parse new date and times from request data
- **Line 280**: Call service to reschedule appointment
- **Line 281**: Return success response
- **Lines 282-284**: Handle exceptions and return error response

---

## Summary

The `AppointmentController` provides a comprehensive REST API for appointment management with the following key features:

1. **CRUD Operations**: Create, read, update, and cancel appointments
2. **Flexible Querying**: Search by patient, doctor, status, type, and date range
3. **Pagination Support**: Handle large datasets efficiently
4. **Data Validation**: Comprehensive input validation and error handling
5. **Debug Logging**: Extensive logging for troubleshooting
6. **Helper Methods**: Utility methods for data extraction and parsing
7. **Exception Handling**: Proper error responses for all operations

The controller follows RESTful principles and provides a clean interface between the frontend and the business logic layer.
