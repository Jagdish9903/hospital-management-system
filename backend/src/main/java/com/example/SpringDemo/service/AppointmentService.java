package com.example.SpringDemo.service;

import com.example.SpringDemo.dto.AppointmentRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Doctor;
import com.example.SpringDemo.entity.DoctorSlot;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.AppointmentRepository;
import com.example.SpringDemo.repository.DoctorRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
    
    public Appointment createAppointment(AppointmentRequest request) {
        User patient = userRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        
        Doctor doctor = doctorRepository.findById(request.getDoctorId())
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        // Check if appointment date is in the future
        if (request.getAppointmentDate().isBefore(LocalDate.now())) {
            throw new RuntimeException("Appointment date cannot be in the past");
        }
        
        // Check for conflicts
        List<Appointment> conflictingAppointments = appointmentRepository.findByDoctorAndDateTime(
            doctor, request.getAppointmentDate(), request.getAppointmentTime());
        
        if (!conflictingAppointments.isEmpty()) {
            throw new RuntimeException("Doctor is not available at the selected time");
        }
        
        Appointment appointment = new Appointment();
        appointment.setPatient(patient);
        appointment.setDoctor(doctor);
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
        Appointment appointment = appointmentRepository.findById(id)
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
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        
        if (appointment.getStatus() == Appointment.Status.CANCELLED) {
            throw new RuntimeException("Appointment is already cancelled");
        }
        
        appointment.setStatus(Appointment.Status.CANCELLED);
        appointment.setCancellationReason(reason);
        appointment.setCancelledAt(LocalDateTime.now());
        
        return appointmentRepository.save(appointment);
    }
    
    public List<Appointment> getUpcomingAppointmentsByPatient(Long patientId) {
        return appointmentRepository.findUpcomingAppointmentsByPatient(patientId, LocalDate.now());
    }
    
    public Page<Appointment> getAllAppointments(Pageable pageable) {
        return appointmentRepository.findAll(pageable);
    }
    
    public Page<Appointment> getAllAppointments(String patientName, String doctorName, String status, 
                                               String appointmentType, String dateFrom, String dateTo, Pageable pageable) {
        return appointmentRepository.findAppointmentsWithFilters(patientName, doctorName, status, 
                                                                appointmentType, dateFrom, dateTo, pageable);
    }
    
    public Appointment updateAppointment(Long id, Appointment appointmentData) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        
        if (appointmentData.getDoctor() != null) {
            appointment.setDoctor(appointmentData.getDoctor());
        }
        if (appointmentData.getAppointmentDate() != null) {
            appointment.setAppointmentDate(appointmentData.getAppointmentDate());
        }
        if (appointmentData.getAppointmentTime() != null) {
            appointment.setAppointmentTime(appointmentData.getAppointmentTime());
        }
        if (appointmentData.getEndTime() != null) {
            appointment.setEndTime(appointmentData.getEndTime());
        }
        if (appointmentData.getAppointmentType() != null) {
            appointment.setAppointmentType(appointmentData.getAppointmentType());
        }
        if (appointmentData.getStatus() != null) {
            appointment.setStatus(appointmentData.getStatus());
        }
        if (appointmentData.getConsultationFee() != null) {
            appointment.setConsultationFee(appointmentData.getConsultationFee());
        }
        if (appointmentData.getSymptoms() != null) {
            appointment.setSymptoms(appointmentData.getSymptoms());
        }
        if (appointmentData.getNotes() != null) {
            appointment.setNotes(appointmentData.getNotes());
        }
        
        return appointmentRepository.save(appointment);
    }
    
    public void deleteAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        
        appointment.setDeletedAt(LocalDateTime.now());
        appointmentRepository.save(appointment);
    }
    
    public Object getAppointmentStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalAppointments", appointmentRepository.count());
        stats.put("pendingAppointments", appointmentRepository.countByStatus(Appointment.Status.SCHEDULED));
        stats.put("confirmedAppointments", appointmentRepository.countByStatus(Appointment.Status.CONFIRMED));
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
