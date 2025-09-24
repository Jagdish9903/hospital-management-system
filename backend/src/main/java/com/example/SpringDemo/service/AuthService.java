package com.example.SpringDemo.service;

import com.example.SpringDemo.config.JwtConfig;
import com.example.SpringDemo.dto.LoginRequest;
import com.example.SpringDemo.dto.LoginResponse;
import com.example.SpringDemo.dto.PatientRegistrationRequest;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.entity.Doctor;
import com.example.SpringDemo.repository.UserRepository;
import com.example.SpringDemo.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AuthService {
    
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtConfig jwtConfig;
    
    public LoginResponse authenticateUser(LoginRequest loginRequest) {
        System.out.println("=== AUTH SERVICE DEBUG ===");
        System.out.println("Login Request Email: " + loginRequest.getEmail());
        System.out.println("Login Request Password: " + loginRequest.getPassword());
        
        String email = loginRequest.getEmail();
        String password = loginRequest.getPassword();
        
        // Check if it's a doctor email (ends with @doctor.com)
        if (email.endsWith("@doctor.com")) {
            System.out.println("Doctor login detected");
            return authenticateDoctor(email, password);
        } else {
            System.out.println("User login detected");
            return authenticateUser(email, password);
        }
    }
    
        private LoginResponse authenticateDoctor(String email, String password) {
            // Find doctor by email
            Doctor doctor = doctorRepository.findByEmail(email).orElse(null);

            if (doctor == null) {
                System.out.println("Doctor not found in database for email: " + email);
                throw new RuntimeException("Invalid credentials");
            }

            System.out.println("Found doctor in database:");
            System.out.println("Doctor ID: " + doctor.getDoctorId());
            System.out.println("Doctor Email: " + doctor.getEmail());
            System.out.println("Doctor Name: " + doctor.getFullName());
            System.out.println("Doctor Active: " + doctor.getActive());

            // Check if doctor is active
            if (!doctor.getActive()) {
                System.out.println("Doctor account is inactive");
                throw new RuntimeException("Account is inactive");
            }

            // Verify password using BCrypt
            if (!passwordEncoder.matches(password, doctor.getPasswordHash())) {
                System.out.println("Invalid doctor password");
                throw new RuntimeException("Invalid credentials");
            }

            System.out.println("Doctor password verified successfully");

            // For doctors, we'll generate JWT directly without using authenticationManager
            // since doctors are not loaded by UserDetailsService
            String jwt = jwtConfig.generateTokenForDoctor(doctor);

            return new LoginResponse(jwt, "Bearer", doctor.getDoctorId(),
                                   doctor.getEmail().split("@")[0], // Use email prefix as username
                                   doctor.getEmail(), "DOCTOR", doctor.getFullName());
        }
    
    private LoginResponse authenticateUser(String email, String password) {
        System.out.println("=== AUTHENTICATING REGULAR USER ===");
        
        // Get user from database to check stored password
        User user = userRepository.findByEmail(email).orElse(null);
        if (user == null) {
            System.out.println("User not found in database for email: " + email);
            throw new RuntimeException("Invalid credentials");
        }
        
        System.out.println("Found user in database:");
        System.out.println("User ID: " + user.getId());
        System.out.println("User Email: " + user.getEmail());
        System.out.println("User Role: " + user.getRole());
        System.out.println("User Active: " + user.getActive());
        
        // Check if user is active
        if (!user.getActive()) {
            System.out.println("User account is inactive");
            throw new RuntimeException("Account is inactive");
        }
        
        // Verify password using BCrypt
        if (!passwordEncoder.matches(password, user.getPasswordHash())) {
            System.out.println("Invalid user password");
            throw new RuntimeException("Invalid credentials");
        }
        
        System.out.println("User password verified successfully");
        
        // Generate JWT token directly for users (similar to doctors)
        String jwt = jwtConfig.generateTokenForUser(user);
        
        // Update last login
        user.setLastLoginAt(LocalDateTime.now());
        userRepository.save(user);
        
        return new LoginResponse(jwt, "Bearer", user.getId(), user.getUsername(), 
                               user.getEmail(), user.getRole().name(), user.getName());
    }
    
    public User registerPatient(PatientRegistrationRequest request) {
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new RuntimeException("Username is already taken!");
        }
        
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email is already in use!");
        }
        
        if (userRepository.existsByContact(request.getContact())) {
            throw new RuntimeException("Mobile number is already registered!");
        }
        
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new RuntimeException("Passwords do not match!");
        }
        
        User user = new User();
        user.setName(request.getName());
        user.setFirstname(request.getFirstname());
        user.setLastname(request.getLastname());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setContact(request.getContact());
        user.setCountryCode(request.getCountryCode());
        user.setAddress(request.getAddress());
        user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        user.setRole(User.Role.PATIENT);
        user.setState(request.getState());
        user.setCity(request.getCity());
        user.setCountry(request.getCountry());
        user.setPostalCode(request.getPostalCode());
        user.setBloodGroup(request.getBloodGroup());
        user.setEmergencyContactName(request.getEmergencyContactName());
        user.setEmergencyContactNum(request.getEmergencyContactNum());
        
        return userRepository.save(user);
    }
}
