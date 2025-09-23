# Configuration Files - Line by Line Analysis

## Overview
This document provides detailed line-by-line analysis of all configuration files in the Hospital Management System backend. These files handle security, CORS, JPA, JWT authentication, and API documentation.

---

## 1. CorsConfig.java

### File: `backend/src/main/java/com/example/SpringDemo/config/CorsConfig.java`

### Package and Imports (Lines 1-12)

```java
package com.example.SpringDemo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Arrays;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Lines 3-4**: Spring configuration annotations
- **Lines 5-7**: Spring CORS-related classes for cross-origin request handling
- **Lines 8-9**: Spring Web MVC configuration classes
- **Line 11**: Java utility for array operations

### Class Declaration (Lines 13-14)

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {
```

**Explanation:**
- **Line 13**: `@Configuration` marks this as a Spring configuration class
- **Line 14**: Implements `WebMvcConfigurer` for web configuration customization

### CORS Mapping Configuration (Lines 16-24)

```java
@Override
public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**")
            .allowedOriginPatterns("*")
            .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
            .allowedHeaders("*")
            .allowCredentials(false) // Set to false to allow wildcard origins
            .maxAge(3600);
}
```

**Explanation:**
- **Line 16**: Override method from `WebMvcConfigurer` interface
- **Line 17**: `addMapping("/**")` applies CORS to all endpoints
- **Line 18**: `allowedOriginPatterns("*")` allows requests from any origin
- **Line 19**: `allowedMethods()` specifies allowed HTTP methods
- **Line 20**: `allowedHeaders("*")` allows all request headers
- **Line 21**: `allowCredentials(false)` disables credential sharing (required for wildcard origins)
- **Line 22**: `maxAge(3600)` sets preflight cache duration to 1 hour

### CORS Configuration Bean (Lines 26-38)

```java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    configuration.setAllowedOriginPatterns(Arrays.asList("*"));
    configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"));
    configuration.setAllowedHeaders(Arrays.asList("*"));
    configuration.setAllowCredentials(false); // Set to false to allow wildcard origins
    configuration.setMaxAge(3600L);
    
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);
    return source;
}
```

**Explanation:**
- **Line 26**: `@Bean` creates a Spring-managed bean
- **Line 27**: Method returns `CorsConfigurationSource` for programmatic CORS configuration
- **Line 28**: Create new `CorsConfiguration` object
- **Lines 29-32**: Configure CORS settings (same as above)
- **Line 33**: Set max age as Long value
- **Lines 35-37**: Create and register CORS configuration for all paths
- **Line 38**: Return the configuration source

---

## 2. JpaConfig.java

### File: `backend/src/main/java/com/example/SpringDemo/config/JpaConfig.java`

### Package and Imports (Lines 1-5)

```java
package com.example.SpringDemo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Line 3**: Spring configuration annotation
- **Line 4**: Spring Data JPA auditing annotation

### Class Declaration (Lines 6-8)

```java
@Configuration
@EnableJpaAuditing
public class JpaConfig {
}
```

**Explanation:**
- **Line 6**: `@Configuration` marks this as a Spring configuration class
- **Line 7**: `@EnableJpaAuditing` enables automatic auditing for JPA entities
- **Line 8**: Empty class body (configuration is complete with annotations)

**Purpose**: This configuration enables automatic timestamp management for JPA entities with `@CreatedDate` and `@LastModifiedDate` annotations.

---

## 3. JwtAuthenticationEntryPoint.java

### File: `backend/src/main/java/com/example/SpringDemo/config/JwtAuthenticationEntryPoint.java`

### Package and Imports (Lines 1-11)

```java
package com.example.SpringDemo.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Lines 3-4**: Jakarta Servlet API imports for HTTP request/response handling
- **Line 5**: Spring Security authentication exception class
- **Line 6**: Spring Security authentication entry point interface
- **Line 7**: Spring component annotation
- **Line 9**: Java IO exception handling

### Class Declaration (Lines 12-13)

```java
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
```

**Explanation:**
- **Line 12**: `@Component` marks this as a Spring-managed component
- **Line 13**: Implements `AuthenticationEntryPoint` for handling authentication failures

### Authentication Entry Point Method (Lines 15-19)

```java
@Override
public void commence(HttpServletRequest request, HttpServletResponse response,
                     AuthenticationException authException) throws IOException, ServletException {
    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
}
```

**Explanation:**
- **Line 15**: Override method from `AuthenticationEntryPoint` interface
- **Lines 16-17**: Method signature with request, response, and exception parameters
- **Line 18**: Send HTTP 401 Unauthorized status with "Unauthorized" message
- **Purpose**: Handles cases where authentication is required but not provided

---

## 4. JwtConfig.java

### File: `backend/src/main/java/com/example/SpringDemo/config/JwtConfig.java`

### Package and Imports (Lines 1-16)

```java
package com.example.SpringDemo.config;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Lines 3-6**: JWT library imports for token creation and validation
- **Line 7**: Spring value injection annotation
- **Line 8**: Spring Security user details interface
- **Line 9**: Spring component annotation
- **Lines 11-15**: Java imports for cryptography, dates, and collections

### Class Declaration (Lines 17-18)

```java
@Component
public class JwtConfig {
```

**Explanation:**
- **Line 17**: `@Component` marks this as a Spring-managed component
- **Line 18**: Class declaration for JWT configuration and utility methods

### Configuration Properties (Lines 20-24)

```java
@Value("${jwt.secret}")
private String secret;

@Value("${jwt.expiration}")
private Long expiration;
```

**Explanation:**
- **Lines 20-21**: Inject JWT secret key from application properties
- **Lines 23-24**: Inject JWT expiration time from application properties
- **Purpose**: Externalize JWT configuration for security and flexibility

### Signing Key Method (Lines 26-28)

```java
private SecretKey getSigningKey() {
    return Keys.hmacShaKeyFor(secret.getBytes());
}
```

**Explanation:**
- **Line 26**: Private method to get the signing key
- **Line 27**: Convert secret string to HMAC-SHA key for JWT signing
- **Purpose**: Creates the cryptographic key used to sign and verify JWT tokens

### Extract Username Method (Lines 30-32)

```java
public String extractUsername(String token) {
    return extractClaim(token, Claims::getSubject);
}
```

**Explanation:**
- **Line 30**: Public method to extract username from JWT token
- **Line 31**: Use generic claim extractor to get the subject (username)
- **Purpose**: Retrieves the username from a JWT token

### Extract Expiration Method (Lines 34-36)

```java
public Date extractExpiration(String token) {
    return extractClaim(token, Claims::getExpiration);
}
```

**Explanation:**
- **Line 34**: Public method to extract expiration date from JWT token
- **Line 35**: Use generic claim extractor to get the expiration date
- **Purpose**: Retrieves the expiration time from a JWT token

### Generic Claim Extractor (Lines 38-41)

```java
public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
    final Claims claims = extractAllClaims(token);
    return claimsResolver.apply(claims);
}
```

**Explanation:**
- **Line 38**: Generic method to extract any claim from JWT token
- **Line 39**: Extract all claims from the token
- **Line 40**: Apply the provided function to extract specific claim
- **Purpose**: Reusable method for extracting different types of claims

### Extract All Claims Method (Lines 43-49)

```java
private Claims extractAllClaims(String token) {
    return Jwts.parserBuilder()
            .setSigningKey(getSigningKey())
            .build()
            .parseClaimsJws(token)
            .getBody();
}
```

**Explanation:**
- **Line 43**: Private method to extract all claims from JWT token
- **Lines 44-47**: Use JWT parser to parse and validate the token
- **Line 44**: Create parser builder
- **Line 45**: Set the signing key for validation
- **Line 46**: Build the parser
- **Line 47**: Parse the JWS (JSON Web Signature) and get claims body
- **Purpose**: Core method for parsing and validating JWT tokens

### Check Token Expiration (Lines 51-53)

```java
private Boolean isTokenExpired(String token) {
    return extractExpiration(token).before(new Date());
}
```

**Explanation:**
- **Line 51**: Private method to check if token is expired
- **Line 52**: Compare token expiration with current date
- **Purpose**: Determines if a JWT token has expired

### Generate Token Method (Lines 55-58)

```java
public String generateToken(UserDetails userDetails) {
    Map<String, Object> claims = new HashMap<>();
    return createToken(claims, userDetails.getUsername());
}
```

**Explanation:**
- **Line 55**: Public method to generate JWT token for user
- **Line 56**: Create empty claims map (can be extended for additional claims)
- **Line 57**: Create token with claims and username
- **Purpose**: Generates a JWT token for authenticated users

### Create Token Method (Lines 60-68)

```java
private String createToken(Map<String, Object> claims, String subject) {
    return Jwts.builder()
            .setClaims(claims)
            .setSubject(subject)
            .setIssuedAt(new Date(System.currentTimeMillis()))
            .setExpiration(new Date(System.currentTimeMillis() + expiration))
            .signWith(getSigningKey(), SignatureAlgorithm.HS256)
            .compact();
}
```

**Explanation:**
- **Line 60**: Private method to create JWT token
- **Lines 61-67**: Build JWT token with all required components
- **Line 62**: Set custom claims
- **Line 63**: Set subject (username)
- **Line 64**: Set issued at time (current time)
- **Line 65**: Set expiration time (current time + configured expiration)
- **Line 66**: Sign with HMAC-SHA256 algorithm
- **Line 67**: Compact the token to string format
- **Purpose**: Creates a complete JWT token with all standard claims

### Validate Token Method (Lines 70-73)

```java
public Boolean validateToken(String token, UserDetails userDetails) {
    final String username = extractUsername(token);
    return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
}
```

**Explanation:**
- **Line 70**: Public method to validate JWT token
- **Line 71**: Extract username from token
- **Line 72**: Check if username matches and token is not expired
- **Purpose**: Validates JWT token against user details

---

## 5. JwtRequestFilter.java

### File: `backend/src/main/java/com/example/SpringDemo/config/JwtRequestFilter.java`

### Package and Imports (Lines 1-17)

```java
package com.example.SpringDemo.config;

import com.example.SpringDemo.service.UserDetailsServiceImpl;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Line 3**: Import custom user details service
- **Lines 4-6**: Jakarta Servlet API imports for filter processing
- **Lines 7-12**: Spring Security imports for authentication
- **Line 13**: Spring component annotation
- **Line 14**: Spring filter base class
- **Line 16**: Java IO exception handling

### Class Declaration and Dependencies (Lines 18-25)

```java
@Component
public class JwtRequestFilter extends OncePerRequestFilter {
    
    @Autowired
    private UserDetailsServiceImpl userDetailsService;
    
    @Autowired
    private JwtConfig jwtConfig;
```

**Explanation:**
- **Line 18**: `@Component` marks this as a Spring-managed component
- **Line 19**: Extends `OncePerRequestFilter` for request processing
- **Lines 21-22**: Inject custom user details service
- **Lines 24-25**: Inject JWT configuration utility

### Filter Processing Method (Lines 27-66)

```java
@Override
protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, 
                                FilterChain chain) throws ServletException, IOException {
    
    final String requestTokenHeader = request.getHeader("Authorization");
    final String requestURI = request.getRequestURI();
    
    System.out.println("=== JWT FILTER DEBUG ===");
    System.out.println("Request URI: " + requestURI);
    System.out.println("Authorization Header: " + requestTokenHeader);
    
    String username = null;
    String jwtToken = null;
    
    if (requestTokenHeader != null && requestTokenHeader.startsWith("Bearer ")) {
        jwtToken = requestTokenHeader.substring(7);
        try {
            username = jwtConfig.extractUsername(jwtToken);
            System.out.println("Extracted username: " + username);
        } catch (Exception e) {
            System.err.println("Unable to get JWT Token or JWT Token has expired: " + e.getMessage());
        }
    } else {
        System.out.println("No Authorization header or invalid format");
    }
    
    if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
        UserDetails userDetails = this.userDetailsService.loadUserByUsername(username);
        
        if (jwtConfig.validateToken(jwtToken, userDetails)) {
            UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = 
                new UsernamePasswordAuthenticationToken(
                    userDetails, null, userDetails.getAuthorities());
            usernamePasswordAuthenticationToken
                .setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
        }
    }
    chain.doFilter(request, response);
}
```

**Explanation:**
- **Lines 27-29**: Override filter method with request, response, and filter chain
- **Lines 31-32**: Extract Authorization header and request URI
- **Lines 34-36**: Debug logging for troubleshooting
- **Lines 38-39**: Initialize variables for username and token
- **Lines 41-50**: Extract JWT token from Authorization header
- **Line 41**: Check if header exists and starts with "Bearer "
- **Line 42**: Extract token by removing "Bearer " prefix
- **Lines 43-47**: Extract username from token with error handling
- **Lines 48-50**: Log when no valid Authorization header is found
- **Lines 52-65**: Authenticate user if token is valid
- **Line 52**: Check if username extracted and no existing authentication
- **Line 53**: Load user details from database
- **Line 55**: Validate token against user details
- **Lines 56-61**: Create authentication token and set in security context
- **Line 66**: Continue filter chain processing

---

## 6. OpenApiConfig.java

### File: `backend/src/main/java/com/example/SpringDemo/config/OpenApiConfig.java`

### Package and Imports (Lines 1-9)

```java
package com.example.SpringDemo.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Lines 3-6**: OpenAPI/Swagger imports for API documentation
- **Lines 7-8**: Spring configuration annotations

### Class Declaration (Lines 10-11)

```java
@Configuration
public class OpenApiConfig {
```

**Explanation:**
- **Line 10**: `@Configuration` marks this as a Spring configuration class
- **Line 11**: Class declaration for OpenAPI configuration

### OpenAPI Bean Configuration (Lines 13-26)

```java
@Bean
public OpenAPI customOpenAPI() {
    return new OpenAPI()
            .info(new Info()
                    .title("Hospital Management System API")
                    .description("A comprehensive REST API for managing hospital operations")
                    .version("1.0.0"))
            .addSecurityItem(new SecurityRequirement().addList("bearerAuth"))
            .components(new io.swagger.v3.oas.models.Components()
                    .addSecuritySchemes("bearerAuth", new SecurityScheme()
                            .type(SecurityScheme.Type.HTTP)
                            .scheme("bearer")
                            .bearerFormat("JWT")));
}
```

**Explanation:**
- **Line 13**: `@Bean` creates a Spring-managed OpenAPI configuration
- **Lines 14-18**: Configure API information
- **Line 15**: Set API title
- **Line 16**: Set API description
- **Line 17**: Set API version
- **Line 19**: Add security requirement for JWT authentication
- **Lines 20-25**: Configure JWT security scheme
- **Line 21**: Create components section
- **Line 22**: Add bearer authentication scheme
- **Line 23**: Set type to HTTP
- **Line 24**: Set scheme to bearer
- **Line 25**: Set bearer format to JWT
- **Purpose**: Configures Swagger UI with JWT authentication support

---

## 7. SecurityConfig.java

### File: `backend/src/main/java/com/example/SpringDemo/config/SecurityConfig.java`

### Package and Imports (Lines 1-19)

```java
package com.example.SpringDemo.config;

import com.example.SpringDemo.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfigurationSource;
```

**Explanation:**
- **Line 1**: Package declaration for configuration classes
- **Line 3**: Import custom user details service
- **Lines 4-6**: Spring configuration and dependency injection annotations
- **Lines 7-9**: Spring Security authentication imports
- **Lines 10-12**: Spring Security configuration imports
- **Lines 13-14**: Spring Security password encoding imports
- **Lines 15-16**: Spring Security filter chain imports
- **Line 17**: CORS configuration source import

### Class Declaration and Dependencies (Lines 20-35)

```java
@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
    
    @Autowired
    private UserDetailsServiceImpl userDetailsService;
    
    @Autowired
    private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    
    @Autowired
    private JwtRequestFilter jwtRequestFilter;
    
    @Autowired
    private CorsConfigurationSource corsConfigurationSource;
```

**Explanation:**
- **Line 20**: `@Configuration` marks this as a Spring configuration class
- **Line 21**: `@EnableWebSecurity` enables Spring Security
- **Line 22**: `@EnableMethodSecurity(prePostEnabled = true)` enables method-level security
- **Lines 25-35**: Inject all required security components

### Password Encoder Bean (Lines 37-40)

```java
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}
```

**Explanation:**
- **Line 37**: `@Bean` creates a Spring-managed password encoder
- **Line 38**: Method returns BCrypt password encoder
- **Line 39**: Create new BCryptPasswordEncoder instance
- **Purpose**: Provides secure password hashing for user authentication

### Authentication Provider Bean (Lines 42-48)

```java
@Bean
public DaoAuthenticationProvider authenticationProvider() {
    DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    authProvider.setUserDetailsService(userDetailsService);
    authProvider.setPasswordEncoder(passwordEncoder());
    return authProvider;
}
```

**Explanation:**
- **Line 42**: `@Bean` creates a Spring-managed authentication provider
- **Line 43**: Method returns DAO authentication provider
- **Line 44**: Create new DaoAuthenticationProvider instance
- **Line 45**: Set custom user details service
- **Line 46**: Set password encoder
- **Line 47**: Return configured provider
- **Purpose**: Configures authentication to use database and BCrypt

### Authentication Manager Bean (Lines 50-53)

```java
@Bean
public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
    return config.getAuthenticationManager();
}
```

**Explanation:**
- **Line 50**: `@Bean` creates a Spring-managed authentication manager
- **Line 51**: Method returns authentication manager from configuration
- **Line 52**: Get authentication manager from Spring Security configuration
- **Purpose**: Provides authentication manager for login functionality

### Security Filter Chain Configuration (Lines 55-87)

```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http.cors(cors -> cors.configurationSource(corsConfigurationSource))
        .csrf(csrf -> csrf.disable())
        .authorizeHttpRequests(authz -> authz
            .requestMatchers("/api/auth/**").permitAll()
            .requestMatchers("/h2-console/**").permitAll()
            .requestMatchers("/api/public/**").permitAll()
            .requestMatchers("/swagger-ui/**").permitAll()
            .requestMatchers("/v3/api-docs/**").permitAll()
            .requestMatchers("/swagger-ui.html").permitAll()
            .requestMatchers("/api/appointments/**").permitAll()
            .requestMatchers("/api/doctors").hasAnyRole("ADMIN", "SUPERADMIN")
            .requestMatchers("/api/doctors/**").permitAll()
            .requestMatchers("/api/payments/**").permitAll()
            .requestMatchers("/api/profile/test/**").permitAll()
            .requestMatchers("/api/simple-profile/**").permitAll()
            .requestMatchers("/api/simple-complaints/**").permitAll()
            .requestMatchers("/api/data-generation/**").permitAll()
            .requestMatchers("/api/enhanced-data-generation/**").permitAll()
            .requestMatchers("/api/profile/**").authenticated()
            .requestMatchers("/api/admin/**").hasAnyRole("ADMIN", "SUPERADMIN")
            .anyRequest().authenticated()
        )
        .exceptionHandling(ex -> ex.authenticationEntryPoint(jwtAuthenticationEntryPoint))
        .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .headers(headers -> headers.frameOptions().disable());
    
    http.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
    
    return http.build();
}
```

**Explanation:**
- **Line 55**: `@Bean` creates a Spring-managed security filter chain
- **Line 56**: Method returns configured security filter chain
- **Line 57**: Configure CORS using custom configuration source
- **Line 58**: Disable CSRF protection (not needed for stateless JWT)
- **Lines 59-78**: Configure URL-based authorization rules
- **Lines 60-66**: Permit all access to public endpoints (auth, h2-console, swagger, etc.)
- **Line 67**: Permit all access to appointments endpoints
- **Line 68**: Require ADMIN or SUPERADMIN role for doctors list
- **Lines 69-75**: Permit all access to various public endpoints
- **Line 76**: Require authentication for profile endpoints
- **Line 77**: Require ADMIN or SUPERADMIN role for admin endpoints
- **Line 78**: Require authentication for all other requests
- **Line 79**: Configure exception handling with JWT entry point
- **Line 80**: Set session creation policy to stateless (JWT-based)
- **Line 81**: Disable frame options for H2 console
- **Line 83**: Add JWT filter before username/password authentication filter
- **Line 85**: Return configured security filter chain

---

## Summary

The configuration files provide a comprehensive security and infrastructure setup for the Hospital Management System:

### Security Features:
1. **JWT Authentication**: Stateless token-based authentication
2. **Password Security**: BCrypt password hashing
3. **CORS Support**: Cross-origin request handling
4. **Role-based Access**: Different access levels for different user types
5. **Method Security**: Method-level security annotations

### Infrastructure Features:
1. **JPA Auditing**: Automatic timestamp management
2. **API Documentation**: Swagger UI with JWT support
3. **Database Console**: H2 console access for development
4. **Exception Handling**: Proper error responses for authentication failures

### Key Design Patterns:
1. **Configuration Classes**: Centralized configuration management
2. **Bean Definitions**: Spring-managed components
3. **Dependency Injection**: Loose coupling between components
4. **Filter Chains**: Request processing pipeline
5. **Security Context**: Thread-local security information

These configurations ensure the application is secure, maintainable, and follows Spring Boot best practices.
