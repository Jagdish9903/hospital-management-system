package com.example.SpringDemo.service;

import com.example.SpringDemo.config.JwtConfig;
import com.example.SpringDemo.dto.LoginRequest;
import com.example.SpringDemo.dto.LoginResponse;
import com.example.SpringDemo.dto.PatientRegistrationRequest;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class AuthService {
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtConfig jwtConfig;
    
    public LoginResponse authenticateUser(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
        );
        
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtConfig.generateToken((org.springframework.security.core.userdetails.UserDetails) authentication.getPrincipal());
        
        User user = userRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));
        
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
