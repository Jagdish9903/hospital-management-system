package com.example.SpringDemo.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class DoctorRequest {
    
    @NotNull(message = "User ID is required")
    private Long userId;
    
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
}
