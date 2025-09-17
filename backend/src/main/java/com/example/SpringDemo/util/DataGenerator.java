package com.example.SpringDemo.util;

import com.example.SpringDemo.entity.DoctorSlot;
import com.example.SpringDemo.entity.DoctorSlotTemplate;
import com.example.SpringDemo.repository.DoctorSlotRepository;
import com.example.SpringDemo.repository.DoctorSlotTemplateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Component
public class DataGenerator {

    @Autowired
    private DoctorSlotRepository doctorSlotRepository;

    @Autowired
    private DoctorSlotTemplateRepository doctorSlotTemplateRepository;

    public void generateComprehensiveData() {
        System.out.println("Starting comprehensive data generation...");
        
        // Generate slots for all doctors (1-12) for the next 2 weeks
        LocalDate startDate = LocalDate.now();
        LocalDate endDate = startDate.plusWeeks(2);
        
        for (long doctorId = 1; doctorId <= 12; doctorId++) {
            try {
                generateSlotsForDoctor(doctorId, startDate, endDate);
                System.out.println("Generated slots for doctor " + doctorId);
            } catch (Exception e) {
                System.err.println("Error generating slots for doctor " + doctorId + ": " + e.getMessage());
            }
        }
        
        System.out.println("Data generation completed!");
    }

    private void generateSlotsForDoctor(Long doctorId, LocalDate startDate, LocalDate endDate) {
        // Get all active templates for this doctor
        List<DoctorSlotTemplate> templates = doctorSlotTemplateRepository.findByDoctorDoctorIdAndIsActiveTrue(doctorId);
        
        if (templates.isEmpty()) {
            System.out.println("No templates found for doctor " + doctorId);
            return;
        }

        List<DoctorSlot> slotsToCreate = new ArrayList<>();
        
        LocalDate currentDate = startDate;
        while (!currentDate.isAfter(endDate)) {
            DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
            
            // Find templates for this day of week
            List<DoctorSlotTemplate> dayTemplates = templates.stream()
                .filter(template -> template.getDayOfWeek().equals(dayOfWeek))
                .toList();
            
            for (DoctorSlotTemplate template : dayTemplates) {
                List<DoctorSlot> daySlots = generateSlotsForTemplate(template, currentDate);
                slotsToCreate.addAll(daySlots);
            }
            
            currentDate = currentDate.plusDays(1);
        }
        
        // Save all generated slots in batches
        if (!slotsToCreate.isEmpty()) {
            doctorSlotRepository.saveAll(slotsToCreate);
            System.out.println("Created " + slotsToCreate.size() + " slots for doctor " + doctorId);
        }
    }

    private List<DoctorSlot> generateSlotsForTemplate(DoctorSlotTemplate template, LocalDate slotDate) {
        List<DoctorSlot> slots = new ArrayList<>();
        
        LocalTime currentTime = template.getStartTime();
        LocalTime endTime = template.getEndTime();
        int slotDuration = template.getSlotDurationMinutes();
        
        while (currentTime.plusMinutes(slotDuration).isBefore(endTime) || 
               currentTime.plusMinutes(slotDuration).equals(endTime)) {
            
            // Check if slot already exists
            boolean slotExists = doctorSlotRepository.existsByDoctorDoctorIdAndSlotDateAndStartTimeAndStatus(
                template.getDoctor().getDoctorId(), 
                slotDate, 
                currentTime, 
                DoctorSlot.SlotStatus.AVAILABLE
            );
            
            if (!slotExists) {
                DoctorSlot slot = new DoctorSlot();
                slot.setDoctor(template.getDoctor());
                slot.setSlotDate(slotDate);
                slot.setStartTime(currentTime);
                slot.setEndTime(currentTime.plusMinutes(slotDuration));
                slot.setStatus(DoctorSlot.SlotStatus.AVAILABLE);
                slot.setCreatedBy(1L); // System user
                
                slots.add(slot);
            }
            
            currentTime = currentTime.plusMinutes(slotDuration);
        }
        
        return slots;
    }
}
