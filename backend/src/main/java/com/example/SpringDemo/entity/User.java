package com.example.SpringDemo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    private LocalDate birthdate;
    
    @Column(nullable = false)
    private String firstname;
    
    @Column(nullable = false)
    private String lastname;
    
    @Column(unique = true, nullable = false)
    private String username;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    private String contact;
    
    @Enumerated(EnumType.STRING)
    private Gender gender;
    
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    
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
    
    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;
    
    @Column(nullable = false)
    private Boolean active = true;
    
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
    
    public enum Role {
        ADMIN, PATIENT
    }
    
    public enum Gender {
        MALE, FEMALE, OTHER
    }
}
