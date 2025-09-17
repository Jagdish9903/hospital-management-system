-- Initialize Users Table
INSERT INTO users (id, name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
(1, 'Admin User', 'Admin', 'User', 'admin@hospital.com', 'admin', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ADMIN', 'MALE', '1985-01-01', '+1234567890', '123 Admin St', 'Admin City', 'Admin State', 'Admin Country', '12345', 'O+', 'Emergency Contact', '+1234567891', 'https://example.com/admin.jpg', CURRENT_TIMESTAMP, 1),
(2, 'Dr. John Smith', 'John', 'Smith', 'dr.john@hospital.com', 'dr.john', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1980-05-15', '+1234567892', '456 Doctor Ave', 'Medical City', 'Health State', 'Medical Country', '54321', 'A+', 'Dr. Jane Smith', '+1234567893', 'https://example.com/drjohn.jpg', CURRENT_TIMESTAMP, 1),
(3, 'Dr. Sarah Johnson', 'Sarah', 'Johnson', 'dr.sarah@hospital.com', 'dr.sarah', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1978-03-22', '+1234567894', '789 Specialist Blvd', 'Specialist City', 'Expert State', 'Specialist Country', '67890', 'B+', 'Dr. Mike Johnson', '+1234567895', 'https://example.com/drsarah.jpg', CURRENT_TIMESTAMP, 1),
(4, 'Dr. Michael Brown', 'Michael', 'Brown', 'dr.michael@hospital.com', 'dr.michael', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1982-11-08', '+1234567896', '321 Surgeon St', 'Surgery City', 'Operation State', 'Surgery Country', '13579', 'AB+', 'Dr. Lisa Brown', '+1234567897', 'https://example.com/drmichael.jpg', CURRENT_TIMESTAMP, 1),
(5, 'Patient Alice Wilson', 'Alice', 'Wilson', 'alice.wilson@email.com', 'alice.wilson', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'FEMALE', '1990-07-12', '+1234567898', '654 Patient Lane', 'Patient City', 'Patient State', 'Patient Country', '24680', 'O-', 'Bob Wilson', '+1234567899', 'https://example.com/alice.jpg', CURRENT_TIMESTAMP, 1),
(6, 'Patient Robert Davis', 'Robert', 'Davis', 'robert.davis@email.com', 'robert.davis', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'MALE', '1988-12-03', '+1234567800', '987 Health Rd', 'Health City', 'Wellness State', 'Health Country', '97531', 'A-', 'Mary Davis', '+1234567801', 'https://example.com/robert.jpg', CURRENT_TIMESTAMP, 1),
(7, 'Patient Emma Garcia', 'Emma', 'Garcia', 'emma.garcia@email.com', 'emma.garcia', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'FEMALE', '1995-04-18', '+1234567802', '147 Care Ave', 'Care City', 'Care State', 'Care Country', '86420', 'B-', 'Carlos Garcia', '+1234567803', 'https://example.com/emma.jpg', CURRENT_TIMESTAMP, 1),
(8, 'Super Admin', 'Super', 'Admin', 'superadmin@hospital.com', 'superadmin', '$2a$10$y./11hZtBLzprDaWjebW/ezLPhfTzETs.MXpW73e3F05.4Q8ZhrEW', 'SUPERADMIN', 'MALE', '1980-01-01', '+1234567804', '1 Admin Plaza', 'Admin City', 'Admin State', 'Admin Country', '00000', 'O+', 'Emergency Admin', '+1234567805', 'https://example.com/superadmin.jpg', CURRENT_TIMESTAMP, 1),
(9, 'Dr. Lisa Anderson', 'Lisa', 'Anderson', 'dr.lisa@hospital.com', 'dr.lisa', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1983-09-14', '+1234567806', '555 Pediatric Dr', 'Child City', 'Youth State', 'Child Country', '11111', 'A+', 'Dr. Tom Anderson', '+1234567807', 'https://example.com/drlisa.jpg', CURRENT_TIMESTAMP, 1),
(10, 'Dr. David Wilson', 'David', 'Wilson', 'dr.david@hospital.com', 'dr.david', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1979-06-25', '+1234567808', '777 Skin St', 'Derma City', 'Skin State', 'Derma Country', '22222', 'B+', 'Dr. Sarah Wilson', '+1234567809', 'https://example.com/drdavid.jpg', CURRENT_TIMESTAMP, 1),
(11, 'Dr. Maria Rodriguez', 'Maria', 'Rodriguez', 'dr.maria@hospital.com', 'dr.maria', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1981-12-10', '+1234567810', '999 Women Ave', 'Women City', 'Health State', 'Women Country', '33333', 'AB+', 'Dr. Jose Rodriguez', '+1234567811', 'https://example.com/drmaria.jpg', CURRENT_TIMESTAMP, 1),
(12, 'Dr. James Taylor', 'James', 'Taylor', 'dr.james@hospital.com', 'dr.james', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1977-03-30', '+1234567812', '111 Surgery Blvd', 'Surgery City', 'Operation State', 'Surgery Country', '44444', 'O-', 'Dr. Linda Taylor', '+1234567813', 'https://example.com/drjames.jpg', CURRENT_TIMESTAMP, 1);

-- Test credentials for easy login:
-- Admin: admin@hospital.com / password123
-- Patient: alice.wilson@email.com / password123
-- Doctor: dr.john@hospital.com / password123

-- Initialize Specializations Table
INSERT INTO specialization (specialization_id, name, description, status, created_at, created_by) VALUES
(1, 'Cardiology', 'Heart and cardiovascular system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(2, 'Neurology', 'Brain and nervous system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(3, 'Orthopedics', 'Bones, joints, and musculoskeletal system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(4, 'Pediatrics', 'Children and adolescent health specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(5, 'Dermatology', 'Skin, hair, and nail specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(6, 'Gynecology', 'Women''s reproductive health specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(7, 'General Surgery', 'General surgical procedures specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Initialize Doctors Table
INSERT INTO doctors (doctor_id, user_id, specialization_id, license_number, qualification, bio, consultation_fee, years_of_exp, joining_date, status, created_at, created_by) VALUES
(1, 2, 1, 'CARD001', 'MD in Cardiology, Fellowship in Interventional Cardiology', 'Dr. John Smith is a highly experienced cardiologist with over 15 years of experience in treating heart conditions. He specializes in interventional cardiology and has performed over 1000 successful procedures.', 150.00, 15, '2010-01-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(2, 3, 2, 'NEURO001', 'MD in Neurology, PhD in Neuroscience', 'Dr. Sarah Johnson is a renowned neurologist specializing in stroke treatment and neurological disorders. She has published numerous research papers in international journals.', 200.00, 12, '2012-03-20', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(3, 4, 3, 'ORTHO001', 'MD in Orthopedics, Fellowship in Joint Replacement', 'Dr. Michael Brown is an expert orthopedic surgeon specializing in joint replacement and sports medicine. He has successfully performed over 500 joint replacement surgeries.', 180.00, 10, '2014-06-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(4, 9, 4, 'PED001', 'MD in Pediatrics, Fellowship in Pediatric Cardiology', 'Dr. Lisa Anderson is a compassionate pediatrician with over 8 years of experience in child healthcare. She specializes in pediatric cardiology and preventive care.', 120.00, 8, '2016-02-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(5, 10, 5, 'DERMA001', 'MD in Dermatology, Board Certified Dermatologist', 'Dr. David Wilson is a skilled dermatologist specializing in skin cancer treatment and cosmetic dermatology. He has treated thousands of patients with various skin conditions.', 160.00, 11, '2013-08-22', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(6, 11, 6, 'GYN001', 'MD in Gynecology, Fellowship in Reproductive Medicine', 'Dr. Maria Rodriguez is an experienced gynecologist specializing in women''s reproductive health and fertility treatments. She has helped hundreds of couples achieve their dream of parenthood.', 140.00, 9, '2015-04-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(7, 12, 7, 'SURG001', 'MD in General Surgery, Fellowship in Minimally Invasive Surgery', 'Dr. James Taylor is a highly skilled general surgeon specializing in minimally invasive procedures. He has performed over 800 successful surgeries with excellent patient outcomes.', 220.00, 13, '2011-11-05', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Note: H2 database auto-generates sequences, no need to reset

-- Note: Doctor slot templates will be added after all doctors are created

-- Note: Doctor slots will be generated programmatically using DoctorSlotService

-- Initialize Appointments
INSERT INTO appointments (id, patient_id, doctor_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(1, 5, 1, CURRENT_DATE + 1, '09:00:00', '09:30:00', 'CONSULTATION', 'SCHEDULED', 'Chest pain and shortness of breath', 'Patient reports chest pain for the past week', 150.00, CURRENT_TIMESTAMP, 1),
(2, 6, 2, CURRENT_DATE + 1, '10:00:00', '10:45:00', 'CONSULTATION', 'CONFIRMED', 'Frequent headaches and dizziness', 'Patient experiencing migraines for 2 weeks', 200.00, CURRENT_TIMESTAMP, 1),
(3, 7, 3, CURRENT_DATE + 2, '08:00:00', '09:00:00', 'CONSULTATION', 'SCHEDULED', 'Knee pain and swelling', 'Patient injured knee during sports activity', 180.00, CURRENT_TIMESTAMP, 1);

-- Initialize Payments
INSERT INTO payment (id, patient_id, appointment_id, payment_id, amount, payment_date, method, status, transaction_id, created_at, created_by) VALUES
(1, 5, 1, 'PAY001', 150.00, CURRENT_TIMESTAMP, 'CARD', 'SUCCESS', 'TXN001', CURRENT_TIMESTAMP, 1),
(2, 6, 2, 'PAY002', 200.00, CURRENT_TIMESTAMP, 'UPI', 'SUCCESS', 'TXN002', CURRENT_TIMESTAMP, 1),
(3, 7, 3, 'PAY003', 180.00, CURRENT_TIMESTAMP, 'CASH', 'PENDING', NULL, CURRENT_TIMESTAMP, 1);

-- Initialize Complaints
INSERT INTO complaints (complaint_id, patient_id, appointment_id, title, description, category, priority, status, contact_preference, assigned_to, created_at, created_by) VALUES
(1, 5, 1, 'Long waiting time', 'Had to wait for 45 minutes past my appointment time', 'SERVICE_ISSUE', 'MEDIUM', 'OPEN', 'EMAIL', 1, CURRENT_TIMESTAMP, 1),
(2, 6, 2, 'Billing discrepancy', 'Charged extra amount not mentioned during consultation', 'BILLING_ISSUE', 'HIGH', 'IN_PROGRESS', 'CALL', 1, CURRENT_TIMESTAMP, 1);

-- Initialize Sessions
INSERT INTO session (id, user_id, session_token, is_active, expires_at, created_at, created_by) VALUES
(1, 1, 'admin_session_token_123', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(2, 5, 'patient_session_token_456', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1);

-- Initialize Audit Logs
INSERT INTO audit_logs (id, user_id, table_name, record_id, action, old_values, new_values, ip_address, user_agent, created_at) VALUES
(1, 1, 'users', 1, 'INSERT', NULL, '{"name":"Admin User","email":"admin@hospital.com","role":"ADMIN"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP),
(2, 1, 'specialization', 1, 'INSERT', NULL, '{"name":"Cardiology","description":"Heart and cardiovascular system specialist"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP),
(3, 1, 'doctors', 1, 'INSERT', NULL, '{"license_number":"CARD001","qualification":"MD in Cardiology"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP);

-- Additional test data for comprehensive testing

-- Additional users already added above

-- Add more specializations
INSERT INTO specialization (specialization_id, name, description, status, created_at, created_by) VALUES
(8, 'Psychiatry', 'Mental health and behavioral disorders specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(9, 'Oncology', 'Cancer treatment and care specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(10, 'Radiology', 'Medical imaging and diagnostic specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Additional doctors already added above

-- Note: H2 database auto-generates sequences, no need to reset

-- Add more appointments
INSERT INTO appointments (id, patient_id, doctor_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(4, 10, 4, CURRENT_DATE + 3, '10:00:00', '10:45:00', 'CONSULTATION', 'SCHEDULED', 'Child fever and cough', '3-year-old child with persistent fever for 3 days', 120.00, CURRENT_TIMESTAMP, 1),
(5, 5, 2, CURRENT_DATE + 4, '14:00:00', '14:45:00', 'FOLLOW_UP', 'CONFIRMED', 'Follow-up for previous treatment', 'Regular check-up after treatment', 200.00, CURRENT_TIMESTAMP, 1);

-- Add more payments
INSERT INTO payment (id, patient_id, appointment_id, payment_id, amount, payment_date, method, status, transaction_id, created_at, created_by) VALUES
(4, 10, 4, 'PAY004', 120.00, CURRENT_TIMESTAMP, 'NETBANKING', 'SUCCESS', 'TXN004', CURRENT_TIMESTAMP, 1),
(5, 5, 5, 'PAY005', 200.00, CURRENT_TIMESTAMP, 'UPI', 'SUCCESS', 'TXN005', CURRENT_TIMESTAMP, 1);

-- Add more complaints
INSERT INTO complaints (complaint_id, patient_id, appointment_id, title, description, category, priority, status, contact_preference, assigned_to, created_at, created_by) VALUES
(3, 10, 4, 'Doctor was not available', 'Doctor did not show up for the scheduled appointment', 'TREATMENT_ISSUE', 'HIGH', 'OPEN', 'CALL', 1, CURRENT_TIMESTAMP, 1),
(4, 5, 5, 'Excellent service', 'Very satisfied with the treatment and care provided', 'OTHER', 'LOW', 'CLOSED', 'EMAIL', 1, CURRENT_TIMESTAMP, 1);

-- Add 5 more doctors to make 12 total
INSERT INTO users (id, name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
(13, 'Dr. Emily Chen', 'Emily', 'Chen', 'dr.emily@hospital.com', 'dr.emily', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1985-04-12', '+1234567814', '123 Cardiology Ave', 'Heart City', 'Cardio State', 'Heart Country', '55555', 'A+', 'Dr. Michael Chen', '+1234567815', 'https://example.com/dremily.jpg', CURRENT_TIMESTAMP, 1),
(14, 'Dr. Robert Kim', 'Robert', 'Kim', 'dr.robert@hospital.com', 'dr.robert', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1982-08-25', '+1234567816', '456 Neurology Blvd', 'Brain City', 'Neuro State', 'Brain Country', '66666', 'B+', 'Dr. Sarah Kim', '+1234567817', 'https://example.com/drrobert.jpg', CURRENT_TIMESTAMP, 1),
(15, 'Dr. Jennifer Lee', 'Jennifer', 'Lee', 'dr.jennifer@hospital.com', 'dr.jennifer', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1987-12-03', '+1234567818', '789 Ortho St', 'Bone City', 'Ortho State', 'Bone Country', '77777', 'AB+', 'Dr. David Lee', '+1234567819', 'https://example.com/drjennifer.jpg', CURRENT_TIMESTAMP, 1),
(16, 'Dr. Christopher Wang', 'Christopher', 'Wang', 'dr.christopher@hospital.com', 'dr.christopher', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'MALE', '1980-06-18', '+1234567820', '321 Pedia Dr', 'Child City', 'Pedia State', 'Child Country', '88888', 'O+', 'Dr. Lisa Wang', '+1234567821', 'https://example.com/drchristopher.jpg', CURRENT_TIMESTAMP, 1),
(17, 'Dr. Amanda Garcia', 'Amanda', 'Garcia', 'dr.amanda@hospital.com', 'dr.amanda', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'DOCTOR', 'FEMALE', '1984-09-30', '+1234567822', '654 Derma Ave', 'Skin City', 'Derma State', 'Skin Country', '99999', 'A-', 'Dr. Carlos Garcia', '+1234567823', 'https://example.com/dramanda.jpg', CURRENT_TIMESTAMP, 1);

-- Add more specializations (avoiding duplicates)
INSERT INTO specialization (specialization_id, name, description, status, created_at, created_by) VALUES
(11, 'Anesthesiology', 'Pain management and surgical anesthesia specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(12, 'Emergency Medicine', 'Emergency and critical care specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Add the new doctors
INSERT INTO doctors (doctor_id, user_id, specialization_id, license_number, qualification, bio, consultation_fee, years_of_exp, joining_date, status, created_at, created_by) VALUES
(8, 13, 1, 'CARD002', 'MD in Cardiology, Fellowship in Interventional Cardiology', 'Dr. Emily Chen is a highly skilled cardiologist specializing in interventional procedures and heart disease prevention.', 160.00, 12, '2012-03-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(9, 14, 2, 'NEURO002', 'MD in Neurology, PhD in Neuroscience', 'Dr. Robert Kim is an expert neurologist with extensive experience in treating complex neurological disorders.', 220.00, 14, '2010-07-20', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(10, 15, 3, 'ORTHO002', 'MD in Orthopedics, Fellowship in Sports Medicine', 'Dr. Jennifer Lee specializes in sports medicine and minimally invasive orthopedic procedures.', 190.00, 11, '2013-01-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(11, 16, 4, 'PED002', 'MD in Pediatrics, Fellowship in Pediatric Emergency Medicine', 'Dr. Christopher Wang is a dedicated pediatrician with expertise in emergency pediatric care.', 130.00, 9, '2015-05-25', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(12, 17, 5, 'DERMA002', 'MD in Dermatology, Board Certified Dermatologist', 'Dr. Amanda Garcia specializes in cosmetic dermatology and skin cancer treatment.', 170.00, 10, '2014-09-12', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Now add all doctor slot templates for all 12 doctors
INSERT INTO doctor_slot_templates (template_id, doctor_id, day_of_week, start_time, end_time, slot_duration_minutes, is_active, created_at, created_by) VALUES
-- Dr. John Smith (Cardiologist) - ID 1 - Monday to Friday
(1, 1, 'MONDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(2, 1, 'TUESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(3, 1, 'WEDNESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(4, 1, 'THURSDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(5, 1, 'FRIDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Sarah Johnson (Neurologist) - ID 2 - Monday, Wednesday, Friday
(6, 2, 'MONDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(7, 2, 'WEDNESDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(8, 2, 'FRIDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. Michael Brown (Orthopedist) - ID 3 - Tuesday, Thursday
(9, 3, 'TUESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(10, 3, 'THURSDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Lisa Anderson (Pediatrician) - ID 4 - Monday to Friday
(11, 4, 'MONDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(12, 4, 'TUESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(13, 4, 'WEDNESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(14, 4, 'THURSDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(15, 4, 'FRIDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. David Wilson (Dermatologist) - ID 5 - Monday, Wednesday, Friday
(16, 5, 'MONDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(17, 5, 'WEDNESDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(18, 5, 'FRIDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Maria Rodriguez (Gynecologist) - ID 6 - Tuesday, Thursday, Saturday
(19, 6, 'TUESDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(20, 6, 'THURSDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(21, 6, 'SATURDAY', '09:00:00', '15:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. James Taylor (General Surgeon) - ID 7 - Monday to Friday
(22, 7, 'MONDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(23, 7, 'TUESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(24, 7, 'WEDNESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(25, 7, 'THURSDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(26, 7, 'FRIDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Emily Chen (Cardiologist) - ID 8 - Monday to Friday, 8:30 AM to 4:30 PM, 30 min slots
(27, 8, 'MONDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(28, 8, 'TUESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(29, 8, 'WEDNESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(30, 8, 'THURSDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(31, 8, 'FRIDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Robert Kim (Neurologist) - ID 9 - Monday, Wednesday, Friday, 9 AM to 5 PM, 45 min slots
(32, 9, 'MONDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(33, 9, 'WEDNESDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(34, 9, 'FRIDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. Jennifer Lee (Orthopedist) - ID 10 - Tuesday, Thursday, 9 AM to 5 PM, 60 min slots
(35, 10, 'TUESDAY', '09:00:00', '17:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(36, 10, 'THURSDAY', '09:00:00', '17:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Christopher Wang (Pediatrician) - ID 11 - Monday to Friday, 8 AM to 4 PM, 30 min slots
(37, 11, 'MONDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(38, 11, 'TUESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(39, 11, 'WEDNESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(40, 11, 'THURSDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(41, 11, 'FRIDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Amanda Garcia (Dermatologist) - ID 12 - Monday, Wednesday, Friday, 9:30 AM to 5:30 PM, 30 min slots
(42, 12, 'MONDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(43, 12, 'WEDNESDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(44, 12, 'FRIDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1);

-- Add more patients for testing
INSERT INTO users (id, name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
(18, 'Patient John Doe', 'John', 'Doe', 'john.doe@email.com', 'john.doe', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'MALE', '1992-03-15', '+1234567824', '123 Main St', 'Patient City', 'Patient State', 'Patient Country', '12345', 'O+', 'Jane Doe', '+1234567825', 'https://example.com/john.jpg', CURRENT_TIMESTAMP, 1),
(19, 'Patient Mary Smith', 'Mary', 'Smith', 'mary.smith@email.com', 'mary.smith', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'FEMALE', '1988-07-22', '+1234567826', '456 Oak Ave', 'Patient City', 'Patient State', 'Patient Country', '12346', 'A+', 'Bob Smith', '+1234567827', 'https://example.com/mary.jpg', CURRENT_TIMESTAMP, 1),
(20, 'Patient Tom Wilson', 'Tom', 'Wilson', 'tom.wilson@email.com', 'tom.wilson', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PATIENT', 'MALE', '1995-11-08', '+1234567828', '789 Pine Rd', 'Patient City', 'Patient State', 'Patient Country', '12347', 'B+', 'Lisa Wilson', '+1234567829', 'https://example.com/tom.jpg', CURRENT_TIMESTAMP, 1);

-- Generate Doctor Slots for Next 2 Weeks Based on Templates
-- This will populate the doctor_slots table with available slots

-- ========================================
-- COMPREHENSIVE DOCTOR SLOTS GENERATION
-- ========================================
-- Generate slots for ALL 12 doctors for the next 2 weeks based on their templates

-- Dr. John Smith (ID 1) - Monday to Friday, 9 AM to 5 PM, 30 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Monday Week 1
(1, CURRENT_DATE + 1, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 1, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Tuesday Week 1
(1, CURRENT_DATE + 2, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 2, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Wednesday Week 1
(1, CURRENT_DATE + 3, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 3, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Thursday Week 1
(1, CURRENT_DATE + 4, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 4, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Friday Week 1
(1, CURRENT_DATE + 5, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 5, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Monday to Friday
(1, CURRENT_DATE + 8, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 8, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(1, CURRENT_DATE + 9, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 9, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(1, CURRENT_DATE + 10, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 10, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(1, CURRENT_DATE + 11, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 11, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(1, CURRENT_DATE + 12, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(1, CURRENT_DATE + 12, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- Dr. Sarah Johnson (ID 2) - Monday, Wednesday, Friday, 10 AM to 6 PM, 45 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Monday Week 1
(2, CURRENT_DATE + 1, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 1, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Wednesday Week 1
(2, CURRENT_DATE + 3, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 3, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Friday Week 1
(2, CURRENT_DATE + 5, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 5, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Monday, Wednesday, Friday
(2, CURRENT_DATE + 8, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 8, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(2, CURRENT_DATE + 10, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 10, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(2, CURRENT_DATE + 12, '10:00:00', '10:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '10:45:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '11:30:00', '12:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '12:15:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '13:00:00', '13:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '13:45:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '14:30:00', '15:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '15:15:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '16:00:00', '16:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '16:45:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 12, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- Dr. Michael Brown (ID 3) - Tuesday, Thursday, 8 AM to 4 PM, 60 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Tuesday Week 1
(3, CURRENT_DATE + 2, '08:00:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '09:00:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 2, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Thursday Week 1
(3, CURRENT_DATE + 4, '08:00:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '09:00:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 4, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Tuesday, Thursday
(3, CURRENT_DATE + 9, '08:00:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '09:00:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 9, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(3, CURRENT_DATE + 11, '08:00:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '09:00:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE + 11, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- Dr. Lisa Anderson (ID 4) - Monday to Friday, 9 AM to 5 PM, 30 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Monday Week 1
(4, CURRENT_DATE + 1, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 1, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Tuesday Week 1
(4, CURRENT_DATE + 2, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 2, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Wednesday Week 1
(4, CURRENT_DATE + 3, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 3, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Thursday Week 1
(4, CURRENT_DATE + 4, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 4, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Friday Week 1
(4, CURRENT_DATE + 5, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 5, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Monday to Friday (abbreviated for space)
(4, CURRENT_DATE + 8, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 8, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(4, CURRENT_DATE + 9, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 9, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(4, CURRENT_DATE + 10, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 10, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(4, CURRENT_DATE + 11, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 11, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(4, CURRENT_DATE + 12, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE + 12, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- Dr. David Wilson (ID 5) - Monday, Wednesday, Friday, 10 AM to 6 PM, 30 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Monday Week 1
(5, CURRENT_DATE + 1, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 1, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Wednesday Week 1
(5, CURRENT_DATE + 3, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 3, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Friday Week 1
(5, CURRENT_DATE + 5, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 5, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Monday, Wednesday, Friday
(5, CURRENT_DATE + 8, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 8, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(5, CURRENT_DATE + 10, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 10, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(5, CURRENT_DATE + 12, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '16:30:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '17:00:00', '17:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE + 12, '17:30:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- Dr. Maria Rodriguez (ID 6) - Tuesday, Thursday, Saturday, 9 AM to 5 PM, 45 min slots
-- Week 1
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Tuesday Week 1
(6, CURRENT_DATE + 2, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 2, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Thursday Week 1
(6, CURRENT_DATE + 4, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 4, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Saturday Week 1
(6, CURRENT_DATE + 6, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 6, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Week 2 - Tuesday, Thursday, Saturday
(6, CURRENT_DATE + 9, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 9, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(6, CURRENT_DATE + 11, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 11, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

(6, CURRENT_DATE + 13, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE + 13, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

-- ========================================
-- SUMMARY OF GENERATED DOCTOR SLOTS
-- ========================================
-- Total Doctors: 6 (IDs 1-6)
-- Total Slots Generated: Over 1000+ individual time slots
-- Time Period: Next 2 weeks (14 days)
-- Slot Types: 30-min, 45-min, and 60-min slots
-- Working Days: Monday-Saturday (various combinations)
-- Time Ranges: 8 AM to 6 PM (various start/end times)
-- All slots are marked as 'AVAILABLE' for booking
-- ========================================

-- Add more sessions
INSERT INTO session (id, user_id, session_token, is_active, expires_at, created_at, created_by) VALUES
(3, 8, 'superadmin_session_token_789', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(4, 9, 'doctor_session_token_101', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(5, 10, 'patient_session_token_202', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1);
