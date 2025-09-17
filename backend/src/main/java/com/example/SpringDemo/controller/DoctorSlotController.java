package com.example.SpringDemo.controller;

import com.example.SpringDemo.dto.ApiResponse;
import com.example.SpringDemo.entity.DoctorSlot;
import com.example.SpringDemo.service.DoctorSlotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/doctor-slots")
@CrossOrigin(origins = "*")
public class DoctorSlotController {
    
    @Autowired
    private DoctorSlotService doctorSlotService;
    
    @PostMapping("/generate/{doctorId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<String>> generateSlotsForDoctor(
            @PathVariable Long doctorId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        try {
            doctorSlotService.generateSlotsForDoctor(doctorId, startDate, endDate);
            return ResponseEntity.ok(ApiResponse.success("Slots generated successfully for doctor", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @GetMapping
    public ResponseEntity<ApiResponse<Page<DoctorSlot>>> getAllSlots(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "slotDate") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir,
            @RequestParam(required = false) Long doctorId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate slotDate) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Page<DoctorSlot> slots = doctorSlotService.getAllSlots(doctorId, status, slotDate, pageable);
        return ResponseEntity.ok(ApiResponse.success(slots));
    }
    
    @GetMapping("/doctor/{doctorId}")
    public ResponseEntity<ApiResponse<Page<DoctorSlot>>> getSlotsByDoctor(
            @PathVariable Long doctorId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "slotDate") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate slotDate) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Page<DoctorSlot> slots = doctorSlotService.getSlotsByDoctor(doctorId, status, slotDate, pageable);
        return ResponseEntity.ok(ApiResponse.success(slots));
    }
    
    @GetMapping("/available")
    public ResponseEntity<ApiResponse<List<DoctorSlot>>> getAvailableSlots(
            @RequestParam Long doctorId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate slotDate) {
        try {
            List<DoctorSlot> slots = doctorSlotService.getAvailableSlots(doctorId, slotDate);
            return ResponseEntity.ok(ApiResponse.success(slots));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @GetMapping("/search")
    public ResponseEntity<ApiResponse<Page<DoctorSlot>>> searchSlots(
            @RequestParam(required = false) Long doctorId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) String startTime,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) String endTime,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "slotDate") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Page<DoctorSlot> slots = doctorSlotService.searchSlots(doctorId, status, fromDate, toDate, 
                                                              startTime, endTime, pageable);
        return ResponseEntity.ok(ApiResponse.success(slots));
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<DoctorSlot>> getSlotById(@PathVariable Long id) {
        Optional<DoctorSlot> slot = doctorSlotService.getSlotById(id);
        if (slot.isPresent()) {
            return ResponseEntity.ok(ApiResponse.success(slot.get()));
        } else {
            return ResponseEntity.badRequest().body(ApiResponse.error("Slot not found"));
        }
    }
    
    @PutMapping("/{id}/book")
    public ResponseEntity<ApiResponse<DoctorSlot>> bookSlot(@PathVariable Long id) {
        try {
            DoctorSlot slot = doctorSlotService.bookSlot(id);
            return ResponseEntity.ok(ApiResponse.success("Slot booked successfully", slot));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @PutMapping("/{id}/unbook")
    public ResponseEntity<ApiResponse<DoctorSlot>> unbookSlot(@PathVariable Long id) {
        try {
            DoctorSlot slot = doctorSlotService.unbookSlot(id);
            return ResponseEntity.ok(ApiResponse.success("Slot unbooked successfully", slot));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @PutMapping("/{id}/block")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<DoctorSlot>> blockSlot(@PathVariable Long id) {
        try {
            DoctorSlot slot = doctorSlotService.blockSlot(id);
            return ResponseEntity.ok(ApiResponse.success("Slot blocked successfully", slot));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @PutMapping("/{id}/unblock")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<DoctorSlot>> unblockSlot(@PathVariable Long id) {
        try {
            DoctorSlot slot = doctorSlotService.unblockSlot(id);
            return ResponseEntity.ok(ApiResponse.success("Slot unblocked successfully", slot));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> deleteSlot(@PathVariable Long id) {
        try {
            doctorSlotService.deleteSlot(id);
            return ResponseEntity.ok(ApiResponse.success("Slot deleted successfully", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
    
    @GetMapping("/stats")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Object>> getSlotStats() {
        try {
            Object stats = doctorSlotService.getSlotStats();
            return ResponseEntity.ok(ApiResponse.success(stats));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }
}
