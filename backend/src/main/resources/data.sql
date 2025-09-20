-- Initialize Users Table
INSERT INTO users (name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
('Admin User', 'Admin', 'User', 'admin@hospital.com', 'admin', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'ADMIN', 'MALE', '1985-01-01', '+1234567890', '123 Admin St', 'Admin City', 'Admin State', 'Admin Country', '12345', 'O+', 'Emergency Contact', '+1234567891', 'https://example.com/admin.jpg', CURRENT_TIMESTAMP, 1),
('Dr. John Smith', 'John', 'Smith', 'dr.john@hospital.com', 'dr.john', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1980-05-15', '+1234567892', '456 Doctor Ave', 'Medical City', 'Health State', 'Medical Country', '54321', 'A+', 'Dr. Jane Smith', '+1234567893', 'https://example.com/drjohn.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Sarah Johnson', 'Sarah', 'Johnson', 'dr.sarah@hospital.com', 'dr.sarah', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1978-03-22', '+1234567894', '789 Specialist Blvd', 'Specialist City', 'Expert State', 'Specialist Country', '67890', 'B+', 'Dr. Mike Johnson', '+1234567895', 'https://example.com/drsarah.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Michael Brown', 'Michael', 'Brown', 'dr.michael@hospital.com', 'dr.michael', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1982-11-08', '+1234567896', '321 Surgeon St', 'Surgery City', 'Operation State', 'Surgery Country', '13579', 'AB+', 'Dr. Lisa Brown', '+1234567897', 'https://example.com/drmichael.jpg', CURRENT_TIMESTAMP, 1),
('Patient Alice Wilson', 'Alice', 'Wilson', 'alice.wilson@email.com', 'alice.wilson', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'FEMALE', '1990-07-12', '+1234567898', '654 Patient Lane', 'Patient City', 'Patient State', 'Patient Country', '24680', 'O-', 'Bob Wilson', '+1234567899', 'https://example.com/alice.jpg', CURRENT_TIMESTAMP, 1),
('Patient Robert Davis', 'Robert', 'Davis', 'robert.davis@email.com', 'robert.davis', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'MALE', '1988-12-03', '+1234567800', '987 Health Rd', 'Health City', 'Wellness State', 'Health Country', '97531', 'A-', 'Mary Davis', '+1234567801', 'https://example.com/robert.jpg', CURRENT_TIMESTAMP, 1),
('Patient Emma Garcia', 'Emma', 'Garcia', 'emma.garcia@email.com', 'emma.garcia', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'FEMALE', '1995-04-18', '+1234567802', '147 Care Ave', 'Care City', 'Care State', 'Care Country', '86420', 'B-', 'Carlos Garcia', '+1234567803', 'https://example.com/emma.jpg', CURRENT_TIMESTAMP, 1),
('Super Admin', 'Super', 'Admin', 'superadmin@hospital.com', 'superadmin', '$2a$10$y./11hZtBLzprDaWjebW/ezLPhfTzETs.MXpW73e3F05.4Q8ZhrEW', 'SUPERADMIN', 'MALE', '1980-01-01', '+1234567804', '1 Admin Plaza', 'Admin City', 'Admin State', 'Admin Country', '00000', 'O+', 'Emergency Admin', '+1234567805', 'https://example.com/superadmin.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Lisa Anderson', 'Lisa', 'Anderson', 'dr.lisa@hospital.com', 'dr.lisa', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1983-09-14', '+1234567806', '555 Pediatric Dr', 'Child City', 'Youth State', 'Child Country', '11111', 'A+', 'Dr. Tom Anderson', '+1234567807', 'https://example.com/drlisa.jpg', CURRENT_TIMESTAMP, 1),
('Dr. David Wilson', 'David', 'Wilson', 'dr.david@hospital.com', 'dr.david', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1979-06-25', '+1234567808', '777 Skin St', 'Derma City', 'Skin State', 'Derma Country', '22222', 'B+', 'Dr. Sarah Wilson', '+1234567809', 'https://example.com/drdavid.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Maria Rodriguez', 'Maria', 'Rodriguez', 'dr.maria@hospital.com', 'dr.maria', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1981-12-10', '+1234567810', '999 Women Ave', 'Women City', 'Health State', 'Women Country', '33333', 'AB+', 'Dr. Jose Rodriguez', '+1234567811', 'https://example.com/drmaria.jpg', CURRENT_TIMESTAMP, 1),
('Dr. James Taylor', 'James', 'Taylor', 'dr.james@hospital.com', 'dr.james', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1977-03-30', '+1234567812', '111 Surgery Blvd', 'Surgery City', 'Operation State', 'Surgery Country', '44444', 'O-', 'Dr. Linda Taylor', '+1234567813', 'https://example.com/drjames.jpg', CURRENT_TIMESTAMP, 1);

-- Test credentials for easy login:
-- Admin: admin@hospital.com / password123
-- Patient: alice.wilson@email.com / password123
-- Doctor: dr.john@hospital.com / password123

-- Initialize Specializations Table
INSERT INTO specialization (name, description, status, created_at, created_by) VALUES
('Cardiology', 'Heart and cardiovascular system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Neurology', 'Brain and nervous system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Orthopedics', 'Bones, joints, and musculoskeletal system specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Pediatrics', 'Children and adolescent health specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Dermatology', 'Skin, hair, and nail specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Gynecology', 'Women''s reproductive health specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('General Surgery', 'General surgical procedures specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Initialize Doctors Table
INSERT INTO doctors (user_id, specialization_id, license_number, qualification, bio, consultation_fee, years_of_exp, joining_date, status, created_at, created_by) VALUES
(2, 1, 'CARD001', 'MD in Cardiology, Fellowship in Interventional Cardiology', 'Dr. John Smith is a highly experienced cardiologist with over 15 years of experience in treating heart conditions. He specializes in interventional cardiology and has performed over 1000 successful procedures.', 150.00, 15, '2010-01-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(3, 2, 'NEURO001', 'MD in Neurology, PhD in Neuroscience', 'Dr. Sarah Johnson is a renowned neurologist specializing in stroke treatment and neurological disorders. She has published numerous research papers in international journals.', 200.00, 12, '2012-03-20', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(4, 3, 'ORTHO001', 'MD in Orthopedics, Fellowship in Joint Replacement', 'Dr. Michael Brown is an expert orthopedic surgeon specializing in joint replacement and sports medicine. He has successfully performed over 500 joint replacement surgeries.', 180.00, 10, '2014-06-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(9, 4, 'PED001', 'MD in Pediatrics, Fellowship in Pediatric Cardiology', 'Dr. Lisa Anderson is a compassionate pediatrician with over 8 years of experience in child healthcare. She specializes in pediatric cardiology and preventive care.', 120.00, 8, '2016-02-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(10, 5, 'DERMA001', 'MD in Dermatology, Board Certified Dermatologist', 'Dr. David Wilson is a skilled dermatologist specializing in skin cancer treatment and cosmetic dermatology. He has treated thousands of patients with various skin conditions.', 160.00, 11, '2013-08-22', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(11, 6, 'GYN001', 'MD in Gynecology, Fellowship in Reproductive Medicine', 'Dr. Maria Rodriguez is an experienced gynecologist specializing in women''s reproductive health and fertility treatments. She has helped hundreds of couples achieve their dream of parenthood.', 140.00, 9, '2015-04-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(12, 7, 'SURG001', 'MD in General Surgery, Fellowship in Minimally Invasive Surgery', 'Dr. James Taylor is a highly skilled general surgeon specializing in minimally invasive procedures. He has performed over 800 successful surgeries with excellent patient outcomes.', 220.00, 13, '2011-11-05', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Note: H2 database auto-generates sequences, no need to reset

-- Note: Doctor slot templates will be added after all doctors are created

-- Note: Doctor slots will be generated programmatically using DoctorSlotService

-- Initialize Appointments with proper slot management
-- First, create the specific slots as BOOKED for specific dates
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
(1, '2025-09-21', '09:00:00', '09:30:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(2, '2025-09-21', '10:00:00', '10:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(3, '2025-09-22', '08:00:00', '09:00:00', 'BOOKED', CURRENT_TIMESTAMP, 1);

-- Now create appointments with proper slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(5, 1, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 1 AND slot_date = '2025-09-21' AND start_time = '09:00:00' AND end_time = '09:30:00'), '2025-09-21', '09:00:00', '09:30:00', 'CONSULTATION', 'SCHEDULED', 'Chest pain and shortness of breath', 'Patient reports chest pain for the past week', 150.00, CURRENT_TIMESTAMP, 1),
(6, 2, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 2 AND slot_date = '2025-09-21' AND start_time = '10:00:00' AND end_time = '10:45:00'), '2025-09-21', '10:00:00', '10:45:00', 'CONSULTATION', 'SCHEDULED', 'Frequent headaches and dizziness', 'Patient experiencing migraines for 2 weeks', 200.00, CURRENT_TIMESTAMP, 1),
(7, 3, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 3 AND slot_date = '2025-09-22' AND start_time = '08:00:00' AND end_time = '09:00:00'), '2025-09-22', '08:00:00', '09:00:00', 'CONSULTATION', 'SCHEDULED', 'Knee pain and swelling', 'Patient injured knee during sports activity', 180.00, CURRENT_TIMESTAMP, 1);

-- Initialize Payments
INSERT INTO payment (patient_id, appointment_id, payment_id, amount, payment_date, method, status, transaction_id, created_at, created_by) VALUES
(5, 1, 'PAY001', 150.00, CURRENT_TIMESTAMP, 'CARD', 'SUCCESS', 'TXN001', CURRENT_TIMESTAMP, 1),
(6, 2, 'PAY002', 200.00, CURRENT_TIMESTAMP, 'UPI', 'SUCCESS', 'TXN002', CURRENT_TIMESTAMP, 1),
(7, 3, 'PAY003', 180.00, CURRENT_TIMESTAMP, 'CASH', 'PENDING', NULL, CURRENT_TIMESTAMP, 1);

-- Initialize Complaints
INSERT INTO complaints (patient_id, appointment_id, title, description, category, priority, status, contact_preference, assigned_to, created_at, created_by) VALUES
(5, 1, 'Long waiting time', 'Had to wait for 45 minutes past my appointment time', 'SERVICE_ISSUE', 'MEDIUM', 'OPEN', 'EMAIL', 1, CURRENT_TIMESTAMP, 1),
(6, 2, 'Billing discrepancy', 'Charged extra amount not mentioned during consultation', 'BILLING_ISSUE', 'HIGH', 'IN_PROGRESS', 'CALL', 1, CURRENT_TIMESTAMP, 1);

-- Initialize Sessions
INSERT INTO session (user_id, session_token, is_active, expires_at, created_at, created_by) VALUES
(1, 'admin_session_token_123', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(5, 'patient_session_token_456', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1);

-- Initialize Audit Logs
INSERT INTO audit_logs (user_id, table_name, record_id, action, old_values, new_values, ip_address, user_agent, created_at) VALUES
(1, 'users', 1, 'INSERT', NULL, '{"name":"Admin User","email":"admin@hospital.com","role":"ADMIN"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP),
(1, 'specialization', 1, 'INSERT', NULL, '{"name":"Cardiology","description":"Heart and cardiovascular system specialist"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP),
(1, 'doctors', 1, 'INSERT', NULL, '{"license_number":"CARD001","qualification":"MD in Cardiology"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', CURRENT_TIMESTAMP);

-- Additional test data for comprehensive testing

-- Additional users already added above

-- Add more specializations
INSERT INTO specialization (name, description, status, created_at, created_by) VALUES
('Psychiatry', 'Mental health and behavioral disorders specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Oncology', 'Cancer treatment and care specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Radiology', 'Medical imaging and diagnostic specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Additional doctors already added above

-- Note: H2 database auto-generates sequences, no need to reset

-- Add more appointments with proper slot management
-- Create slots as BOOKED
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
(4, CURRENT_DATE + 3, '10:00:00', '10:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE + 4, '14:00:00', '14:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1);

-- Create appointments with slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(10, 4, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 4 AND slot_date = CURRENT_DATE + 3 AND start_time = '10:00:00' AND end_time = '10:45:00'), CURRENT_DATE + 3, '10:00:00', '10:45:00', 'CONSULTATION', 'SCHEDULED', 'Child fever and cough', '3-year-old child with persistent fever for 3 days', 120.00, CURRENT_TIMESTAMP, 1),
(5, 2, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 2 AND slot_date = CURRENT_DATE + 4 AND start_time = '14:00:00' AND end_time = '14:45:00'), CURRENT_DATE + 4, '14:00:00', '14:45:00', 'FOLLOW_UP', 'SCHEDULED', 'Follow-up for previous treatment', 'Regular check-up after treatment', 200.00, CURRENT_TIMESTAMP, 1);

-- Super Admin Appointments (Past and Future)
-- First create past doctor slots for completed appointments
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Past slots for completed appointments
(1, CURRENT_DATE - 7, '09:00:00', '09:30:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(2, CURRENT_DATE - 6, '14:00:00', '14:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(3, CURRENT_DATE - 5, '10:30:00', '11:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(4, CURRENT_DATE - 4, '15:00:00', '15:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(5, CURRENT_DATE - 3, '11:00:00', '11:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(6, CURRENT_DATE - 2, '16:00:00', '16:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(7, CURRENT_DATE - 1, '08:30:00', '09:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1);

-- Past appointments for superadmin (user_id = 8) with proper slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(8, 1, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 1 AND slot_date = CURRENT_DATE - 7 AND start_time = '09:00:00' AND end_time = '09:30:00'), CURRENT_DATE - 7, '09:00:00', '09:30:00', 'CONSULTATION', 'COMPLETED', 'Annual health checkup', 'Routine annual health examination', 150.00, CURRENT_TIMESTAMP, 1),
(8, 2, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 2 AND slot_date = CURRENT_DATE - 6 AND start_time = '14:00:00' AND end_time = '14:45:00'), CURRENT_DATE - 6, '14:00:00', '14:45:00', 'CONSULTATION', 'COMPLETED', 'Headache evaluation', 'Persistent headaches for evaluation', 200.00, CURRENT_TIMESTAMP, 1),
(8, 3, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 3 AND slot_date = CURRENT_DATE - 5 AND start_time = '10:30:00' AND end_time = '11:15:00'), CURRENT_DATE - 5, '10:30:00', '11:15:00', 'FOLLOW_UP', 'COMPLETED', 'Knee pain follow-up', 'Follow-up for previous knee injury', 180.00, CURRENT_TIMESTAMP, 1),
(8, 4, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 4 AND slot_date = CURRENT_DATE - 4 AND start_time = '15:00:00' AND end_time = '15:45:00'), CURRENT_DATE - 4, '15:00:00', '15:45:00', 'CONSULTATION', 'COMPLETED', 'General consultation', 'General health consultation', 120.00, CURRENT_TIMESTAMP, 1),
(8, 5, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 5 AND slot_date = CURRENT_DATE - 3 AND start_time = '11:00:00' AND end_time = '11:45:00'), CURRENT_DATE - 3, '11:00:00', '11:45:00', 'CONSULTATION', 'COMPLETED', 'Skin examination', 'Annual skin checkup', 160.00, CURRENT_TIMESTAMP, 1),
(8, 6, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 6 AND slot_date = CURRENT_DATE - 2 AND start_time = '16:00:00' AND end_time = '16:45:00'), CURRENT_DATE - 2, '16:00:00', '16:45:00', 'CONSULTATION', 'COMPLETED', 'Women health checkup', 'Routine women health examination', 140.00, CURRENT_TIMESTAMP, 1),
(8, 7, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 7 AND slot_date = CURRENT_DATE - 1 AND start_time = '08:30:00' AND end_time = '09:15:00'), CURRENT_DATE - 1, '08:30:00', '09:15:00', 'EMERGENCY', 'COMPLETED', 'Emergency consultation', 'Emergency medical consultation', 220.00, CURRENT_TIMESTAMP, 1);

-- Future appointments for superadmin with proper slot management
-- First create future slots for scheduled appointments with specific dates
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
-- Future slots for scheduled appointments
(1, '2025-09-21', '09:30:00', '10:00:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(2, '2025-09-22', '14:30:00', '15:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(3, '2025-09-23', '10:00:00', '10:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(4, '2025-09-24', '15:30:00', '16:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(5, '2025-09-25', '11:30:00', '12:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(6, '2025-09-26', '16:30:00', '17:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(7, '2025-09-27', '08:00:00', '08:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(1, '2025-09-28', '09:00:00', '09:30:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(2, '2025-09-29', '14:00:00', '14:45:00', 'BOOKED', CURRENT_TIMESTAMP, 1),
(3, '2025-09-30', '10:30:00', '11:15:00', 'BOOKED', CURRENT_TIMESTAMP, 1);

-- Create future appointments with slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(8, 1, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 1 AND slot_date = '2025-09-21' AND start_time = '09:30:00' AND end_time = '10:00:00'), '2025-09-21', '09:30:00', '10:00:00', 'CONSULTATION', 'SCHEDULED', 'Cardiology follow-up', 'Follow-up cardiology consultation', 150.00, CURRENT_TIMESTAMP, 1),
(8, 2, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 2 AND slot_date = '2025-09-22' AND start_time = '14:30:00' AND end_time = '15:15:00'), '2025-09-22', '14:30:00', '15:15:00', 'CONSULTATION', 'SCHEDULED', 'Neurology consultation', 'Neurological symptoms evaluation', 200.00, CURRENT_TIMESTAMP, 1),
(8, 3, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 3 AND slot_date = '2025-09-23' AND start_time = '10:00:00' AND end_time = '10:45:00'), '2025-09-23', '10:00:00', '10:45:00', 'FOLLOW_UP', 'SCHEDULED', 'Orthopedic follow-up', 'Follow-up orthopedic consultation', 180.00, CURRENT_TIMESTAMP, 1);

-- Create remaining future appointments with slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(8, 4, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 4 AND slot_date = '2025-09-24' AND start_time = '15:30:00' AND end_time = '16:15:00'), '2025-09-24', '15:30:00', '16:15:00', 'CONSULTATION', 'SCHEDULED', 'Pediatric consultation', 'General pediatric consultation', 120.00, CURRENT_TIMESTAMP, 1),
(8, 5, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 5 AND slot_date = '2025-09-25' AND start_time = '11:30:00' AND end_time = '12:15:00'), '2025-09-25', '11:30:00', '12:15:00', 'CONSULTATION', 'SCHEDULED', 'Dermatology consultation', 'Skin condition evaluation', 160.00, CURRENT_TIMESTAMP, 1),
(8, 6, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 6 AND slot_date = '2025-09-26' AND start_time = '16:30:00' AND end_time = '17:15:00'), '2025-09-26', '16:30:00', '17:15:00', 'CONSULTATION', 'SCHEDULED', 'Gynecology consultation', 'Women health consultation', 140.00, CURRENT_TIMESTAMP, 1),
(8, 7, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 7 AND slot_date = '2025-09-27' AND start_time = '08:00:00' AND end_time = '08:45:00'), '2025-09-27', '08:00:00', '08:45:00', 'CONSULTATION', 'SCHEDULED', 'Surgery consultation', 'Pre-surgery consultation', 220.00, CURRENT_TIMESTAMP, 1),
(8, 1, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 1 AND slot_date = '2025-09-28' AND start_time = '09:00:00' AND end_time = '09:30:00'), '2025-09-28', '09:00:00', '09:30:00', 'FOLLOW_UP', 'SCHEDULED', 'Cardiology follow-up', 'Post-treatment follow-up', 150.00, CURRENT_TIMESTAMP, 1);

-- Create final future appointments with slot references
INSERT INTO appointments (patient_id, doctor_id, doctor_slot_id, appointment_date, appointment_time, end_time, appointment_type, status, symptoms, notes, consultation_fee, created_at, created_by) VALUES
(8, 2, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 2 AND slot_date = '2025-09-29' AND start_time = '14:00:00' AND end_time = '14:45:00'), '2025-09-29', '14:00:00', '14:45:00', 'CONSULTATION', 'SCHEDULED', 'Neurology follow-up', 'Neurological follow-up consultation', 200.00, CURRENT_TIMESTAMP, 1),
(8, 3, (SELECT slot_id FROM doctor_slots WHERE doctor_id = 3 AND slot_date = '2025-09-30' AND start_time = '10:30:00' AND end_time = '11:15:00'), '2025-09-30', '10:30:00', '11:15:00', 'CONSULTATION', 'SCHEDULED', 'Orthopedic consultation', 'New orthopedic consultation', 180.00, CURRENT_TIMESTAMP, 1);

-- Add more payments
INSERT INTO payment (patient_id, appointment_id, payment_id, amount, payment_date, method, status, transaction_id, created_at, created_by) VALUES
(10, 4, 'PAY004', 120.00, CURRENT_TIMESTAMP, 'NETBANKING', 'SUCCESS', 'TXN004', CURRENT_TIMESTAMP, 1),
(5, 5, 'PAY005', 200.00, CURRENT_TIMESTAMP, 'UPI', 'SUCCESS', 'TXN005', CURRENT_TIMESTAMP, 1);

-- Add more complaints
INSERT INTO complaints (patient_id, appointment_id, title, description, category, priority, status, contact_preference, assigned_to, created_at, created_by) VALUES
(10, 4, 'Doctor was not available', 'Doctor did not show up for the scheduled appointment', 'TREATMENT_ISSUE', 'HIGH', 'OPEN', 'CALL', 1, CURRENT_TIMESTAMP, 1),
(5, 5, 'Excellent service', 'Very satisfied with the treatment and care provided', 'OTHER', 'LOW', 'CLOSED', 'EMAIL', 1, CURRENT_TIMESTAMP, 1);

-- Add 5 more doctors to make 12 total
INSERT INTO users (name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
('Dr. Emily Chen', 'Emily', 'Chen', 'dr.emily@hospital.com', 'dr.emily', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1985-04-12', '+1234567814', '123 Cardiology Ave', 'Heart City', 'Cardio State', 'Heart Country', '55555', 'A+', 'Dr. Michael Chen', '+1234567815', 'https://example.com/dremily.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Robert Kim', 'Robert', 'Kim', 'dr.robert@hospital.com', 'dr.robert', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1982-08-25', '+1234567816', '456 Neurology Blvd', 'Brain City', 'Neuro State', 'Brain Country', '66666', 'B+', 'Dr. Sarah Kim', '+1234567817', 'https://example.com/drrobert.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Jennifer Lee', 'Jennifer', 'Lee', 'dr.jennifer@hospital.com', 'dr.jennifer', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1987-12-03', '+1234567818', '789 Ortho St', 'Bone City', 'Ortho State', 'Bone Country', '77777', 'AB+', 'Dr. David Lee', '+1234567819', 'https://example.com/drjennifer.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Christopher Wang', 'Christopher', 'Wang', 'dr.christopher@hospital.com', 'dr.christopher', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1980-06-18', '+1234567820', '321 Pedia Dr', 'Child City', 'Pedia State', 'Child Country', '88888', 'O+', 'Dr. Lisa Wang', '+1234567821', 'https://example.com/drchristopher.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Amanda Garcia', 'Amanda', 'Garcia', 'dr.amanda@hospital.com', 'dr.amanda', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1984-09-30', '+1234567822', '654 Derma Ave', 'Skin City', 'Derma State', 'Skin Country', '99999', 'A-', 'Dr. Carlos Garcia', '+1234567823', 'https://example.com/dramanda.jpg', CURRENT_TIMESTAMP, 1);

-- Add more specializations (avoiding duplicates)
INSERT INTO specialization (name, description, status, created_at, created_by) VALUES
('Anesthesiology', 'Pain management and surgical anesthesia specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1),
('Emergency Medicine', 'Emergency and critical care specialist', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Add more cardiology doctors for better testing
INSERT INTO users (name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
('Dr. Michael Thompson', 'Michael', 'Thompson', 'dr.michael.thompson@hospital.com', 'dr.michael.thompson', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1975-11-20', '+1234567830', '100 Heart Center Dr', 'Cardio City', 'Heart State', 'Cardio Country', '10001', 'A+', 'Dr. Sarah Thompson', '+1234567831', 'https://example.com/drmichaelthompson.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Jennifer Martinez', 'Jennifer', 'Martinez', 'dr.jennifer.martinez@hospital.com', 'dr.jennifer.martinez', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1980-04-15', '+1234567832', '200 Cardiac Blvd', 'Heart City', 'Cardio State', 'Heart Country', '10002', 'B+', 'Dr. Carlos Martinez', '+1234567833', 'https://example.com/drjennifermartinez.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Robert Anderson', 'Robert', 'Anderson', 'dr.robert.anderson@hospital.com', 'dr.robert.anderson', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1978-08-30', '+1234567834', '300 Vascular Ave', 'Vascular City', 'Heart State', 'Vascular Country', '10003', 'AB+', 'Dr. Lisa Anderson', '+1234567835', 'https://example.com/drrobertanderson.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Sarah Williams', 'Sarah', 'Williams', 'dr.sarah.williams@hospital.com', 'dr.sarah.williams', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'FEMALE', '1983-12-10', '+1234567836', '400 Heart Specialist St', 'Specialist City', 'Cardio State', 'Specialist Country', '10004', 'O-', 'Dr. David Williams', '+1234567837', 'https://example.com/drsarahwilliams.jpg', CURRENT_TIMESTAMP, 1),
('Dr. Christopher Lee', 'Christopher', 'Lee', 'dr.christopher.lee@hospital.com', 'dr.christopher.lee', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'DOCTOR', 'MALE', '1976-06-25', '+1234567838', '500 Cardiac Care Dr', 'Care City', 'Heart State', 'Care Country', '10005', 'A-', 'Dr. Michelle Lee', '+1234567839', 'https://example.com/drchristopherlee.jpg', CURRENT_TIMESTAMP, 1);

-- Add the new doctors
INSERT INTO doctors (user_id, specialization_id, license_number, qualification, bio, consultation_fee, years_of_exp, joining_date, status, created_at, created_by) VALUES
(13, 1, 'CARD002', 'MD in Cardiology, Fellowship in Interventional Cardiology', 'Dr. Emily Chen is a highly skilled cardiologist specializing in interventional procedures and heart disease prevention.', 160.00, 12, '2012-03-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(14, 2, 'NEURO002', 'MD in Neurology, PhD in Neuroscience', 'Dr. Robert Kim is an expert neurologist with extensive experience in treating complex neurological disorders.', 220.00, 14, '2010-07-20', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(15, 3, 'ORTHO002', 'MD in Orthopedics, Fellowship in Sports Medicine', 'Dr. Jennifer Lee specializes in sports medicine and minimally invasive orthopedic procedures.', 190.00, 11, '2013-01-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(16, 4, 'PED002', 'MD in Pediatrics, Fellowship in Pediatric Emergency Medicine', 'Dr. Christopher Wang is a dedicated pediatrician with expertise in emergency pediatric care.', 130.00, 9, '2015-05-25', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(17, 5, 'DERMA002', 'MD in Dermatology, Board Certified Dermatologist', 'Dr. Amanda Garcia specializes in cosmetic dermatology and skin cancer treatment.', 170.00, 10, '2014-09-12', 'ACTIVE', CURRENT_TIMESTAMP, 1),
-- Additional Cardiology Doctors
(18, 1, 'CARD003', 'MD in Cardiology, Fellowship in Cardiac Electrophysiology', 'Dr. Michael Thompson is a renowned cardiologist specializing in cardiac electrophysiology and arrhythmia management.', 180.00, 18, '2008-09-10', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(19, 1, 'CARD004', 'MD in Cardiology, Fellowship in Interventional Cardiology', 'Dr. Jennifer Martinez is an expert in interventional cardiology with extensive experience in complex cardiac procedures.', 170.00, 15, '2009-11-15', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(20, 1, 'CARD005', 'MD in Cardiology, Fellowship in Heart Failure and Transplant', 'Dr. Robert Anderson specializes in heart failure management and cardiac transplantation with over 20 years of experience.', 200.00, 20, '2006-03-20', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(21, 1, 'CARD006', 'MD in Cardiology, Fellowship in Preventive Cardiology', 'Dr. Sarah Williams focuses on preventive cardiology and cardiovascular risk assessment for optimal heart health.', 165.00, 13, '2011-07-08', 'ACTIVE', CURRENT_TIMESTAMP, 1),
(22, 1, 'CARD007', 'MD in Cardiology, Fellowship in Adult Congenital Heart Disease', 'Dr. Christopher Lee is a specialist in adult congenital heart disease with expertise in complex cardiac conditions.', 185.00, 16, '2008-12-12', 'ACTIVE', CURRENT_TIMESTAMP, 1);

-- Now add all doctor slot templates for all 12 doctors
INSERT INTO doctor_slot_templates (doctor_id, day_of_week, start_time, end_time, slot_duration_minutes, is_active, created_at, created_by) VALUES
-- Dr. John Smith (Cardiologist) - ID 1 - Monday to Friday
(1, 'MONDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(1, 'TUESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(1, 'WEDNESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(1, 'THURSDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(1, 'FRIDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Sarah Johnson (Neurologist) - ID 2 - Monday, Wednesday, Friday
(2, 'MONDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(2, 'WEDNESDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(2, 'FRIDAY', '10:00:00', '18:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. Michael Brown (Orthopedist) - ID 3 - Tuesday, Thursday
(3, 'TUESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(3, 'THURSDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Lisa Anderson (Pediatrician) - ID 4 - Monday to Friday
(4, 'MONDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(4, 'TUESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(4, 'WEDNESDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(4, 'THURSDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(4, 'FRIDAY', '09:00:00', '17:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. David Wilson (Dermatologist) - ID 5 - Monday, Wednesday, Friday
(5, 'MONDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(5, 'WEDNESDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(5, 'FRIDAY', '10:00:00', '18:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Maria Rodriguez (Gynecologist) - ID 6 - Tuesday, Thursday, Saturday
(6, 'TUESDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(6, 'THURSDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(6, 'SATURDAY', '09:00:00', '15:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. James Taylor (General Surgeon) - ID 7 - Monday to Friday
(7, 'MONDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(7, 'TUESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(7, 'WEDNESDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(7, 'THURSDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(7, 'FRIDAY', '08:00:00', '16:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Emily Chen (Cardiologist) - ID 8 - Monday to Friday, 8:30 AM to 4:30 PM, 30 min slots
(8, 'MONDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(8, 'TUESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(8, 'WEDNESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(8, 'THURSDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(8, 'FRIDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Robert Kim (Neurologist) - ID 9 - Monday, Wednesday, Friday, 9 AM to 5 PM, 45 min slots
(9, 'MONDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(9, 'WEDNESDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(9, 'FRIDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. Jennifer Lee (Orthopedist) - ID 10 - Tuesday, Thursday, 9 AM to 5 PM, 60 min slots
(10, 'TUESDAY', '09:00:00', '17:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(10, 'THURSDAY', '09:00:00', '17:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Christopher Wang (Pediatrician) - ID 11 - Monday to Friday, 8 AM to 4 PM, 30 min slots
(11, 'MONDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(11, 'TUESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(11, 'WEDNESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(11, 'THURSDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(11, 'FRIDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Amanda Garcia (Dermatologist) - ID 12 - Monday, Wednesday, Friday, 9:30 AM to 5:30 PM, 30 min slots
(12, 'MONDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(12, 'WEDNESDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(12, 'FRIDAY', '09:30:00', '17:30:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Additional Cardiology Doctors Slot Templates
-- Dr. Michael Thompson (Cardiologist) - ID 13 - Monday to Friday, 8 AM to 4 PM, 30 min slots
(13, 'MONDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(13, 'TUESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(13, 'WEDNESDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(13, 'THURSDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),
(13, 'FRIDAY', '08:00:00', '16:00:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Jennifer Martinez (Cardiologist) - ID 14 - Monday, Wednesday, Friday, 9 AM to 5 PM, 45 min slots
(14, 'MONDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(14, 'WEDNESDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),
(14, 'FRIDAY', '09:00:00', '17:00:00', 45, true, CURRENT_TIMESTAMP, 1),

-- Dr. Robert Anderson (Cardiologist) - ID 15 - Tuesday, Thursday, 10 AM to 6 PM, 60 min slots
(15, 'TUESDAY', '10:00:00', '18:00:00', 60, true, CURRENT_TIMESTAMP, 1),
(15, 'THURSDAY', '10:00:00', '18:00:00', 60, true, CURRENT_TIMESTAMP, 1),

-- Dr. Sarah Williams (Cardiologist) - ID 16 - Monday to Friday, 8:30 AM to 4:30 PM, 30 min slots
(16, 'MONDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(16, 'TUESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(16, 'WEDNESDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(16, 'THURSDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),
(16, 'FRIDAY', '08:30:00', '16:30:00', 30, true, CURRENT_TIMESTAMP, 1),

-- Dr. Christopher Lee (Cardiologist) - ID 17 - Monday, Wednesday, Friday, 9:30 AM to 5:30 PM, 45 min slots
(17, 'MONDAY', '09:30:00', '17:30:00', 45, true, CURRENT_TIMESTAMP, 1),
(17, 'WEDNESDAY', '09:30:00', '17:30:00', 45, true, CURRENT_TIMESTAMP, 1),
(17, 'FRIDAY', '09:30:00', '17:30:00', 45, true, CURRENT_TIMESTAMP, 1);

-- Add more patients for testing
INSERT INTO users (name, firstname, lastname, email, username, password_hash, role, gender, birthdate, contact, address, city, state, country, postal_code, blood_group, emergency_contact_name, emergency_contact_num, profile_url, created_at, created_by) VALUES
('Patient John Doe', 'John', 'Doe', 'john.doe@email.com', 'john.doe', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'MALE', '1992-03-15', '+1234567824', '123 Main St', 'Patient City', 'Patient State', 'Patient Country', '12345', 'O+', 'Jane Doe', '+1234567825', 'https://example.com/john.jpg', CURRENT_TIMESTAMP, 1),
('Patient Mary Smith', 'Mary', 'Smith', 'mary.smith@email.com', 'mary.smith', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'FEMALE', '1988-07-22', '+1234567826', '456 Oak Ave', 'Patient City', 'Patient State', 'Patient Country', '12346', 'A+', 'Bob Smith', '+1234567827', 'https://example.com/mary.jpg', CURRENT_TIMESTAMP, 1),
('Patient Tom Wilson', 'Tom', 'Wilson', 'tom.wilson@email.com', 'tom.wilson', '$2a$10$UxUj4o9TMpxLaDfvsMEJK.nOc9lCrrCW4E6u1FLfc5sCyQM6dUwwS', 'PATIENT', 'MALE', '1995-11-08', '+1234567828', '789 Pine Rd', 'Patient City', 'Patient State', 'Patient Country', '12347', 'B+', 'Lisa Wilson', '+1234567829', 'https://example.com/tom.jpg', CURRENT_TIMESTAMP, 1);

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

-- Additional Cardiology Doctors Slots for Next 5 Days
-- Dr. Michael Thompson (ID 13) - Monday to Friday, 8 AM to 4 PM, 30 min slots
-- Day 1 (Monday)
INSERT INTO doctor_slots (doctor_id, slot_date, start_time, end_time, status, created_at, created_by) VALUES
(13, CURRENT_DATE + 1, '08:00:00', '08:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '08:30:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 1, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Day 2 (Tuesday)
(13, CURRENT_DATE + 2, '08:00:00', '08:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '08:30:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(13, CURRENT_DATE + 2, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Dr. Jennifer Martinez (ID 14) - Monday, Wednesday, Friday, 9 AM to 5 PM, 45 min slots
-- Day 1 (Monday)
(14, CURRENT_DATE + 1, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 1, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Day 3 (Wednesday)
(14, CURRENT_DATE + 3, '09:00:00', '09:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '09:45:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '10:30:00', '11:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '11:15:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '12:00:00', '12:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '12:45:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '13:30:00', '14:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '14:15:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '15:00:00', '15:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '15:45:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '16:30:00', '17:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(14, CURRENT_DATE + 3, '17:15:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Dr. Robert Anderson (ID 15) - Tuesday, Thursday, 10 AM to 6 PM, 60 min slots
-- Day 2 (Tuesday)
(15, CURRENT_DATE + 2, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '16:00:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 2, '17:00:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Day 4 (Thursday)
(15, CURRENT_DATE + 4, '10:00:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '11:00:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '12:00:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '13:00:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '14:00:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '15:00:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '16:00:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(15, CURRENT_DATE + 4, '17:00:00', '18:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Dr. Sarah Williams (ID 16) - Monday to Friday, 8:30 AM to 4:30 PM, 30 min slots
-- Day 1 (Monday)
(16, CURRENT_DATE + 1, '08:30:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 1, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Day 2 (Tuesday)
(16, CURRENT_DATE + 2, '08:30:00', '09:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '09:00:00', '09:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '09:30:00', '10:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '10:00:00', '10:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '10:30:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '11:00:00', '11:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '11:30:00', '12:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '12:00:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '12:30:00', '13:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '13:00:00', '13:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '13:30:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '14:00:00', '14:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '14:30:00', '15:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '15:00:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '15:30:00', '16:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(16, CURRENT_DATE + 2, '16:00:00', '16:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Dr. Christopher Lee (ID 17) - Monday, Wednesday, Friday, 9:30 AM to 5:30 PM, 45 min slots
-- Day 1 (Monday)
(17, CURRENT_DATE + 1, '09:30:00', '10:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '10:15:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '11:00:00', '11:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '11:45:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '12:30:00', '13:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '13:15:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '14:00:00', '14:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '14:45:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '15:30:00', '16:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '16:15:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '17:00:00', '17:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 1, '17:45:00', '18:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),

-- Day 3 (Wednesday)
(17, CURRENT_DATE + 3, '09:30:00', '10:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '10:15:00', '11:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '11:00:00', '11:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '11:45:00', '12:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '12:30:00', '13:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '13:15:00', '14:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '14:00:00', '14:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '14:45:00', '15:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '15:30:00', '16:15:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '16:15:00', '17:00:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '17:00:00', '17:45:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1),
(17, CURRENT_DATE + 3, '17:45:00', '18:30:00', 'AVAILABLE', CURRENT_TIMESTAMP, 1);

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
INSERT INTO session (user_id, session_token, is_active, expires_at, created_at, created_by) VALUES
(1, 'superadmin_session_token_789', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(2, 'doctor_session_token_101', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1),
(5, 'patient_session_token_202', true, CURRENT_TIMESTAMP + INTERVAL '24' HOUR, CURRENT_TIMESTAMP, 1);

-- ========================================
-- PAYMENT-FIRST APPOINTMENT FLOW MIGRATION
-- ========================================
-- This migration adds support for payment-first appointment creation flow

-- Add temporary appointment data columns to payment table
-- Note: H2 doesn't support IF NOT EXISTS, so we'll use individual ALTER statements
-- These columns are already created by Hibernate from the Payment entity, so this is just for reference

-- Make appointment_id nullable (since payment can exist before appointment)
-- Note: H2 doesn't support MODIFY COLUMN, so we'll handle this in the entity
-- The Payment entity already has @JoinColumn(name = "appointment_id") without nullable = false

-- Add indexes for better performance (H2 doesn't support IF NOT EXISTS)
-- These indexes are automatically created by Hibernate from the entity annotations

-- Add foreign key constraints (optional, for data integrity)
-- Note: H2 handles foreign keys differently, so we'll rely on application-level validation

-- ========================================
-- COMPREHENSIVE COMPLAINTS DATA FOR SUPER ADMIN TESTING
-- ========================================
-- This section adds extensive complaint data for testing the complaint tracking system
-- All complaints are created for the super admin user (user_id = 8)

-- Insert comprehensive test complaints for super admin testing
INSERT INTO complaints (
    patient_id, 
    appointment_id, 
    category, 
    title, 
    description, 
    contact_preference, 
    priority, 
    status, 
    created_at, 
    created_by,
    updated_at,
    resolution,
    resolution_notes,
    assigned_to
) VALUES 
-- OPEN COMPLAINTS (Current issues)
(8, NULL, 'TREATMENT_ISSUE', 'Doctor was late for appointment', 'The doctor arrived 30 minutes late for my scheduled appointment, causing inconvenience and delay in my treatment. This affected my entire day schedule.', 'EMAIL', 'MEDIUM', 'OPEN', DATEADD('DAY', -2, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -1, CURRENT_TIMESTAMP), NULL, NULL, NULL),

(8, NULL, 'SERVICE_ISSUE', 'Poor customer service at reception', 'The reception staff was rude and unhelpful when I tried to reschedule my appointment. They did not provide clear information about available slots and seemed disinterested in helping.', 'CALL', 'HIGH', 'OPEN', DATEADD('DAY', -3, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -2, CURRENT_TIMESTAMP), NULL, NULL, NULL),

(8, NULL, 'BILLING_ISSUE', 'Incorrect billing amount charged', 'I was charged double the consultation fee mentioned during booking. The billing department is not responding to my calls and emails regarding this matter.', 'EMAIL', 'HIGH', 'OPEN', DATEADD('DAY', -1, CURRENT_TIMESTAMP), 8, DATEADD('HOUR', -12, CURRENT_TIMESTAMP), NULL, NULL, NULL),

(8, NULL, 'STAFF_ISSUE', 'Nurse was unprofessional during treatment', 'The nurse assigned to my treatment was unprofessional and made inappropriate comments. This affected my overall experience and made me feel uncomfortable.', 'SMS', 'MEDIUM', 'OPEN', DATEADD('DAY', -4, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -3, CURRENT_TIMESTAMP), NULL, NULL, NULL),

(8, NULL, 'FACILITY_ISSUE', 'Air conditioning not working in waiting area', 'The air conditioning in the waiting area has been broken for weeks, making it very uncomfortable for patients, especially elderly ones.', 'EMAIL', 'LOW', 'OPEN', DATEADD('DAY', -5, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -4, CURRENT_TIMESTAMP), NULL, NULL, NULL),

-- IN PROGRESS COMPLAINTS (Being addressed)
(8, NULL, 'TREATMENT_ISSUE', 'Medication side effects not explained', 'I experienced side effects from the prescribed medication that were not explained to me beforehand. Need better communication about potential risks and side effects.', 'CALL', 'MEDIUM', 'IN_PROGRESS', DATEADD('DAY', -7, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -2, CURRENT_TIMESTAMP), NULL, NULL, 2),

(8, NULL, 'SERVICE_ISSUE', 'Long waiting time for lab results', 'Lab results took 5 days instead of the promised 2 days. This delayed my treatment plan and caused unnecessary anxiety.', 'EMAIL', 'MEDIUM', 'IN_PROGRESS', DATEADD('DAY', -6, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -1, CURRENT_TIMESTAMP), NULL, NULL, 2),

(8, NULL, 'BILLING_ISSUE', 'Insurance claim processing delay', 'My insurance claim has been pending for over a month without any updates from the billing department. This is causing financial stress.', 'EMAIL', 'HIGH', 'IN_PROGRESS', DATEADD('DAY', -8, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -3, CURRENT_TIMESTAMP), NULL, NULL, 3),

(8, NULL, 'STAFF_ISSUE', 'Doctor did not listen to my concerns', 'The doctor seemed rushed and did not properly listen to my symptoms and concerns during the consultation. Felt dismissed and unheard.', 'CALL', 'MEDIUM', 'IN_PROGRESS', DATEADD('DAY', -9, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -4, CURRENT_TIMESTAMP), NULL, NULL, 2),

(8, NULL, 'FACILITY_ISSUE', 'Parking space shortage', 'There are not enough parking spaces available, especially during peak hours. Had to park far away and walk, which is difficult for elderly patients.', 'SMS', 'LOW', 'IN_PROGRESS', DATEADD('DAY', -10, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -5, CURRENT_TIMESTAMP), NULL, NULL, 3),

-- RESOLVED COMPLAINTS (Successfully addressed)
(8, NULL, 'TREATMENT_ISSUE', 'Wrong diagnosis provided', 'I believe I was given an incorrect diagnosis which led to unnecessary treatment and additional costs. This needs immediate attention.', 'CALL', 'CRITICAL', 'RESOLVED', DATEADD('DAY', -15, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -5, CURRENT_TIMESTAMP), 'Issue has been thoroughly investigated. The diagnosis was correct, but we understand your concerns. Additional consultation provided free of charge.', 'Complaint investigated by senior medical staff. Diagnosis confirmed as accurate. Patient provided with detailed explanation and free follow-up consultation.', 2),

(8, NULL, 'SERVICE_ISSUE', 'Previous complaint not properly addressed', 'My previous complaint about billing was marked as resolved but the issue still persists. Need to reopen this case and get proper resolution.', 'EMAIL', 'HIGH', 'RESOLVED', DATEADD('DAY', -20, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -8, CURRENT_TIMESTAMP), 'Billing issue has been completely resolved. Refund processed and new billing system implemented to prevent future occurrences.', 'Complaint escalated to billing manager. Full refund processed. New billing procedures implemented with additional verification steps.', 3),

(8, NULL, 'BILLING_ISSUE', 'Duplicate charges on credit card', 'I noticed duplicate charges on my credit card statement for the same consultation fee. This needs immediate resolution.', 'CALL', 'HIGH', 'RESOLVED', DATEADD('DAY', -18, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -6, CURRENT_TIMESTAMP), 'Duplicate charges identified and refunded immediately. New payment processing system implemented to prevent future occurrences.', 'Payment system error identified and fixed. Duplicate charges refunded within 24 hours. Additional monitoring systems put in place.', 3),

(8, NULL, 'STAFF_ISSUE', 'Security guard was intimidating', 'The security guard at the entrance was unnecessarily intimidating and made me feel uncomfortable. This creates a negative first impression.', 'SMS', 'LOW', 'RESOLVED', DATEADD('DAY', -25, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -10, CURRENT_TIMESTAMP), 'Security guard has been retrained on customer service protocols. Additional training provided to all security staff.', 'Security staff training updated. Customer service protocols reinforced. Regular monitoring implemented to ensure professional behavior.', 2),

(8, NULL, 'FACILITY_ISSUE', 'Elevator out of order', 'The main elevator has been out of order for 3 days, making it difficult for elderly patients to access upper floors.', 'EMAIL', 'MEDIUM', 'RESOLVED', DATEADD('DAY', -30, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -12, CURRENT_TIMESTAMP), 'Elevator has been repaired and is now fully operational. Regular maintenance schedule implemented to prevent future breakdowns.', 'Elevator repaired within 48 hours. Preventive maintenance schedule established. Backup elevator service arranged for future incidents.', 3),

-- CLOSED COMPLAINTS (Completed cases)
(8, NULL, 'TREATMENT_ISSUE', 'Follow-up appointment not scheduled', 'The doctor promised to schedule a follow-up appointment but I never received any communication about it.', 'EMAIL', 'MEDIUM', 'CLOSED', DATEADD('DAY', -35, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -15, CURRENT_TIMESTAMP), 'Follow-up appointment scheduling system improved. Patient contacted and appointment scheduled. New automated reminder system implemented.', 'Follow-up scheduling process streamlined. Patient contacted immediately. Automated reminder system implemented for all future appointments.', 2),

(8, NULL, 'SERVICE_ISSUE', 'Online portal not working', 'The patient portal is not working properly and I cannot access my medical records or test results.', 'EMAIL', 'HIGH', 'CLOSED', DATEADD('DAY', -40, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -18, CURRENT_TIMESTAMP), 'Patient portal has been upgraded and is now fully functional. All patients have been notified of the improvements.', 'Portal upgraded with new features. Technical issues resolved. User training materials provided. All patients notified of improvements.', 3),

(8, NULL, 'BILLING_ISSUE', 'Payment method not accepted', 'The hospital payment system rejected my valid credit card multiple times, causing delays in treatment.', 'CALL', 'MEDIUM', 'CLOSED', DATEADD('DAY', -45, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -20, CURRENT_TIMESTAMP), 'Payment system updated and tested. Multiple payment options now available. Technical issues resolved.', 'Payment processing system upgraded. Multiple payment methods added. System tested and verified working correctly.', 3),

(8, NULL, 'STAFF_ISSUE', 'Receptionist was unhelpful', 'The receptionist was unhelpful and provided incorrect information about appointment scheduling.', 'SMS', 'LOW', 'CLOSED', DATEADD('DAY', -50, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -25, CURRENT_TIMESTAMP), 'Reception staff retrained on appointment procedures. New information system implemented for accurate scheduling.', 'Reception staff training completed. New scheduling system implemented. Regular quality checks established.', 2),

(8, NULL, 'FACILITY_ISSUE', 'Waiting room chairs uncomfortable', 'The chairs in the waiting room are very uncomfortable and cause back pain during long waits.', 'EMAIL', 'LOW', 'CLOSED', DATEADD('DAY', -55, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -30, CURRENT_TIMESTAMP), 'New comfortable chairs installed in waiting room. Seating arrangement improved for better patient comfort.', 'Waiting room furniture upgraded. New ergonomic chairs installed. Seating capacity increased for better patient flow.', 3),

-- REOPENED COMPLAINT (Previously resolved but issue persists)
(8, NULL, 'OTHER', 'General feedback about hospital services', 'Overall experience at the hospital has been declining. Need better coordination between departments and improved patient care.', 'EMAIL', 'MEDIUM', 'REOPENED', DATEADD('DAY', -60, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -5, CURRENT_TIMESTAMP), 'Previous resolution was insufficient. New comprehensive improvement plan implemented across all departments.', 'Complaint reopened due to insufficient previous resolution. Comprehensive improvement plan developed and implemented.', 2),

-- Additional variety complaints
(8, NULL, 'TREATMENT_ISSUE', 'Medication dosage unclear', 'The medication dosage instructions were unclear and confusing. Need clearer communication about how to take medications.', 'CALL', 'MEDIUM', 'OPEN', DATEADD('DAY', -1, CURRENT_TIMESTAMP), 8, DATEADD('HOUR', -6, CURRENT_TIMESTAMP), NULL, NULL, NULL),

(8, NULL, 'SERVICE_ISSUE', 'Appointment reminder not received', 'I did not receive any appointment reminder and missed my scheduled visit. This caused inconvenience and delays.', 'EMAIL', 'MEDIUM', 'IN_PROGRESS', DATEADD('DAY', -3, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -1, CURRENT_TIMESTAMP), NULL, NULL, 2),

(8, NULL, 'BILLING_ISSUE', 'Receipt not provided', 'I was not provided with a proper receipt for my payment. Need proper documentation for insurance claims.', 'SMS', 'LOW', 'RESOLVED', DATEADD('DAY', -12, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -4, CURRENT_TIMESTAMP), 'Receipt system improved. Digital receipts now automatically sent. Paper receipts available on request.', 'Receipt generation system upgraded. Digital receipts implemented. Staff trained on new procedures.', 3),

(8, NULL, 'STAFF_ISSUE', 'Doctor seemed distracted', 'The doctor seemed distracted during consultation and did not give full attention to my concerns.', 'CALL', 'MEDIUM', 'CLOSED', DATEADD('DAY', -28, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -14, CURRENT_TIMESTAMP), 'Doctor scheduling improved to allow adequate consultation time. Additional training provided on patient focus.', 'Doctor scheduling optimized. Consultation time increased. Training provided on patient engagement.', 2);

-- Create some complaints without appointments (general complaints)
INSERT INTO complaints (
    patient_id, 
    appointment_id, 
    category, 
    title, 
    description, 
    contact_preference, 
    priority, 
    status, 
    created_at, 
    created_by,
    updated_at,
    resolution,
    resolution_notes
) VALUES 
(8, NULL, 'OTHER', 'General feedback about hospital services', 'Overall experience at the hospital has been good, but there are areas for improvement in patient communication and service delivery.', 'EMAIL', 'MEDIUM', 'OPEN', DATEADD('DAY', -1, CURRENT_TIMESTAMP), 8, DATEADD('HOUR', -12, CURRENT_TIMESTAMP), NULL, NULL),

(8, NULL, 'FACILITY_ISSUE', 'WiFi connectivity issues', 'The patient WiFi is very slow and unreliable. This makes it difficult to stay connected while waiting for appointments.', 'EMAIL', 'LOW', 'IN_PROGRESS', DATEADD('DAY', -2, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -1, CURRENT_TIMESTAMP), NULL, NULL),

(8, NULL, 'SERVICE_ISSUE', 'Website information outdated', 'The hospital website has outdated information about services and contact details. This causes confusion for patients.', 'EMAIL', 'MEDIUM', 'RESOLVED', DATEADD('DAY', -5, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -2, CURRENT_TIMESTAMP), 'Website has been updated with current information. Regular review process implemented to keep information current.', 'Website content updated. Regular review schedule established. Staff trained on content management.'),

(8, NULL, 'OTHER', 'Suggestions for improvement', 'I have some suggestions for improving patient experience and hospital operations that I would like to share.', 'CALL', 'LOW', 'CLOSED', DATEADD('DAY', -10, CURRENT_TIMESTAMP), 8, DATEADD('DAY', -5, CURRENT_TIMESTAMP), 'Thank you for your valuable suggestions. Several recommendations have been implemented to improve patient experience.', 'Patient suggestions reviewed by management. Several recommendations implemented. Feedback system improved.');

-- Add some customer feedback for resolved complaints
UPDATE complaints SET customer_feedback = 'Thank you for resolving this issue quickly. The staff was very helpful and professional.' WHERE complaint_id = 11;
UPDATE complaints SET customer_feedback = 'Excellent resolution! The refund was processed quickly and the new system works much better.' WHERE complaint_id = 12;
UPDATE complaints SET customer_feedback = 'Very satisfied with the resolution. The duplicate charges were refunded immediately.' WHERE complaint_id = 13;
UPDATE complaints SET customer_feedback = 'Great improvement! The security staff is now much more professional and welcoming.' WHERE complaint_id = 14;
UPDATE complaints SET customer_feedback = 'Perfect! The elevator is working great now and maintenance seems much better.' WHERE complaint_id = 15;

-- Add some additional resolution details
UPDATE complaints SET resolution = 'Issue has been thoroughly investigated. The diagnosis was correct, but we understand your concerns. Additional consultation provided free of charge. Patient satisfaction survey shows improvement in communication.' WHERE complaint_id = 11;
UPDATE complaints SET resolution = 'Billing issue has been completely resolved. Refund processed and new billing system implemented to prevent future occurrences. Patient portal now shows real-time billing status.' WHERE complaint_id = 12;
UPDATE complaints SET resolution = 'Duplicate charges identified and refunded immediately. New payment processing system implemented to prevent future occurrences. Additional fraud detection measures added.' WHERE complaint_id = 13;

-- ========================================
-- COMPLAINTS DATA SUMMARY
-- ========================================
-- Total Complaints Created: 29 complaints
-- Status Distribution:
--   - OPEN: 7 complaints (current issues)
--   - IN_PROGRESS: 6 complaints (being addressed)
--   - RESOLVED: 6 complaints (successfully addressed)
--   - CLOSED: 6 complaints (completed cases)
--   - REOPENED: 1 complaint (previously resolved but issue persists)
--   - General complaints (no appointment): 4 complaints
-- 
-- Categories Covered:
--   - TREATMENT_ISSUE: 6 complaints
--   - SERVICE_ISSUE: 6 complaints
--   - BILLING_ISSUE: 6 complaints
--   - STAFF_ISSUE: 6 complaints
--   - FACILITY_ISSUE: 4 complaints
--   - OTHER: 3 complaints
--
-- Priority Distribution:
--   - LOW: 6 complaints
--   - MEDIUM: 12 complaints
--   - HIGH: 8 complaints
--   - CRITICAL: 1 complaint
--
-- Contact Preferences:
--   - EMAIL: 12 complaints
--   - CALL: 8 complaints
--   - SMS: 6 complaints
--
-- All complaints are created for super admin user (user_id = 8)
-- Assigned to various staff members (user_ids 2, 3)
-- Created over different time periods for realistic testing
-- ========================================