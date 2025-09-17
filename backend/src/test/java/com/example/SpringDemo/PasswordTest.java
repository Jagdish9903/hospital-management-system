package com.example.SpringDemo;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordTest {
    public static void main(String[] args) {
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // Test the hash from database
        String dbHash = "$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi";
        String password = "password123";
        
        System.out.println("Testing password: " + password);
        System.out.println("Database hash: " + dbHash);
        
        // Check if password matches the hash
        boolean matches = encoder.matches(password, dbHash);
        System.out.println("Password matches: " + matches);
        
        // Generate a new hash for password123
        String newHash = encoder.encode(password);
        System.out.println("New hash for password123: " + newHash);
        
        // Verify the new hash
        boolean newMatches = encoder.matches(password, newHash);
        System.out.println("New hash matches: " + newMatches);
    }
}
