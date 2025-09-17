package com.example.SpringDemo.controller;

import com.example.SpringDemo.dto.ApiResponse;
import com.example.SpringDemo.util.DataGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/data")
@CrossOrigin(origins = "*")
public class DataGenerationController {

    @Autowired
    private DataGenerator dataGenerator;

    @PostMapping("/generate-slots")
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPERADMIN')")
    public ResponseEntity<ApiResponse<String>> generateSlots() {
        try {
            dataGenerator.generateComprehensiveData();
            return ResponseEntity.ok(ApiResponse.success("Comprehensive data generated successfully"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error("Error generating data: " + e.getMessage()));
        }
    }
}
