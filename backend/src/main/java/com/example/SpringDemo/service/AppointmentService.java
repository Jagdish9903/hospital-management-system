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
    
    public Page<Appointment> getAppointmentsByPatient(Long patientId, Pageable pageable) {
        return appointmentRepository.findByPatientId(patientId, pageable);
    }
    
    public Page<Appointment> getAppointmentsByDoctor(Long doctorId, Pageable pageable) {
        return appointmentRepository.findByDoctorId(doctorId, pageable);
    }
    
    public Page<Appointment> searchAppointments(Long patientId, Long doctorId, String status, 
                                               String appointmentType, LocalDate fromDate, 
                                               LocalDate toDate, Pageable pageable) {
        Appointment.Status statusEnum = status != null ? Appointment.Status.valueOf(status) : null;
        Appointment.AppointmentType typeEnum = appointmentType != null ? 
            Appointment.AppointmentType.valueOf(appointmentType) : null;
        
        return appointmentRepository.findAppointmentsWithFilters(patientId, doctorId, statusEnum, 
                                                               typeEnum, fromDate, toDate, pageable);
    }
    
    public Optional<Appointment> getAppointmentById(Long id) {
        return appointmentRepository.findById(id);
    }
    
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
    
    public Page<Appointment> getAllAppointments(Pageable pageable) {
        return appointmentRepository.findAll(pageable);
    }
    
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
    
    public void deleteAppointment(Long id) {
        Appointment appointment = appointmentRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        
        appointment.setDeletedAt(LocalDateTime.now());
        appointmentRepository.save(appointment);
    }
    
    public Object getAppointmentStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalAppointments", appointmentRepository.count());
        stats.put("pendingAppointments", appointmentRepository.countByStatus(Appointment.Status.SCHEDULED));
        stats.put("completedAppointments", appointmentRepository.countByStatus(Appointment.Status.COMPLETED));
        stats.put("cancelledAppointments", appointmentRepository.countByStatus(Appointment.Status.CANCELLED));
        
        return stats;
    }
    
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
}
