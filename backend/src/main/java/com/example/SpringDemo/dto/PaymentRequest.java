package com.example.SpringDemo.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class PaymentRequest {
    
    @NotNull(message = "Appointment ID is required")
    private Long appointmentId;
    
    @NotNull(message = "Patient ID is required")
    private Long patientId;
    
    @NotNull(message = "Amount is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than 0")
    private BigDecimal amount;
    
    @NotBlank(message = "Payment method is required")
    private String method;
    
    private String status;
    
    private String transactionId;
    
    @NotBlank(message = "Cardholder name is required")
    @Size(min = 3, max = 50, message = "Cardholder name must be between 3 and 50 characters")
    @Pattern(regexp = "^[a-zA-Z\\s]+$", message = "Cardholder name must contain only letters and spaces")
    private String cardholderName;
    
    @NotBlank(message = "Card number is required")
    @Pattern(regexp = "^\\d{16}$", message = "Invalid card number")
    private String cardNumber;
    
    @NotBlank(message = "Expiry date is required")
    @Pattern(regexp = "^(0[1-9]|1[0-2])/([0-9]{2})$", message = "Expiry date must be in MM/YY format")
    private String expiryDate;
    
    @NotBlank(message = "CVV is required")
    @Pattern(regexp = "^\\d{3,4}$", message = "Invalid CVV")
    private String cvv;
    
    private String billingAddress;
}
