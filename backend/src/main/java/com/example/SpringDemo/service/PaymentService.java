package com.example.SpringDemo.service;

import com.example.SpringDemo.dto.PaymentRequest;
import com.example.SpringDemo.entity.Appointment;
import com.example.SpringDemo.entity.Payment;
import com.example.SpringDemo.entity.User;
import com.example.SpringDemo.repository.AppointmentRepository;
import com.example.SpringDemo.repository.PaymentRepository;
import com.example.SpringDemo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class PaymentService {
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private AppointmentRepository appointmentRepository;
    
    public Payment createPayment(PaymentRequest request) {
        User patient = userRepository.findById(request.getPatientId())
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        
        Appointment appointment = appointmentRepository.findById(request.getAppointmentId())
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        
        Payment payment = new Payment();
        payment.setPaymentId(UUID.randomUUID().toString());
        payment.setAppointment(appointment);
        payment.setPatient(patient);
        payment.setAmount(request.getAmount());
        payment.setMethod(Payment.Method.valueOf(request.getMethod().toUpperCase()));
        payment.setStatus(request.getStatus() != null ? Payment.Status.valueOf(request.getStatus().toUpperCase()) : Payment.Status.PENDING);
        payment.setTransactionId(request.getTransactionId());
        payment.setPaymentDate(LocalDateTime.now());
        payment.setCreatedAt(LocalDateTime.now());
        payment.setCreatedBy(patient.getId());
        
        return paymentRepository.save(payment);
    }
    
    public Page<Payment> getAllPayments(String status, String method, Long patientId, 
                                       Long appointmentId, Pageable pageable) {
        return paymentRepository.findPaymentsWithFilters(status, method, patientId, appointmentId, pageable);
    }
    
    public Page<Payment> getPaymentsByPatient(Long patientId, Pageable pageable) {
        return paymentRepository.findByPatientIdAndDeletedAtIsNull(patientId, pageable);
    }
    
    public List<Payment> getPaymentsByAppointment(Long appointmentId) {
        return paymentRepository.findByAppointmentIdAndDeletedAtIsNull(appointmentId);
    }
    
    public Page<Payment> searchPayments(String paymentId, String transactionId, String status, 
                                      String method, Long patientId, Long appointmentId, 
                                      BigDecimal minAmount, BigDecimal maxAmount, Pageable pageable) {
        return paymentRepository.searchPayments(paymentId, transactionId, status, method, 
                                              patientId, appointmentId, minAmount, maxAmount, pageable);
    }
    
    public Optional<Payment> getPaymentById(Long id) {
        return paymentRepository.findByIdAndDeletedAtIsNull(id);
    }
    
    public Optional<Payment> getPaymentByPaymentId(String paymentId) {
        return paymentRepository.findByPaymentIdAndDeletedAtIsNull(paymentId);
    }
    
    public Payment updatePayment(Long id, PaymentRequest request) {
        Payment payment = paymentRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        
        if (request.getAmount() != null) payment.setAmount(request.getAmount());
        if (request.getMethod() != null) payment.setMethod(Payment.Method.valueOf(request.getMethod().toUpperCase()));
        if (request.getStatus() != null) payment.setStatus(Payment.Status.valueOf(request.getStatus().toUpperCase()));
        if (request.getTransactionId() != null) payment.setTransactionId(request.getTransactionId());
        
        payment.setUpdatedAt(LocalDateTime.now());
        payment.setUpdatedBy(payment.getPatient().getId());
        
        return paymentRepository.save(payment);
    }
    
    public Payment updatePaymentStatus(Long id, String status, String transactionId) {
        Payment payment = paymentRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        
        payment.setStatus(Payment.Status.valueOf(status.toUpperCase()));
        if (transactionId != null) {
            payment.setTransactionId(transactionId);
        }
        payment.setUpdatedAt(LocalDateTime.now());
        
        return paymentRepository.save(payment);
    }
    
    public void deletePayment(Long id) {
        Payment payment = paymentRepository.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
        
        payment.setDeletedAt(LocalDateTime.now());
        payment.setDeletedBy(payment.getPatient().getId());
        paymentRepository.save(payment);
    }
    
    public Object getPaymentStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalPayments", paymentRepository.countByDeletedAtIsNull());
        stats.put("successfulPayments", paymentRepository.countByStatusAndDeletedAtIsNull("SUCCESS"));
        stats.put("pendingPayments", paymentRepository.countByStatusAndDeletedAtIsNull("PENDING"));
        stats.put("failedPayments", paymentRepository.countByStatusAndDeletedAtIsNull("FAILED"));
        
        return stats;
    }
    
    public Object getRevenueStats(String period) {
        Map<String, Object> stats = new HashMap<>();
        
        // Calculate total revenue
        BigDecimal totalRevenue = paymentRepository.calculateTotalRevenue();
        stats.put("totalRevenue", totalRevenue);
        
        // Calculate revenue by method
        Map<String, BigDecimal> revenueByMethod = paymentRepository.calculateRevenueByMethod();
        stats.put("revenueByMethod", revenueByMethod);
        
        // Calculate daily revenue for the last 30 days
        if ("daily".equals(period)) {
            Map<String, BigDecimal> dailyRevenue = paymentRepository.calculateDailyRevenue();
            stats.put("dailyRevenue", dailyRevenue);
        }
        
        return stats;
    }
}
