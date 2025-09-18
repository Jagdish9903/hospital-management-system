package com.example.SpringDemo.controller;

import com.example.SpringDemo.dto.ApiResponse;
import com.example.SpringDemo.dto.AppointmentRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.service.AppointmentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/appointments")
@CrossOrigin(origins = "*")
public class AppointmentController {
    
    @Autowired
    private AppointmentService appointmentService;
    
    @PostMapping
    public ResponseEntity<ApiResponse<Appointment>> createAppointment(@Valid @RequestBody AppointmentRequest request) {
        try {
            System.out.println("=== APPOINTMENT CREATION DEBUG ===");
            System.out.println("Received appointment request: " + request);
            System.out.println("Patient ID: " + request.getPatientId());
            System.out.println("Doctor ID: " + request.getDoctorId());
            System.out.println("Appointment Date: " + request.getAppointmentDate());
            System.out.println("Appointment Time: " + request.getAppointmentTime());
            System.out.println("End Time: " + request.getEndTime());
            System.out.println("Appointment Type: " + request.getAppointmentType());
            System.out.println("Consultation Fee: " + request.getConsultationFee());
            System.out.println("Symptoms: " + request.getSymptoms());
            System.out.println("Notes: " + request.getNotes());
            
            // Validate required fields
            if (request.getPatientId() == null) {
                throw new RuntimeException("Patient ID is required");
            }
            if (request.getDoctorId() == null) {
                throw new RuntimeException("Doctor ID is required");
            }
            if (request.getAppointmentDate() == null) {
                throw new RuntimeException("Appointment date is required");
            }
            if (request.getAppointmentTime() == null) {
                throw new RuntimeException("Appointment time is required");
            }
            if (request.getEndTime() == null) {
                throw new RuntimeException("End time is required");
            }
            if (request.getAppointmentType() == null || request.getAppointmentType().trim().isEmpty()) {
                throw new RuntimeException("Appointment type is required");
            }
            if (request.getConsultationFee() == null) {
                throw new RuntimeException("Consultation fee is required");
            }
            
            Appointment appointment = appointmentService.createAppointment(request);
            System.out.println("Appointment created successfully with ID: " + appointment.getId());
            
            return ResponseEntity.ok(ApiResponse.success("Appointment created successfully", appointment));
        } catch (Exception e) {
            System.err.println("Error creating appointment: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().body(ApiResponse.error("Error creating appointment: " + e.getMessage()));
        }
    }
    
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
    
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Appointment>> getAppointmentById(@PathVariable Long id) {
        Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
        if (appointment.isPresent()) {
            return ResponseEntity.ok(ApiResponse.success(appointment.get()));
        } else {
            return ResponseEntity.badRequest().body(ApiResponse.error("Appointment not found"));
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Appointment>> updateAppointment(@PathVariable Long id, 
                                                                     @Valid @RequestBody AppointmentRequest request) {
        try {
            Appointment appointment = appointmentService.updateAppointment(id, request);
            return ResponseEntity.ok(ApiResponse.success("Appointment updated successfully", appointment));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
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
    
    @GetMapping("/patient/{patientId}/upcoming")
    public ResponseEntity<ApiResponse<List<Appointment>>> getUpcomingAppointmentsByPatient(@PathVariable Long patientId) {
        List<Appointment> appointments = appointmentService.getUpcomingAppointmentsByPatient(patientId);
        return ResponseEntity.ok(ApiResponse.success(appointments));
    }
}
