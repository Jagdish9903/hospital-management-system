package com.example.SpringDemo.service;

import com.example.SpringDemo.dto.ComplaintRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Complaint;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.AppointmentRepository;
import com.example.SpringDemo.repository.ComplaintRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ComplaintService {
    
    @Autowired
    private ComplaintRepository complaintRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private AppointmentRepository appointmentRepository;
    
    public Complaint createComplaint(ComplaintRequest request) {
        User patient = userRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        
        Complaint complaint = new Complaint();
        complaint.setPatient(patient);
        if (request.getAppointmentId() != null) {
            Appointment appointment = appointmentRepository.findById(request.getAppointmentId())
                    .orElseThrow(() -> new RuntimeException("Appointment not found"));
            complaint.setAppointment(appointment);
        }
        complaint.setCategory(Complaint.Category.valueOf(request.getCategory().toUpperCase()));
        complaint.setTitle(request.getTitle());
        complaint.setDescription(request.getDescription());
        complaint.setContactPreference(Complaint.ContactPreference.valueOf(request.getContactPreference().toUpperCase()));
        complaint.setPriority(request.getPriority() != null ? Complaint.Priority.valueOf(request.getPriority().toUpperCase()) : Complaint.Priority.MEDIUM);
        complaint.setStatus(Complaint.Status.OPEN);
        complaint.setCreatedAt(LocalDateTime.now());
        complaint.setCreatedBy(patient.getId());
        
        return complaintRepository.save(complaint);
    }
    
    public Page<Complaint> getAllComplaints(String category, String status, String priority, 
                                           Long patientId, Long assignedTo, Pageable pageable) {
        return complaintRepository.findComplaintsWithFilters(category, status, priority, 
                                                           patientId, assignedTo, pageable);
    }
    
    public Page<Complaint> getComplaintsByPatient(Long patientId, Pageable pageable) {
        return complaintRepository.findByPatientIdAndDeletedAtIsNull(patientId, pageable);
    }
    
    public Page<Complaint> searchComplaints(String title, String description, String category, 
                                          String status, String priority, Long patientId, 
                                          Long assignedTo, Pageable pageable) {
        return complaintRepository.searchComplaints(title, description, category, status, 
                                                  priority, patientId, assignedTo, pageable);
    }
    
    
    public Complaint updateComplaint(Long id, ComplaintRequest request) {
        Complaint complaint = complaintRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
        
        if (request.getTitle() != null) complaint.setTitle(request.getTitle());
        if (request.getDescription() != null) complaint.setDescription(request.getDescription());
        if (request.getCategory() != null) complaint.setCategory(Complaint.Category.valueOf(request.getCategory().toUpperCase()));
        if (request.getContactPreference() != null) complaint.setContactPreference(Complaint.ContactPreference.valueOf(request.getContactPreference().toUpperCase()));
        if (request.getPriority() != null) complaint.setPriority(Complaint.Priority.valueOf(request.getPriority().toUpperCase()));
        
        complaint.setUpdatedAt(LocalDateTime.now());
        complaint.setUpdatedBy(complaint.getPatient().getId());
        
        return complaintRepository.save(complaint);
    }
    
    public Complaint updateComplaintStatus(Long id, String status, String resolutionNotes) {
        Complaint complaint = complaintRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
        
        complaint.setStatus(Complaint.Status.valueOf(status.toUpperCase()));
        if (resolutionNotes != null) {
            complaint.setResolutionNotes(resolutionNotes);
        }
        complaint.setUpdatedAt(LocalDateTime.now());
        
        return complaintRepository.save(complaint);
    }
    
    
    public void deleteComplaint(Long id) {
        Complaint complaint = complaintRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
        
        complaint.setDeletedAt(LocalDateTime.now());
        complaint.setDeletedBy(complaint.getPatient().getId());
        complaintRepository.save(complaint);
    }
    
    public Object getComplaintStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalComplaints", complaintRepository.countByDeletedAtIsNull());
        stats.put("openComplaints", complaintRepository.countByStatusAndDeletedAtIsNull("OPEN"));
        stats.put("inProgressComplaints", complaintRepository.countByStatusAndDeletedAtIsNull("IN_PROGRESS"));
        stats.put("closedComplaints", complaintRepository.countByStatusAndDeletedAtIsNull("CLOSED"));
        
        return stats;
    }
    
    public Page<Complaint> getAllComplaints(Pageable pageable) {
        return complaintRepository.findAll(pageable);
    }
    
    public Page<Complaint> getAllComplaints(String title, String category, String status, String priority, Pageable pageable) {
        return complaintRepository.findComplaintsWithFilters(title, category, status, priority, pageable);
    }
    
    
    public Complaint updateComplaintStatus(Long id, String status) {
        Complaint complaint = complaintRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
        
        complaint.setStatus(Complaint.Status.valueOf(status.toUpperCase()));
        complaint.setUpdatedAt(LocalDateTime.now());
        
        return complaintRepository.save(complaint);
    }

    public Complaint getComplaintById(Long id) {
        return complaintRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
    }

    public void assignComplaint(Long complaintId, Long adminId) {
        Complaint complaint = getComplaintById(complaintId);
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
        
        if (!admin.getRole().equals(User.Role.ADMIN) && !admin.getRole().equals(User.Role.SUPERADMIN)) {
            throw new RuntimeException("User is not an admin");
        }
        
        complaint.setAssignedTo(admin);
        complaintRepository.save(complaint);
    }

    public void updateComplaintResolution(Long complaintId, Map<String, Object> resolutionData) {
        Complaint complaint = getComplaintById(complaintId);
        
        if (resolutionData.containsKey("status")) {
            complaint.setStatus(Complaint.Status.valueOf(((String) resolutionData.get("status")).toUpperCase()));
        }
        if (resolutionData.containsKey("priority")) {
            complaint.setPriority(Complaint.Priority.valueOf(((String) resolutionData.get("priority")).toUpperCase()));
        }
        if (resolutionData.containsKey("resolution")) {
            complaint.setResolution((String) resolutionData.get("resolution"));
        }
        
        complaintRepository.save(complaint);
    }

    public void addComplaintNote(Long complaintId, String note) {
        Complaint complaint = getComplaintById(complaintId);
        
        // For now, we'll store notes in the resolution field as a simple implementation
        // In a real application, you'd have a separate ComplaintNote entity
        String existingNotes = complaint.getResolution() != null ? complaint.getResolution() : "";
        String updatedNotes = existingNotes + "\n\nNote: " + note;
        complaint.setResolution(updatedNotes);
        
        complaintRepository.save(complaint);
    }
}
