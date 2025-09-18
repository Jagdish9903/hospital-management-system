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
        Doctor.Status statusEnum = null;
        if (status != null && !status.isEmpty()) {
            try {
                statusEnum = Doctor.Status.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                // Invalid status, treat as null
            }
        }
        
        return doctorRepository.findDoctorsWithFilters(name, email, specialization, statusEnum, pageable);
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
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        doctorRepository.delete(doctor);
    }
    
    public Doctor updateDoctor(Long id, Doctor doctorData) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (doctorData.getSpecialization() != null) {
            doctor.setSpecialization(doctorData.getSpecialization());
        }
        if (doctorData.getLicenseNumber() != null) {
            doctor.setLicenseNumber(doctorData.getLicenseNumber());
        }
        if (doctorData.getYearsOfExp() != null) {
            doctor.setYearsOfExp(doctorData.getYearsOfExp());
        }
        if (doctorData.getQualification() != null) {
            doctor.setQualification(doctorData.getQualification());
        }
        if (doctorData.getConsultationFee() != null) {
            doctor.setConsultationFee(doctorData.getConsultationFee());
        }
        if (doctorData.getBio() != null) {
            doctor.setBio(doctorData.getBio());
        }
        if (doctorData.getStatus() != null) {
            doctor.setStatus(doctorData.getStatus());
        }
        
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
