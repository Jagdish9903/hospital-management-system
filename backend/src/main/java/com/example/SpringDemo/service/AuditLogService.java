package com.example.SpringDemo.service;

import com.example.SpringDemo.entity.AuditLog;
import com.example.SpringDemo.repository.AuditLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class AuditLogService {
    
    @Autowired
    private AuditLogRepository auditLogRepository;
    
    public Page<AuditLog> getAllAuditLogs(Long userId, String tableName, String action, 
                                         LocalDateTime fromDate, LocalDateTime toDate, Pageable pageable) {
        return auditLogRepository.findAuditLogsWithFilters(userId, tableName, action, 
                                                          fromDate, toDate, pageable);
    }
    
    public Page<AuditLog> getAuditLogsByUser(Long userId, Pageable pageable) {
        return auditLogRepository.findByUserIdAndDeletedAtIsNull(userId, pageable);
    }
    
    public Page<AuditLog> getAuditLogsByTable(String tableName, Pageable pageable) {
        return auditLogRepository.findByTableNameAndDeletedAtIsNull(tableName, pageable);
    }
    
    public Page<AuditLog> searchAuditLogs(Long userId, String tableName, String action, 
                                         Long recordId, String ipAddress, LocalDateTime fromDate, 
                                         LocalDateTime toDate, Pageable pageable) {
        return auditLogRepository.searchAuditLogs(userId, tableName, action, recordId, 
                                                 ipAddress, fromDate, toDate, pageable);
    }
    
    public Optional<AuditLog> getAuditLogById(Long id) {
        return auditLogRepository.findByIdAndDeletedAtIsNull(id);
    }
    
    public Object getAuditLogStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalAuditLogs", auditLogRepository.countByDeletedAtIsNull());
        stats.put("inserts", auditLogRepository.countByActionAndDeletedAtIsNull("INSERT"));
        stats.put("updates", auditLogRepository.countByActionAndDeletedAtIsNull("UPDATE"));
        stats.put("deletes", auditLogRepository.countByActionAndDeletedAtIsNull("DELETE"));
        stats.put("selects", auditLogRepository.countByActionAndDeletedAtIsNull("SELECT"));
        
        return stats;
    }
    
    public List<AuditLog> getRecentAuditLogs(int limit) {
        return auditLogRepository.findTop10ByDeletedAtIsNullOrderByCreatedAtDesc();
    }
    
    public Page<AuditLog> getAllAuditLogs(Pageable pageable) {
        return auditLogRepository.findAll(pageable);
    }
    
    public Page<AuditLog> getAllAuditLogs(String action, String tableName, Long userId, String fromDate, String toDate, Pageable pageable) {
        return auditLogRepository.findAuditLogsWithFilters(action, tableName, userId, fromDate, toDate, pageable);
    }
    
    public List<AuditLog> getRecentAuditLogs() {
        return auditLogRepository.findTop10ByDeletedAtIsNullOrderByCreatedAtDesc();
    }
}
