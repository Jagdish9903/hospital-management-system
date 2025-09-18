import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

export interface User {
  id: number;
  name: string;
  email: string;
  username: string;
  role: string;
  gender: string;
  contact?: string;
  address?: string;
  city?: string;
  state?: string;
  country?: string;
  postalCode?: string;
  bloodGroup?: string;
  emergencyContactName?: string;
  emergencyContactNum?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Doctor {
  doctorId: number;
  user: User;
  specialization: {
    id: number;
    name: string;
  };
  licenseNumber: string;
  experience: number;
  consultationFee: number;
  isActive: boolean;
  qualification?: string;
  bio?: string;
  yearsOfExp?: number;
  status?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Appointment {
  id: number;
  patient: User;
  doctor: Doctor;
  appointmentDate: string;
  appointmentTime: string;
  status: string;
  reason: string;
  notes?: string;
  appointmentType?: string;
  symptoms?: string;
  consultationFee?: number;
  createdAt: string;
  updatedAt: string;
}

export interface Complaint {
  complaintId: number;
  user?: User;
  title: string;
  description: string;
  category: string;
  status: string;
  priority: string;
  response?: string;
  patient?: User;
  assignedTo?: User;
  resolutionNotes?: string;
  resolution?: string;
  notes?: ComplaintNote[];
  createdAt: string;
  updatedAt: string;
}

export interface ComplaintNote {
  id: number;
  content: string;
  createdAt: string;
  createdBy?: User;
}

export interface DoctorSlot {
  slotId: number;
  doctor: Doctor;
  slotDate: string;
  startTime: string;
  endTime: string;
  status: string;
}

export interface Specialization {
  specializationId: number;
  name: string;
  description: string;
  status: string;
}

export interface AuditLog {
  id: number;
  user?: User;
  action: string;
  tableName: string;
  recordId?: number;
  oldValues?: string;
  newValues?: string;
  ipAddress?: string;
  userAgent?: string;
  createdAt: string;
}

export interface SearchFilters {
  page: number;
  size: number;
  sortBy?: string;
  sortDir?: 'asc' | 'desc';
  name?: string;
  email?: string;
  role?: string;
  gender?: string;
  status?: string;
  patientName?: string;
  doctorName?: string;
  title?: string;
  action?: string;
  specialization?: string;
  appointmentType?: string;
  dateFrom?: string;
  dateTo?: string;
  tableName?: string;
  description?: string;
  userId?: string;
  category?: string;
  priority?: string;
  fromDate?: string;
  toDate?: string;
}

export interface PaginatedResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
  numberOfElements: number;
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) { }

  // User stats
  getUserStats(): Promise<any> {
    return this.http.get(`${this.apiUrl}/api/admin/users/stats`).toPromise();
  }

  // Appointment stats
  getAppointmentStats(): Promise<any> {
    return this.http.get(`${this.apiUrl}/api/admin/appointments/stats`).toPromise();
  }

  // Complaint stats
  getComplaintStats(): Promise<any> {
    return this.http.get(`${this.apiUrl}/api/admin/complaints/stats`).toPromise();
  }

  // Recent audit logs
  getRecentAuditLogs(): Promise<any> {
    return this.http.get(`${this.apiUrl}/api/admin/audit-logs/recent`).toPromise();
  }

  // Users management
  getUsers(filters: SearchFilters): Observable<ApiResponse<PaginatedResponse<User>>> {
    let params: any = { 
      page: filters.page, 
      size: filters.size 
    };
    if (filters.sortBy) params.sortBy = filters.sortBy;
    if (filters.sortDir) params.sortDir = filters.sortDir;
    if (filters.name) params.name = filters.name;
    if (filters.email) params.email = filters.email;
    if (filters.role) params.role = filters.role;
    if (filters.gender) params.gender = filters.gender;
    
    return this.http.get<ApiResponse<PaginatedResponse<User>>>(`${this.apiUrl}/api/admin/users`, { params });
  }

  updateUser(id: number, userData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/users/${id}`, userData);
  }

  deleteUser(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/api/admin/users/${id}`);
  }

  // Doctors management
  getDoctors(filters: SearchFilters): Observable<ApiResponse<PaginatedResponse<Doctor>>> {
    let params: any = { 
      page: filters.page, 
      size: filters.size 
    };
    if (filters.sortBy) params.sortBy = filters.sortBy;
    if (filters.sortDir) params.sortDir = filters.sortDir;
    if (filters.name) params.name = filters.name;
    if (filters.email) params.email = filters.email;
    if (filters.specialization) params.specialization = filters.specialization;
    if (filters.status) params.status = filters.status;
    
    return this.http.get<ApiResponse<PaginatedResponse<Doctor>>>(`${this.apiUrl}/api/admin/doctors`, { params });
  }

  updateDoctor(id: number, doctorData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/doctors/${id}`, doctorData);
  }

  deleteDoctor(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/api/admin/doctors/${id}`);
  }

  // Appointments management
  getAppointments(filters: SearchFilters): Observable<ApiResponse<PaginatedResponse<Appointment>>> {
    let params: any = { 
      page: filters.page, 
      size: filters.size 
    };
    if (filters.sortBy) params.sortBy = filters.sortBy;
    if (filters.sortDir) params.sortDir = filters.sortDir;
    if (filters.patientName) params.patientName = filters.patientName;
    if (filters.doctorName) params.doctorName = filters.doctorName;
    if (filters.status) params.status = filters.status;
    if (filters.appointmentType) params.appointmentType = filters.appointmentType;
    if (filters.dateFrom) params.dateFrom = filters.dateFrom;
    if (filters.dateTo) params.dateTo = filters.dateTo;
    
    return this.http.get<ApiResponse<PaginatedResponse<Appointment>>>(`${this.apiUrl}/api/admin/appointments`, { params });
  }

  updateAppointment(id: number, appointmentData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/appointments/${id}`, appointmentData);
  }

  deleteAppointment(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/api/admin/appointments/${id}`);
  }

  // Complaints management
  getComplaints(filters: SearchFilters): Observable<ApiResponse<PaginatedResponse<Complaint>>> {
    let params: any = { 
      page: filters.page, 
      size: filters.size 
    };
    if (filters.sortBy) params.sortBy = filters.sortBy;
    if (filters.sortDir) params.sortDir = filters.sortDir;
    if (filters.title) params.title = filters.title;
    if (filters.category) params.category = filters.category;
    if (filters.status) params.status = filters.status;
    if (filters.priority) params.priority = filters.priority;
    
    return this.http.get<ApiResponse<PaginatedResponse<Complaint>>>(`${this.apiUrl}/api/admin/complaints`, { params });
  }

  updateComplaint(id: number, complaintData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/complaints/${id}`, complaintData);
  }

  deleteComplaint(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/api/admin/complaints/${id}`);
  }

  // Audit logs management
  getAuditLogs(filters: SearchFilters): Observable<ApiResponse<PaginatedResponse<AuditLog>>> {
    let params: any = { 
      page: filters.page, 
      size: filters.size 
    };
    if (filters.sortBy) params.sortBy = filters.sortBy;
    if (filters.sortDir) params.sortDir = filters.sortDir;
    if (filters.action) params.action = filters.action;
    if (filters.tableName) params.tableName = filters.tableName;
    if (filters.userId) params.userId = filters.userId;
    if (filters.fromDate) params.fromDate = filters.fromDate;
    if (filters.toDate) params.toDate = filters.toDate;
    
    return this.http.get<ApiResponse<PaginatedResponse<AuditLog>>>(`${this.apiUrl}/api/admin/audit-logs`, { params });
  }

  // Additional methods
  updateComplaintStatus(id: number, status: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/complaints/${id}/status`, { status });
  }

  // Doctor creation
  getPatients(): Observable<ApiResponse<User[]>> {
    return this.http.get<ApiResponse<User[]>>(`${this.apiUrl}/api/admin/users/patients`);
  }

  getSpecializations(): Observable<ApiResponse<any[]>> {
    return this.http.get<ApiResponse<any[]>>(`${this.apiUrl}/api/admin/doctors/specializations`);
  }

  createDoctor(doctorData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/api/admin/doctors`, doctorData);
  }

  // Complaint details
  getComplaintById(id: number): Observable<ApiResponse<Complaint>> {
    return this.http.get<ApiResponse<Complaint>>(`${this.apiUrl}/api/admin/complaints/${id}`);
  }

  getAdmins(): Observable<ApiResponse<User[]>> {
    return this.http.get<ApiResponse<User[]>>(`${this.apiUrl}/api/admin/users/admins`);
  }

  assignComplaint(complaintId: number, adminId: number): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/complaints/${complaintId}/assign`, { adminId });
  }

  updateComplaintResolution(complaintId: number, resolutionData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/admin/complaints/${complaintId}/resolution`, resolutionData);
  }

  addComplaintNote(complaintId: number, note: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/api/admin/complaints/${complaintId}/notes`, { note });
  }

  // Appointment Scheduling Methods
  getAppointmentSpecializations(): Observable<any> {
    return this.http.get(`${this.apiUrl}/api/appointments/specializations`);
  }

  getAvailableSlots(specializationId: number, date: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/api/appointments/available-slots?specializationId=${specializationId}&date=${date}`);
  }

  getDoctorSlots(doctorId: number, date: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/api/appointments/doctors/${doctorId}/slots?date=${date}`);
  }

  bookAppointment(bookingData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/api/appointments`, bookingData);
  }

  generateSlots(): Observable<any> {
    return this.http.post(`${this.apiUrl}/api/appointments/generate-slots`, {});
  }
}