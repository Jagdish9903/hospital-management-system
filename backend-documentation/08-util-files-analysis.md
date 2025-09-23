# Utility Files - Line by Line Analysis

## Overview
This document provides detailed line-by-line analysis of all utility files in the Hospital Management System backend. These files handle custom deserialization, data generation, JWT token generation, password hashing, and security utilities.

---

## 1. CustomLocalTimeDeserializer.java

### File: `backend/src/main/java/com/example/SpringDemo/util/CustomLocalTimeDeserializer.java`

### Package and Imports (Lines 1-10)

```java
package com.example.SpringDemo.util;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;

import java.io.IOException;
import java.time.LocalTime;
```

**Explanation:**
- **Line 1**: Package declaration for utility classes
- **Lines 3-6**: Jackson JSON processing imports for custom deserialization
- **Line 8**: Java IO exception handling
- **Line 9**: Java time class for LocalTime handling

### Class Declaration (Lines 11-12)

```java
public class CustomLocalTimeDeserializer extends JsonDeserializer<LocalTime> {
```

**Explanation:**
- **Line 11**: Class declaration extending Jackson's JsonDeserializer
- **Line 11**: Generic type parameter specifies this deserializes to LocalTime
- **Purpose**: Custom deserializer to handle complex time object structures from frontend

### Deserialize Method (Lines 13-51)

```java
@Override
public LocalTime deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
    JsonNode node = p.getCodec().readTree(p);
    
    System.out.println("=== CUSTOM TIME DESERIALIZER DEBUG ===");
    System.out.println("Received node: " + node);
    System.out.println("Node type: " + node.getNodeType());
    System.out.println("Is object: " + node.isObject());
    System.out.println("Is textual: " + node.isTextual());
    
    // Handle object format: {"hour": 12, "minute": 30, "second": 0, "nano": 0}
    if (node.isObject()) {
        int hour = node.get("hour").asInt();
        int minute = node.get("minute").asInt();
        int second = node.has("second") ? node.get("second").asInt() : 0;
        int nano = node.has("nano") ? node.get("nano").asInt() : 0;
        
        LocalTime result = LocalTime.of(hour, minute, second, nano);
        System.out.println("Parsed from object: " + result);
        return result;
    }
    
    // Handle string format: "12:30:00"
    if (node.isTextual()) {
        String timeStr = node.asText();
        String[] parts = timeStr.split(":");
        int hour = Integer.parseInt(parts[0]);
        int minute = Integer.parseInt(parts[1]);
        int second = parts.length > 2 ? Integer.parseInt(parts[2]) : 0;
        
        LocalTime result = LocalTime.of(hour, minute, second);
        System.out.println("Parsed from string: " + result);
        return result;
    }
    
    System.err.println("Cannot deserialize LocalTime from: " + node);
    throw new IOException("Cannot deserialize LocalTime from: " + node);
}
```

**Explanation:**
- **Line 14**: Override method from JsonDeserializer interface
- **Lines 15-16**: Method signature with JSON parser and deserialization context
- **Line 17**: Parse JSON input into a JsonNode for processing
- **Lines 19-22**: Debug logging to track deserialization process
- **Line 19**: Log the received JSON node
- **Line 20**: Log the node type (object, array, text, etc.)
- **Line 21**: Check if node is a JSON object
- **Line 22**: Check if node is a JSON string
- **Lines 24-32**: Handle object format (e.g., {"hour": 12, "minute": 30})
- **Line 25**: Extract hour from object
- **Line 26**: Extract minute from object
- **Line 27**: Extract second if present, default to 0
- **Line 28**: Extract nano if present, default to 0
- **Line 30**: Create LocalTime from extracted values
- **Line 31**: Log the parsed result
- **Line 32**: Return the parsed LocalTime
- **Lines 34-42**: Handle string format (e.g., "12:30:00")
- **Line 35**: Get string value from node
- **Line 36**: Split string by colon delimiter
- **Line 37**: Parse hour from first part
- **Line 38**: Parse minute from second part
- **Line 39**: Parse second from third part if present, default to 0
- **Line 41**: Create LocalTime from parsed values
- **Line 42**: Log the parsed result
- **Line 43**: Return the parsed LocalTime
- **Lines 45-46**: Handle unsupported formats
- **Line 45**: Log error for unsupported format
- **Line 46**: Throw IOException for unsupported format

**Purpose**: This deserializer handles two common time formats from frontend:
1. Object format: `{"hour": 12, "minute": 30, "second": 0, "nano": 0}`
2. String format: `"12:30:00"`

---

## 2. DataGenerator.java

### File: `backend/src/main/java/com/example/SpringDemo/util/DataGenerator.java`

### Package and Imports (Lines 1-22)

```java
package com.example.SpringDemo.util;

import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Doctor;
import com.example.SpringDemo.entity.DoctorSlot;
import com.example.SpringDemo.entity.DoctorSlotTemplate;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.AppointmentRepository;
import com.example.SpringDemo.repository.DoctorRepository;
import com.example.SpringDemo.repository.DoctorSlotRepository;
import com.example.SpringDemo.repository.DoctorSlotTemplateRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
```

**Explanation:**
- **Line 1**: Package declaration for utility classes
- **Lines 3-7**: Import entity classes for data generation
- **Lines 8-12**: Import repository interfaces for data access
- **Line 13**: Spring dependency injection annotation
- **Line 14**: Spring component annotation
- **Lines 16-22**: Java imports for data types and collections

### Class Declaration and Dependencies (Lines 24-39)

```java
@Component
public class DataGenerator {

    @Autowired
    private DoctorSlotRepository doctorSlotRepository;

    @Autowired
    private DoctorSlotTemplateRepository doctorSlotTemplateRepository;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private UserRepository userRepository;
```

**Explanation:**
- **Line 24**: `@Component` marks this as a Spring-managed component
- **Line 25**: Class declaration for data generation utility
- **Lines 27-39**: Inject all required repositories for data access
- **Purpose**: Utility class for generating test data and sample appointments

### Generate Comprehensive Data Method (Lines 41-58)

```java
public void generateComprehensiveData() {
    System.out.println("Starting comprehensive data generation...");
    
    // Generate slots for all doctors (1-12) for the next 2 weeks
    LocalDate startDate = LocalDate.now();
    LocalDate endDate = startDate.plusWeeks(2);
    
    for (long doctorId = 1; doctorId <= 12; doctorId++) {
        try {
            generateSlotsForDoctor(doctorId, startDate, endDate);
            System.out.println("Generated slots for doctor " + doctorId);
        } catch (Exception e) {
            System.err.println("Error generating slots for doctor " + doctorId + ": " + e.getMessage());
        }
    }
    
    System.out.println("Data generation completed!");
}
```

**Explanation:**
- **Line 41**: Public method to generate comprehensive test data
- **Line 42**: Log start of data generation process
- **Lines 44-45**: Set date range for slot generation (next 2 weeks)
- **Lines 47-53**: Loop through all doctors (IDs 1-12)
- **Line 48**: Try to generate slots for each doctor
- **Line 49**: Call helper method to generate slots
- **Line 50**: Log successful generation
- **Lines 51-52**: Handle and log any errors
- **Line 55**: Log completion of data generation

### Generate Slots for Doctor Method (Lines 60-93)

```java
private void generateSlotsForDoctor(Long doctorId, LocalDate startDate, LocalDate endDate) {
    // Get all active templates for this doctor
    List<DoctorSlotTemplate> templates = doctorSlotTemplateRepository.findByDoctorDoctorIdAndIsActiveTrue(doctorId);
    
    if (templates.isEmpty()) {
        System.out.println("No templates found for doctor " + doctorId);
        return;
    }

    List<DoctorSlot> slotsToCreate = new ArrayList<>();
    
    LocalDate currentDate = startDate;
    while (!currentDate.isAfter(endDate)) {
        DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
        
        // Find templates for this day of week
        List<DoctorSlotTemplate> dayTemplates = templates.stream()
            .filter(template -> template.getDayOfWeek().equals(dayOfWeek))
            .toList();
        
        for (DoctorSlotTemplate template : dayTemplates) {
            List<DoctorSlot> daySlots = generateSlotsForTemplate(template, currentDate);
            slotsToCreate.addAll(daySlots);
        }
        
        currentDate = currentDate.plusDays(1);
    }
    
    // Save all generated slots in batches
    if (!slotsToCreate.isEmpty()) {
        doctorSlotRepository.saveAll(slotsToCreate);
        System.out.println("Created " + slotsToCreate.size() + " slots for doctor " + doctorId);
    }
}
```

**Explanation:**
- **Line 60**: Private method to generate slots for a specific doctor
- **Lines 61-62**: Get all active slot templates for the doctor
- **Lines 64-67**: Check if templates exist, return if none found
- **Line 69**: Create list to store slots to be created
- **Line 71**: Initialize current date to start date
- **Line 72**: Loop through each date in the range
- **Line 73**: Get day of week for current date
- **Lines 75-77**: Filter templates for current day of week
- **Lines 79-82**: Generate slots for each matching template
- **Line 80**: Call helper method to generate slots for template
- **Line 81**: Add generated slots to list
- **Line 84**: Move to next date
- **Lines 86-89**: Save all generated slots in batch
- **Line 87**: Use saveAll for efficient batch insertion
- **Line 88**: Log number of slots created

### Generate Slots for Template Method (Lines 95-129)

```java
private List<DoctorSlot> generateSlotsForTemplate(DoctorSlotTemplate template, LocalDate slotDate) {
    List<DoctorSlot> slots = new ArrayList<>();
    
    LocalTime currentTime = template.getStartTime();
    LocalTime endTime = template.getEndTime();
    int slotDuration = template.getSlotDurationMinutes();
    
    while (currentTime.plusMinutes(slotDuration).isBefore(endTime) || 
           currentTime.plusMinutes(slotDuration).equals(endTime)) {
        
        // Check if slot already exists
        boolean slotExists = doctorSlotRepository.existsByDoctorDoctorIdAndSlotDateAndStartTimeAndStatus(
            template.getDoctor().getDoctorId(), 
            slotDate, 
            currentTime, 
            DoctorSlot.SlotStatus.AVAILABLE
        );
        
        if (!slotExists) {
            DoctorSlot slot = new DoctorSlot();
            slot.setDoctor(template.getDoctor());
            slot.setSlotDate(slotDate);
            slot.setStartTime(currentTime);
            slot.setEndTime(currentTime.plusMinutes(slotDuration));
            slot.setStatus(DoctorSlot.SlotStatus.AVAILABLE);
            slot.setCreatedBy(1L); // System user
            
            slots.add(slot);
        }
        
        currentTime = currentTime.plusMinutes(slotDuration);
    }
    
    return slots;
}
```

**Explanation:**
- **Line 95**: Private method to generate slots for a specific template
- **Line 96**: Create list to store generated slots
- **Lines 98-100**: Extract template configuration
- **Line 98**: Get start time from template
- **Line 99**: Get end time from template
- **Line 100**: Get slot duration from template
- **Lines 102-103**: Loop while there's time for another slot
- **Line 102**: Check if adding slot duration is before end time
- **Line 103**: Or if it equals end time (exact fit)
- **Lines 105-110**: Check if slot already exists
- **Line 105**: Query repository for existing slot
- **Line 106**: Check by doctor ID
- **Line 107**: Check by slot date
- **Line 108**: Check by start time
- **Line 109**: Check by status (AVAILABLE)
- **Lines 112-120**: Create new slot if it doesn't exist
- **Line 113**: Create new DoctorSlot instance
- **Line 114**: Set doctor from template
- **Line 115**: Set slot date
- **Line 116**: Set start time
- **Line 117**: Set end time (start + duration)
- **Line 118**: Set status to AVAILABLE
- **Line 119**: Set created by system user
- **Line 121**: Add slot to list
- **Line 124**: Move to next time slot
- **Line 127**: Return generated slots

### Generate Sample Appointments Method (Lines 131-156)

```java
public void generateSampleAppointments() {
    System.out.println("Starting sample appointment generation...");
    
    try {
        // Get some patients and doctors
        List<User> patients = userRepository.findByRole(User.Role.PATIENT);
        List<Doctor> doctors = doctorRepository.findAll();
        
        if (patients.isEmpty() || doctors.isEmpty()) {
            System.out.println("No patients or doctors found. Cannot generate appointments.");
            return;
        }
        
        // Generate past appointments (May-July 2025)
        generatePastAppointments(patients, doctors);
        
        // Generate future appointments (after September 18, 2025)
        generateFutureAppointments(patients, doctors);
        
        System.out.println("Sample appointment generation completed!");
        
    } catch (Exception e) {
        System.err.println("Error generating sample appointments: " + e.getMessage());
        e.printStackTrace();
    }
}
```

**Explanation:**
- **Line 131**: Public method to generate sample appointments
- **Line 132**: Log start of appointment generation
- **Lines 134-140**: Get patients and doctors from database
- **Line 135**: Get all patients
- **Line 136**: Get all doctors
- **Lines 138-141**: Check if data exists, return if not
- **Lines 143-144**: Generate past appointments
- **Lines 146-147**: Generate future appointments
- **Line 149**: Log completion
- **Lines 151-155**: Handle and log any errors

### Generate Past Appointments Method (Lines 158-188)

```java
private void generatePastAppointments(List<User> patients, List<Doctor> doctors) {
    System.out.println("Generating past appointments...");
    
    // May 2025 appointments
    createAppointment(patients.get(0), doctors.get(0), LocalDate.of(2025, 5, 15), 
                     LocalTime.of(9, 0), LocalTime.of(9, 30), 
                     "CONSULTATION", "SCHEDULED", "Chest pain evaluation", 
                     "Patient reported mild chest discomfort during exercise", new BigDecimal("150.00"));
    
    createAppointment(patients.get(1), doctors.get(0), LocalDate.of(2025, 5, 15), 
                     LocalTime.of(10, 0), LocalTime.of(10, 30), 
                     "CONSULTATION", "COMPLETED", "Annual heart checkup", 
                     "Routine cardiovascular examination", new BigDecimal("150.00"));
    
    // June 2025 appointments
    createAppointment(patients.get(2), doctors.get(1), LocalDate.of(2025, 6, 10), 
                     LocalTime.of(10, 0), LocalTime.of(10, 45), 
                     "CONSULTATION", "COMPLETED", "Headache consultation", 
                     "New patient with chronic headaches", new BigDecimal("200.00"));
    
    // July 2025 appointments
    createAppointment(patients.get(0), doctors.get(2), LocalDate.of(2025, 7, 8), 
                     LocalTime.of(8, 0), LocalTime.of(9, 0), 
                     "CONSULTATION", "COMPLETED", "Post-surgery follow-up", 
                     "Gallbladder removal follow-up", new BigDecimal("200.00"));
    
    createAppointment(patients.get(1), doctors.get(3), LocalDate.of(2025, 7, 12), 
                     LocalTime.of(8, 30), LocalTime.of(9, 0), 
                     "CONSULTATION", "COMPLETED", "Heart rhythm evaluation", 
                     "ECG and heart monitoring", new BigDecimal("160.00"));
}
```

**Explanation:**
- **Line 158**: Private method to generate past appointments
- **Line 159**: Log start of past appointment generation
- **Lines 161-166**: Create May 2025 appointment
- **Line 161**: Call helper method with patient, doctor, date, times, type, status, symptoms, notes, fee
- **Lines 168-173**: Create another May 2025 appointment
- **Lines 175-180**: Create June 2025 appointment
- **Lines 182-187**: Create July 2025 appointments
- **Purpose**: Creates realistic past appointment data for testing and demonstration

### Generate Future Appointments Method (Lines 190-236)

```java
private void generateFutureAppointments(List<User> patients, List<Doctor> doctors) {
    System.out.println("Generating future appointments...");
    
    // September 2025 appointments (after 18th)
    createAppointment(patients.get(0), doctors.get(0), LocalDate.of(2025, 9, 20), 
                     LocalTime.of(9, 0), LocalTime.of(9, 30), 
                     "CONSULTATION", "SCHEDULED", "Follow-up consultation", 
                     "Post-treatment follow-up", new BigDecimal("150.00"));
    
    createAppointment(patients.get(1), doctors.get(1), LocalDate.of(2025, 9, 22), 
                     LocalTime.of(10, 0), LocalTime.of(10, 45), 
                     "CONSULTATION", "SCHEDULED", "Migraine follow-up", 
                     "Treatment progress review", new BigDecimal("200.00"));
    
    // October 2025 appointments
    createAppointment(patients.get(2), doctors.get(2), LocalDate.of(2025, 10, 3), 
                     LocalTime.of(8, 0), LocalTime.of(9, 0), 
                     "CONSULTATION", "SCHEDULED", "Knee rehabilitation", 
                     "Post-surgery recovery check", new BigDecimal("180.00"));
    
    createAppointment(patients.get(0), doctors.get(3), LocalDate.of(2025, 10, 8), 
                     LocalTime.of(9, 0), LocalTime.of(9, 30), 
                     "CONSULTATION", "SCHEDULED", "Child development check", 
                     "Growth and development assessment", new BigDecimal("120.00"));
    
    // November 2025 appointments
    createAppointment(patients.get(1), doctors.get(4), LocalDate.of(2025, 11, 5), 
                     LocalTime.of(9, 30), LocalTime.of(10, 0), 
                     "CONSULTATION", "SCHEDULED", "Skin treatment follow-up", 
                     "Acne treatment review", new BigDecimal("170.00"));
    
    createAppointment(patients.get(2), doctors.get(0), LocalDate.of(2025, 11, 20), 
                     LocalTime.of(9, 0), LocalTime.of(9, 30), 
                     "CONSULTATION", "SCHEDULED", "Cardiac stress test", 
                     "Exercise stress test", new BigDecimal("150.00"));
    
    // December 2025 appointments
    createAppointment(patients.get(0), doctors.get(1), LocalDate.of(2025, 12, 3), 
                     LocalTime.of(8, 0), LocalTime.of(9, 0), 
                     "CONSULTATION", "SCHEDULED", "Knee recovery check", 
                     "Post-surgery rehabilitation", new BigDecimal("180.00"));
    
    createAppointment(patients.get(1), doctors.get(2), LocalDate.of(2025, 12, 8), 
                     LocalTime.of(9, 0), LocalTime.of(9, 30), 
                     "CONSULTATION", "SCHEDULED", "Child health check", 
                     "Regular pediatric visit", new BigDecimal("120.00"));
}
```

**Explanation:**
- **Line 190**: Private method to generate future appointments
- **Line 191**: Log start of future appointment generation
- **Lines 193-198**: Create September 2025 appointments
- **Lines 200-205**: Create October 2025 appointments
- **Lines 207-212**: Create November 2025 appointments
- **Lines 214-219**: Create December 2025 appointments
- **Purpose**: Creates realistic future appointment data for testing and demonstration

### Create Appointment Helper Method (Lines 238-262)

```java
private void createAppointment(User patient, Doctor doctor, LocalDate date, 
                             LocalTime startTime, LocalTime endTime, 
                             String appointmentType, String status, 
                             String symptoms, String notes, BigDecimal fee) {
    try {
        Appointment appointment = new Appointment();
        appointment.setPatient(patient);
        appointment.setDoctor(doctor);
        appointment.setAppointmentDate(date);
        appointment.setAppointmentTime(startTime);
        appointment.setEndTime(endTime);
        appointment.setAppointmentType(Appointment.AppointmentType.valueOf(appointmentType));
        appointment.setStatus(Appointment.Status.valueOf(status));
        appointment.setSymptoms(symptoms);
        appointment.setNotes(notes);
        appointment.setConsultationFee(fee);
        appointment.setCreatedBy(1L); // System user
        
        appointmentRepository.save(appointment);
        System.out.println("Created appointment for " + patient.getName() + " with " + doctor.getUser().getName() + " on " + date);
        
    } catch (Exception e) {
        System.err.println("Error creating appointment: " + e.getMessage());
    }
}
```

**Explanation:**
- **Lines 238-241**: Private helper method to create appointments
- **Line 238**: Method signature with all required parameters
- **Line 242**: Try-catch block for error handling
- **Lines 243-253**: Create and populate appointment entity
- **Line 243**: Create new Appointment instance
- **Line 244**: Set patient
- **Line 245**: Set doctor
- **Line 246**: Set appointment date
- **Line 247**: Set start time
- **Line 248**: Set end time
- **Line 249**: Convert string to enum for appointment type
- **Line 250**: Convert string to enum for status
- **Line 251**: Set symptoms
- **Line 252**: Set notes
- **Line 253**: Set consultation fee
- **Line 254**: Set created by system user
- **Line 256**: Save appointment to database
- **Line 257**: Log successful creation
- **Lines 259-261**: Handle and log any errors

---

## 3. JwtTokenGenerator.java

### File: `backend/src/main/java/com/example/SpringDemo/util/JwtTokenGenerator.java`

### Package and Imports (Lines 1-8)

```java
package com.example.SpringDemo.util;

import com.example.SpringDemo.config.JwtConfig;
import com.example.SpringDemo.service.UserPrincipal;
import com.example.SpringDemo.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
```

**Explanation:**
- **Line 1**: Package declaration for utility classes
- **Line 3**: Import JWT configuration utility
- **Line 4**: Import custom user principal class
- **Line 5**: Import User entity
- **Line 6**: Spring dependency injection annotation
- **Line 7**: Spring component annotation

### Class Declaration and Dependencies (Lines 9-14)

```java
@Component
public class JwtTokenGenerator {
    
    @Autowired
    private JwtConfig jwtConfig;
```

**Explanation:**
- **Line 9**: `@Component` marks this as a Spring-managed component
- **Line 10**: Class declaration for JWT token generation utility
- **Lines 12-13**: Inject JWT configuration utility

### Generate Token for Super Admin Method (Lines 15-25)

```java
public String generateTokenForSuperAdmin() {
    // Create a mock User object for superadmin
    User superAdmin = new User();
    superAdmin.setId(8L);
    superAdmin.setEmail("superadmin@hospital.com");
    superAdmin.setPasswordHash("$2a$10$y./11hZtBLzprDaWjebW/ezLPhfTzETs.MXpW73e3F05.4Q8ZhrEW");
    superAdmin.setRole(User.Role.SUPERADMIN);
    
    UserPrincipal userPrincipal = UserPrincipal.create(superAdmin);
    return jwtConfig.generateToken(userPrincipal);
}
```

**Explanation:**
- **Line 15**: Public method to generate JWT token for super admin
- **Lines 16-20**: Create mock User object for super admin
- **Line 17**: Set user ID to 8
- **Line 18**: Set email to superadmin@hospital.com
- **Line 19**: Set password hash (BCrypt encoded)
- **Line 20**: Set role to SUPERADMIN
- **Line 22**: Create UserPrincipal from User object
- **Line 23**: Generate JWT token using JWT config
- **Purpose**: Utility method for generating test tokens for super admin access

### Main Method (Lines 27-31)

```java
public static void main(String[] args) {
    // This will be used to generate a test token
    System.out.println("Use this to generate a JWT token for testing");
}
```

**Explanation:**
- **Line 27**: Static main method for standalone execution
- **Line 29**: Print instruction message
- **Purpose**: Placeholder for generating test tokens from command line

---

## 4. PasswordHashGenerator.java

### File: `backend/src/main/java/com/example/SpringDemo/util/PasswordHashGenerator.java`

### Package and Imports (Lines 1-4)

```java
package com.example.SpringDemo.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashGenerator {
```

**Explanation:**
- **Line 1**: Package declaration for utility classes
- **Line 3**: Import BCrypt password encoder
- **Line 5**: Class declaration for password hash generation utility

### Main Method (Lines 6-24)

```java
public static void main(String[] args) {
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    
    String password = args.length > 0 ? args[0] : "password123";
    String hash = encoder.encode(password);
    
    System.out.println("Password: " + password);
    System.out.println("Hash: " + hash);
    
    // Test if the hash matches
    boolean matches = encoder.matches(password, hash);
    System.out.println("Matches: " + matches);
    
    // Test the existing hash from database
    String dbHash = "$2a$10$y./11hZtBLzprDaWjebW/ezLPhfTzETs.MXpW73e3F05.4Q8ZhrEW";
    boolean dbMatches = encoder.matches(password, dbHash);
    System.out.println("Database hash matches: " + dbMatches);
}
```

**Explanation:**
- **Line 6**: Static main method for standalone execution
- **Line 7**: Create BCrypt password encoder instance
- **Line 9**: Get password from command line args or use default
- **Line 10**: Encode password to BCrypt hash
- **Lines 12-13**: Print password and generated hash
- **Lines 15-16**: Test if generated hash matches original password
- **Line 17**: Print match result
- **Lines 19-20**: Test against existing database hash
- **Line 21**: Print database hash match result
- **Purpose**: Utility for generating and testing password hashes

---

## 5. SecurityUtils.java

### File: `backend/src/main/java/com/example/SpringDemo/util/SecurityUtils.java`

### Package and Imports (Lines 1-9)

```java
package com.example.SpringDemo.util;

import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
```

**Explanation:**
- **Line 1**: Package declaration for utility classes
- **Line 3**: Import User entity
- **Line 4**: Import UserService for user operations
- **Line 5**: Spring dependency injection annotation
- **Lines 6-7**: Spring Security imports for authentication context
- **Line 8**: Spring component annotation

### Class Declaration and Dependencies (Lines 10-15)

```java
@Component
public class SecurityUtils {
    
    @Autowired
    private UserService userService;
```

**Explanation:**
- **Line 10**: `@Component` marks this as a Spring-managed component
- **Line 11**: Class declaration for security utility methods
- **Lines 13-14**: Inject UserService for user operations

### Get Current User Method (Lines 16-27)

```java
public User getCurrentUser() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication == null || !authentication.isAuthenticated()) {
        throw new RuntimeException("User not authenticated");
    }
    
    String email = authentication.getName(); // JWT token contains email as subject
    System.out.println("SecurityUtils: Getting user by email: " + email);
    
    return userService.getUserByEmail(email)
            .orElseThrow(() -> new RuntimeException("User not found with email: " + email));
}
```

**Explanation:**
- **Line 16**: Public method to get current authenticated user
- **Line 17**: Get authentication from Spring Security context
- **Lines 18-20**: Check if user is authenticated
- **Line 19**: Throw exception if not authenticated
- **Line 22**: Extract email from authentication (JWT subject)
- **Line 23**: Log email for debugging
- **Lines 25-26**: Get user by email from database
- **Line 26**: Throw exception if user not found
- **Purpose**: Utility method to get current user from security context

### Get Current User Email Method (Lines 29-36)

```java
public String getCurrentUserEmail() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication == null || !authentication.isAuthenticated()) {
        throw new RuntimeException("User not authenticated");
    }
    return authentication.getName();
}
```

**Explanation:**
- **Line 29**: Public method to get current user's email
- **Line 30**: Get authentication from Spring Security context
- **Lines 31-33**: Check if user is authenticated
- **Line 32**: Throw exception if not authenticated
- **Line 34**: Return email from authentication
- **Purpose**: Utility method to get current user's email without database lookup

---

## Summary

The utility files provide essential helper functionality for the Hospital Management System:

### Custom Deserialization:
1. **CustomLocalTimeDeserializer**: Handles complex time object structures from frontend

### Data Generation:
1. **DataGenerator**: Comprehensive test data generation for slots and appointments
2. **JwtTokenGenerator**: Utility for generating test JWT tokens

### Security Utilities:
1. **PasswordHashGenerator**: Utility for generating and testing password hashes
2. **SecurityUtils**: Helper methods for getting current user from security context

### Key Design Features:

1. **Spring Integration**: All utilities are Spring-managed components
2. **Error Handling**: Comprehensive exception handling and logging
3. **Debugging Support**: Extensive logging for troubleshooting
4. **Flexibility**: Utilities support various input formats and scenarios
5. **Reusability**: Helper methods can be used across the application
6. **Testing Support**: Utilities specifically designed for test data generation

### Usage Patterns:

1. **Custom Deserialization**: Used in DTOs for handling frontend data formats
2. **Data Generation**: Used for populating test data and demonstrations
3. **Token Generation**: Used for testing and development
4. **Password Hashing**: Used for password management and testing
5. **Security Context**: Used throughout the application for user identification

These utilities ensure the application has robust data handling, testing capabilities, and security features while maintaining clean, maintainable code.
