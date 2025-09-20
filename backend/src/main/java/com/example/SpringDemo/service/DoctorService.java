package com.example.SpringDemo.service;

import com.example.SpringDemo.dto.DoctorRequest;
import com.example.SpringDemo.entity.Doctor;
import com.example.SpringDemo.entity.Specialization;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.DoctorRepository;
import com.example.SpringDemo.repository.SpecializationRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class DoctorService {
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private SpecializationRepository specializationRepository;
    
    public Doctor createDoctor(DoctorRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        Specialization specialization = specializationRepository.findById(request.getSpecializationId())
                .orElseThrow(() -> new RuntimeException("Specialization not found"));
        
        if (doctorRepository.existsByLicenseNumber(request.getLicenseNumber())) {
            throw new RuntimeException("License number already exists");
        }
        
        // Update user role to DOCTOR when creating a doctor record
        user.setRole(User.Role.DOCTOR);
        userRepository.save(user);
        
        Doctor doctor = new Doctor();
        doctor.setUser(user);
        doctor.setSpecialization(specialization);
        doctor.setLicenseNumber(request.getLicenseNumber());
        doctor.setYearsOfExp(request.getYearsOfExp());
        doctor.setQualification(request.getQualification());
        doctor.setConsultationFee(request.getConsultationFee());
        doctor.setStatus(Doctor.Status.ACTIVE);
        doctor.setJoiningDate(request.getJoiningDate());
        doctor.setBio(request.getBio());
        
        return doctorRepository.save(doctor);
    }
    
    public Page<Doctor> getAllDoctors(Pageable pageable) {
        return doctorRepository.findAll(pageable);
    }
    
    public Page<Doctor> getAllDoctors(String name, String email, String specialization, String status, Pageable pageable) {
        // Use the method that includes deleted records for display purposes
        return doctorRepository.findDoctorsWithFiltersIncludingDeleted(name, email, specialization, status, pageable);
    }
    
    public List<Doctor> getActiveDoctors() {
        return doctorRepository.findAllActive();
    }
    
    public List<Specialization> getSpecializations() {
        return specializationRepository.findAll();
    }
    
    public List<Doctor> getDoctorsBySpecialization(Long specializationId) {
        return doctorRepository.findBySpecializationIdAndActive(specializationId);
    }
    
    public Page<Doctor> searchDoctors(String name, Long specializationId, Integer minExperience, 
                                     Integer maxExperience, BigDecimal minFee, BigDecimal maxFee, 
                                     Pageable pageable) {
        return doctorRepository.findDoctorsWithFilters(name, specializationId, minExperience, 
                                                      maxExperience, minFee, maxFee, pageable);
    }
    
    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }
    
    public Doctor updateDoctor(Long id, DoctorRequest request) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        Specialization specialization = specializationRepository.findById(request.getSpecializationId())
                .orElseThrow(() -> new RuntimeException("Specialization not found"));
        
        doctor.setSpecialization(specialization);
        doctor.setLicenseNumber(request.getLicenseNumber());
        doctor.setYearsOfExp(request.getYearsOfExp());
        doctor.setQualification(request.getQualification());
        doctor.setConsultationFee(request.getConsultationFee());
        doctor.setBio(request.getBio());
        
        return doctorRepository.save(doctor);
    }
    
    public void deleteDoctor(Long id) {
        Doctor doctor = doctorRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        doctor.setDeletedAt(java.time.LocalDateTime.now());
        doctor.setDeletedBy(doctor.getDoctorId());
        doctorRepository.save(doctor);
        
        // Also soft delete the associated user
        User user = doctor.getUser();
        if (user != null && user.getDeletedAt() == null) {
            user.setDeletedAt(java.time.LocalDateTime.now());
            user.setDeletedBy(doctor.getDoctorId());
            userRepository.save(user);
        }
    }
    
    public void deleteDoctorByUserId(Long userId) {
        Doctor doctor = doctorRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Doctor not found for user ID: " + userId));
        
        doctor.setDeletedAt(java.time.LocalDateTime.now());
        doctor.setDeletedBy(doctor.getDoctorId());
        doctorRepository.save(doctor);
    }
    
    public Doctor updateDoctor(Long id, Map<String, Object> updateData) {
        Doctor doctor = doctorRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        // Only update fields that are provided and not null
        if (updateData.containsKey("licenseNumber") && updateData.get("licenseNumber") != null) {
            doctor.setLicenseNumber((String) updateData.get("licenseNumber"));
        }
        if (updateData.containsKey("yearsOfExp") && updateData.get("yearsOfExp") != null) {
            doctor.setYearsOfExp((Integer) updateData.get("yearsOfExp"));
        }
        if (updateData.containsKey("qualification") && updateData.get("qualification") != null) {
            doctor.setQualification((String) updateData.get("qualification"));
        }
        if (updateData.containsKey("consultationFee") && updateData.get("consultationFee") != null) {
            Object fee = updateData.get("consultationFee");
            if (fee instanceof Number) {
                doctor.setConsultationFee(java.math.BigDecimal.valueOf(((Number) fee).doubleValue()));
            } else if (fee instanceof String) {
                doctor.setConsultationFee(new java.math.BigDecimal((String) fee));
            }
        }
        if (updateData.containsKey("bio") && updateData.get("bio") != null) {
            doctor.setBio((String) updateData.get("bio"));
        }
        if (updateData.containsKey("status") && updateData.get("status") != null) {
            String statusStr = updateData.get("status").toString();
            try {
                doctor.setStatus(Doctor.Status.valueOf(statusStr.toUpperCase()));
            } catch (IllegalArgumentException e) {
                throw new RuntimeException("Invalid status: " + statusStr);
            }
        }
        
        // Update audit fields
        doctor.setUpdatedAt(java.time.LocalDateTime.now());
        doctor.setUpdatedBy(doctor.getDoctorId());
        
        return doctorRepository.save(doctor);
    }
    
    public Object getDoctorStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalDoctors", doctorRepository.count());
        stats.put("activeDoctors", doctorRepository.countByStatus(Doctor.Status.ACTIVE));
        stats.put("inactiveDoctors", doctorRepository.countByStatus(Doctor.Status.INACTIVE));
        
        return stats;
    }
}
