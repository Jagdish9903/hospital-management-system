package com.example.SpringDemo.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class PatientRegistrationRequest {
    
    @NotBlank(message = "Name is required")
    @Size(min = 3, message = "Name must be at least 3 characters long")
    @Pattern(regexp = "^[a-zA-Z\\s]+$", message = "Name must contain only letters and spaces")
    private String name;
    
    @NotBlank(message = "First name is required")
    private String firstname;
    
    @NotBlank(message = "Last name is required")
    private String lastname;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email address")
    private String email;
    
    @NotBlank(message = "Mobile number is required")
    @Pattern(regexp = "^\\d{8,10}$", message = "Enter a valid mobile number")
    private String contact;
    
    @NotBlank(message = "Country code is required")
    private String countryCode;
    
    @NotBlank(message = "Address is required")
    @Size(min = 10, message = "Address must be at least 10 characters long")
    private String address;
    
    @NotBlank(message = "Username is required")
    @Size(min = 5, message = "Username must be at least 5 characters")
    @Pattern(regexp = "^[a-zA-Z0-9_]+$", message = "Username must contain only letters, numbers, and underscores")
    private String username;
    
    @NotBlank(message = "Password is required")
    @Size(min = 8, message = "Password must be at least 8 characters")
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$", 
             message = "Password must contain at least 1 uppercase, 1 lowercase, 1 digit, and 1 special character")
    private String password;
    
    @NotBlank(message = "Confirm password is required")
    private String confirmPassword;
    
    private String state;
    private String city;
    private String country;
    private String postalCode;
    private String bloodGroup;
    private String emergencyContactName;
    private String emergencyContactNum;
}
