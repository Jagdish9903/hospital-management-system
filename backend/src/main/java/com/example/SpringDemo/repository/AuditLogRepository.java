package com.example.SpringDemo.repository;

import com.example.SpringDemo.entity.AuditLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
    
    @Query("SELECT a FROM AuditLog a WHERE a.user.id = :userId")
    Page<AuditLog> findByUserIdAndDeletedAtIsNull(@Param("userId") Long userId, Pageable pageable);
    
    @Query("SELECT a FROM AuditLog a WHERE a.tableName = :tableName")
    Page<AuditLog> findByTableNameAndDeletedAtIsNull(@Param("tableName") String tableName, Pageable pageable);
    
    @Query("SELECT a FROM AuditLog a WHERE " +
           "(:userId IS NULL OR a.user.id = :userId) AND " +
           "(:tableName IS NULL OR a.tableName = :tableName) AND " +
           "(:action IS NULL OR a.action = :action) AND " +
           "(:fromDate IS NULL OR a.createdAt >= :fromDate) AND " +
           "(:toDate IS NULL OR a.createdAt <= :toDate)")
    Page<AuditLog> findAuditLogsWithFilters(@Param("userId") Long userId,
                                           @Param("tableName") String tableName,
                                           @Param("action") String action,
                                           @Param("fromDate") LocalDateTime fromDate,
                                           @Param("toDate") LocalDateTime toDate,
                                           Pageable pageable);
    
    @Query("SELECT a FROM AuditLog a WHERE " +
           "(:userId IS NULL OR a.user.id = :userId) AND " +
           "(:tableName IS NULL OR a.tableName = :tableName) AND " +
           "(:action IS NULL OR a.action = :action) AND " +
           "(:recordId IS NULL OR a.recordId = :recordId) AND " +
           "(:ipAddress IS NULL OR a.ipAddress = :ipAddress) AND " +
           "(:fromDate IS NULL OR a.createdAt >= :fromDate) AND " +
           "(:toDate IS NULL OR a.createdAt <= :toDate)")
    Page<AuditLog> searchAuditLogs(@Param("userId") Long userId,
                                   @Param("tableName") String tableName,
                                   @Param("action") String action,
                                   @Param("recordId") Long recordId,
                                   @Param("ipAddress") String ipAddress,
                                   @Param("fromDate") LocalDateTime fromDate,
                                   @Param("toDate") LocalDateTime toDate,
                                   Pageable pageable);
    
    @Query("SELECT a FROM AuditLog a WHERE a.id = :id")
    Optional<AuditLog> findByIdAndDeletedAtIsNull(@Param("id") Long id);
    
    @Query("SELECT COUNT(a) FROM AuditLog a")
    Long countByDeletedAtIsNull();
    
    @Query("SELECT COUNT(a) FROM AuditLog a WHERE a.action = :action")
    Long countByActionAndDeletedAtIsNull(@Param("action") String action);
    
    @Query("SELECT a FROM AuditLog a ORDER BY a.createdAt DESC")
    List<AuditLog> findTop10ByDeletedAtIsNullOrderByCreatedAtDesc();
    
    @Query("SELECT a FROM AuditLog a WHERE " +
           "(:action IS NULL OR a.action = :action) AND " +
           "(:tableName IS NULL OR a.tableName = :tableName) AND " +
           "(:userId IS NULL OR a.user.id = :userId) AND " +
           "(:fromDate IS NULL OR a.createdAt >= :fromDate) AND " +
           "(:toDate IS NULL OR a.createdAt <= :toDate)")
    Page<AuditLog> findAuditLogsWithFilters(@Param("action") String action,
                                           @Param("tableName") String tableName,
                                           @Param("userId") Long userId,
                                           @Param("fromDate") String fromDate,
                                           @Param("toDate") String toDate,
                                           Pageable pageable);
}
