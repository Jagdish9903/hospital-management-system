package com.example.SpringDemo.controller;

import com.example.SpringDemo.util.JwtTokenGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
public class TestController {
    
    @Autowired
    private JwtTokenGenerator jwtTokenGenerator;
    
    @GetMapping("/token")
    public String getTestToken() {
        return jwtTokenGenerator.generateTokenForSuperAdmin();
    }
}
