package com.example.SpringDemo.service;

import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    public Page<User> getAllUsers(String name, String email, String role, String gender, Pageable pageable) {
        User.Role roleEnum = null;
        if (role != null && !role.isEmpty()) {
            try {
                roleEnum = User.Role.valueOf(role.toUpperCase());
            } catch (IllegalArgumentException e) {
                // Invalid role, will be ignored
            }
        }
        
        User.Gender genderEnum = null;
        if (gender != null && !gender.isEmpty()) {
            try {
                genderEnum = User.Gender.valueOf(gender.toUpperCase());
            } catch (IllegalArgumentException e) {
                // Invalid gender, will be ignored
            }
        }
        
        return userRepository.findUsersWithFilters(name, email, roleEnum, genderEnum, pageable);
    }
    
    public Page<User> getUsersByRole(User.Role role, Pageable pageable) {
        return userRepository.findByRole(role, pageable);
    }
    
    public Page<User> searchUsers(String name, String email, String username, String contact, 
                                 String role, String gender, String city, String state, Pageable pageable) {
        User.Role roleEnum = null;
        if (role != null && !role.isEmpty()) {
            try {
                roleEnum = User.Role.valueOf(role.toUpperCase());
            } catch (IllegalArgumentException e) {
                // Invalid role, will be ignored
            }
        }
        
        User.Gender genderEnum = null;
        if (gender != null && !gender.isEmpty()) {
            try {
                genderEnum = User.Gender.valueOf(gender.toUpperCase());
            } catch (IllegalArgumentException e) {
                // Invalid gender, will be ignored
            }
        }
        
        return userRepository.searchUsers(name, email, username, contact, roleEnum, 
                                         genderEnum, city, state, pageable);
    }
    
    public Optional<User> getUserById(Long id) {
        return userRepository.findByIdAndDeletedAtIsNull(id);
    }
    
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsernameAndDeletedAtIsNull(username);
    }
    
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public User updateUser(Long id, User userDetails) {
        User user = userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        if (userDetails.getName() != null) user.setName(userDetails.getName());
        if (userDetails.getFirstname() != null) user.setFirstname(userDetails.getFirstname());
        if (userDetails.getLastname() != null) user.setLastname(userDetails.getLastname());
        if (userDetails.getEmail() != null) user.setEmail(userDetails.getEmail());
        if (userDetails.getContact() != null) user.setContact(userDetails.getContact());
        if (userDetails.getCountryCode() != null) user.setCountryCode(userDetails.getCountryCode());
        if (userDetails.getAddress() != null) user.setAddress(userDetails.getAddress());
        if (userDetails.getCity() != null) user.setCity(userDetails.getCity());
        if (userDetails.getState() != null) user.setState(userDetails.getState());
        if (userDetails.getCountry() != null) user.setCountry(userDetails.getCountry());
        if (userDetails.getPostalCode() != null) user.setPostalCode(userDetails.getPostalCode());
        if (userDetails.getGender() != null) user.setGender(userDetails.getGender());
        if (userDetails.getBloodGroup() != null) user.setBloodGroup(userDetails.getBloodGroup());
        if (userDetails.getEmergencyContactName() != null) user.setEmergencyContactName(userDetails.getEmergencyContactName());
        if (userDetails.getEmergencyContactNum() != null) user.setEmergencyContactNum(userDetails.getEmergencyContactNum());
        if (userDetails.getProfileUrl() != null) user.setProfileUrl(userDetails.getProfileUrl());
        
        user.setUpdatedAt(LocalDateTime.now());
        user.setUpdatedBy(user.getId());
        
        return userRepository.save(user);
    }
    
    public User updateUser(Long id, Map<String, Object> userDetails) {
        User user = userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        // Update fields from Map
        if (userDetails.containsKey("name")) user.setName((String) userDetails.get("name"));
        if (userDetails.containsKey("firstname")) user.setFirstname((String) userDetails.get("firstname"));
        if (userDetails.containsKey("lastname")) user.setLastname((String) userDetails.get("lastname"));
        if (userDetails.containsKey("birthdate")) {
            Object birthdateObj = userDetails.get("birthdate");
            if (birthdateObj instanceof LocalDate) {
                user.setBirthdate((LocalDate) birthdateObj);
            } else if (birthdateObj instanceof String) {
                try {
                    LocalDate birthdate = LocalDate.parse((String) birthdateObj);
                    user.setBirthdate(birthdate);
                } catch (Exception e) {
                    System.out.println("Invalid birthdate format: " + birthdateObj);
                }
            }
        }
        if (userDetails.containsKey("contact")) user.setContact((String) userDetails.get("contact"));
        if (userDetails.containsKey("countryCode")) user.setCountryCode((String) userDetails.get("countryCode"));
        if (userDetails.containsKey("gender")) {
            Object genderObj = userDetails.get("gender");
            if (genderObj instanceof String) {
                try {
                    User.Gender gender = User.Gender.valueOf(((String) genderObj).toUpperCase());
                    user.setGender(gender);
                } catch (IllegalArgumentException e) {
                    System.out.println("Invalid gender value: " + genderObj);
                }
            } else if (genderObj instanceof User.Gender) {
                user.setGender((User.Gender) genderObj);
            }
        }
        if (userDetails.containsKey("address")) user.setAddress((String) userDetails.get("address"));
        if (userDetails.containsKey("city")) user.setCity((String) userDetails.get("city"));
        if (userDetails.containsKey("state")) user.setState((String) userDetails.get("state"));
        if (userDetails.containsKey("country")) user.setCountry((String) userDetails.get("country"));
        if (userDetails.containsKey("postalCode")) user.setPostalCode((String) userDetails.get("postalCode"));
        if (userDetails.containsKey("bloodGroup")) user.setBloodGroup((String) userDetails.get("bloodGroup"));
        if (userDetails.containsKey("emergencyContactName")) user.setEmergencyContactName((String) userDetails.get("emergencyContactName"));
        if (userDetails.containsKey("emergencyContactNum")) user.setEmergencyContactNum((String) userDetails.get("emergencyContactNum"));
        if (userDetails.containsKey("profileUrl")) user.setProfileUrl((String) userDetails.get("profileUrl"));
        
        user.setUpdatedAt(LocalDateTime.now());
        user.setUpdatedBy(user.getId());
        
        return userRepository.save(user);
    }
    
    public User updateUserStatus(Long id, String status) {
        User user = userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        // Assuming we have a status field in User entity
        // If not, we can use a different approach like setting deletedAt for deactivation
        if ("ACTIVE".equals(status)) {
            user.setDeletedAt(null);
        } else if ("INACTIVE".equals(status)) {
            user.setDeletedAt(LocalDateTime.now());
        }
        
        user.setUpdatedAt(LocalDateTime.now());
        user.setUpdatedBy(user.getId());
        
        return userRepository.save(user);
    }
    
    public User updateUserRole(Long id, String role) {
        User user = userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        try {
            User.Role roleEnum = User.Role.valueOf(role.toUpperCase());
            user.setRole(roleEnum);
            user.setUpdatedAt(LocalDateTime.now());
            user.setUpdatedBy(user.getId());
            
            return userRepository.save(user);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid role: " + role);
        }
    }
    
    public void deleteUser(Long id) {
        User user = userRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        user.setDeletedAt(LocalDateTime.now());
        user.setDeletedBy(user.getId());
        userRepository.save(user);
    }
    
    public Object getUserStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalUsers", userRepository.countByDeletedAtIsNull());
        stats.put("totalPatients", userRepository.countByRoleAndDeletedAtIsNull(User.Role.PATIENT));
        stats.put("totalAdmins", userRepository.countByRoleAndDeletedAtIsNull(User.Role.ADMIN));
        stats.put("totalSuperAdmins", userRepository.countByRoleAndDeletedAtIsNull(User.Role.SUPERADMIN));
        stats.put("activeUsers", userRepository.countByDeletedAtIsNull());
        
        return stats;
    }
    
    public List<User> getPatients() {
        return userRepository.findByRole(User.Role.PATIENT);
    }

    public List<User> getAdmins() {
        return userRepository.findByRoleIn(List.of(User.Role.ADMIN, User.Role.SUPERADMIN));
    }
    
    public List<User> getActiveUsers() {
        return userRepository.findActiveUsersSince(LocalDateTime.now().minusDays(30));
    }
}
