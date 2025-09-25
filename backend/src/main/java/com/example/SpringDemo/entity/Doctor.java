package com.example.SpringDemo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "doctors")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Doctor {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "doctor_id")
    private Long doctorId;
    
    @Column(nullable = false)
    private String firstName;
    
    @Column(nullable = false)
    private String lastName;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    
    private String contact;
    
    @Enumerated(EnumType.STRING)
    private Gender gender;
    
    @Column(name = "emergency_contact_name")
    private String emergencyContactName;
    
    @Column(name = "emergency_contact_num")
    private String emergencyContactNum;
    
    private String state;
    private String city;
    private String address;
    private String country;
    
    @Column(name = "country_code")
    private String countryCode;
    
    @Column(name = "postal_code")
    private String postalCode;
    
    @Column(name = "blood_group")
    private String bloodGroup;
    
    @Column(name = "profile_url")
    private String profileUrl;
    
    @ManyToOne
    @JoinColumn(name = "specialization_id", nullable = false)
    private Specialization specialization;
    
    @Column(name = "license_number", unique = true, nullable = false)
    private String licenseNumber;
    
    @Column(name = "years_of_exp", nullable = false)
    private Integer yearsOfExp;
    
    @Column(nullable = false)
    private String qualification;
    
    @Column(name = "consultation_fee", nullable = false)
    private BigDecimal consultationFee;
    
    
    @Column(name = "joining_date", nullable = false)
    private LocalDate joiningDate;
    
    @Column(nullable = false)
    private Boolean active = true;
    
    // Slot management fields
    @Column(name = "slot_start_time")
    private String slotStartTime; // e.g., "09:00"
    
    @Column(name = "slot_end_time")
    private String slotEndTime; // e.g., "17:00"
    
    @Column(name = "appointment_duration")
    private Integer appointmentDuration; // in minutes: 15, 30, 45, 60
    
    @Column(name = "working_days")
    private String workingDays; // e.g., "MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY"
    
    private String bio;
    
    // Audit fields
    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "created_by")
    private Long createdBy;
    
    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @Column(name = "updated_by")
    private Long updatedBy;
    
    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;
    
    @Column(name = "deleted_by")
    private Long deletedBy;
    
    public enum Gender {
        MALE, FEMALE, OTHER
    }
    
    // Helper method to get full name
    public String getFullName() {
        return firstName + " " + lastName;
    }
}
