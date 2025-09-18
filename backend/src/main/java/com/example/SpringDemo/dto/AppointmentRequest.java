package com.example.SpringDemo.dto;

import com.example.SpringDemo.util.CustomLocalTimeDeserializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class AppointmentRequest {
    
    @NotNull(message = "Patient ID is required")
    private Long patientId;
    
    @NotNull(message = "Doctor ID is required")
    private Long doctorId;
    
    @NotNull(message = "Appointment date is required")
    private LocalDate appointmentDate;
    
    @NotNull(message = "Appointment time is required")
    @JsonDeserialize(using = CustomLocalTimeDeserializer.class)
    private LocalTime appointmentTime;
    
    @NotNull(message = "End time is required")
    @JsonDeserialize(using = CustomLocalTimeDeserializer.class)
    private LocalTime endTime;
    
    @NotNull(message = "Appointment type is required")
    private String appointmentType;
    
    @NotNull(message = "Consultation fee is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Consultation fee must be greater than 0")
    private BigDecimal consultationFee;
    
    private String symptoms;
    private String notes;
}
