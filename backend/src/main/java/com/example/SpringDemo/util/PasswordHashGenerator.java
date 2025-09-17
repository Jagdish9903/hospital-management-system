package com.example.SpringDemo.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashGenerator {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        String password = args.length > 0 ? args[0] : "password123";
        String hash = encoder.encode(password);
        
        System.out.println("Password: " + password);
        System.out.println("Hash: " + hash);
        
        // Test if the hash matches
        boolean matches = encoder.matches(password, hash);
        System.out.println("Matches: " + matches);
        
        // Test the existing hash from database
        String dbHash = "$2a$10$y./11hZtBLzprDaWjebW/ezLPhfTzETs.MXpW73e3F05.4Q8ZhrEW";
        boolean dbMatches = encoder.matches(password, dbHash);
        System.out.println("Database hash matches: " + dbMatches);
    }
}