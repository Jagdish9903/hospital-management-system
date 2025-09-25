package com.example.SpringDemo.dto;

import com.example.SpringDemo.entity.Doctor;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class DoctorRequest {
    
    @NotBlank(message = "First name is required")
    private String firstName;
    
    @NotBlank(message = "Last name is required")
    private String lastName;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    @Pattern(regexp = ".*@doctor\\.com$", message = "Doctor email must end with @doctor.com")
    private String email;
    
    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters long")
    private String password;
    
    private String contact;
    
    private Doctor.Gender gender;
    
    private String emergencyContactName;
    private String emergencyContactNum;
    private String state;
    private String city;
    private String address;
    private String country;
    private String countryCode;
    private String postalCode;
    private String bloodGroup;
    private String profileUrl;
    
    @NotNull(message = "Specialization ID is required")
    private Long specializationId;
    
    @NotBlank(message = "License number is required")
    private String licenseNumber;
    
    @NotNull(message = "Years of experience is required")
    @Min(value = 0, message = "Years of experience must be greater than 0")
    private Integer yearsOfExp;
    
    @NotBlank(message = "Qualification is required")
    private String qualification;
    
    @NotNull(message = "Consultation fee is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Consultation fee must be greater than 0")
    private BigDecimal consultationFee;
    
    @NotNull(message = "Joining date is required")
    private LocalDate joiningDate;
    
    private String bio;
    
    // Slot management fields
    @NotBlank(message = "Slot start time is required")
    private String slotStartTime; // e.g., "09:00"
    
    @NotBlank(message = "Slot end time is required")
    private String slotEndTime; // e.g., "17:00"
    
    @NotNull(message = "Appointment duration is required")
    @Min(value = 15, message = "Appointment duration must be at least 15 minutes")
    @Max(value = 60, message = "Appointment duration must be at most 60 minutes")
    private Integer appointmentDuration; // in minutes: 15, 30, 45, 60
    
    @NotBlank(message = "Working days are required")
    private String workingDays; // e.g., "MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY"
    
    private Boolean active = true;
}
