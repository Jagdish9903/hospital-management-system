import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../../core/services/auth.service';
import { AdminService, Specialization, DoctorSlot } from '../../../core/services/admin.service';
import { User } from '../../../core/models/user.model';
import { ToastService, ToastAction } from '../../../core/services/toast.service';
import { environment } from '../../../../environments/environment';
import jsPDF from 'jspdf';

@Component({
  selector: 'app-schedule-appointment',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './schedule-appointment.component.html',
  styleUrls: ['./schedule-appointment.component.css']
})
export class ScheduleAppointmentComponent implements OnInit {
  searchForm: FormGroup;
  bookingForm: FormGroup;
  
  specializations: Specialization[] = [];
  availableSlots: DoctorSlot[] = [];
  selectedDoctor: any = null;
  selectedSlot: DoctorSlot | null = null;
  currentUser: User | null = null;
  userProfile: any = null;
  
  isLoading = false;
  isBooking = false;
  showBookingForm = false;
  
  // Pagination
  currentPage = 1;
  itemsPerPage = 6;
  totalItems = 0;
  
  // Date validation
  minDate = new Date().toISOString().split('T')[0];
  maxDate = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private http: HttpClient,
    private authService: AuthService,
    private adminService: AdminService,
    private toastService: ToastService
  ) {
    this.searchForm = this.fb.group({
      specializationId: ['', [Validators.required]],
      appointmentDate: ['', [Validators.required]]
    });
    
    this.bookingForm = this.fb.group({
      symptoms: ['', [Validators.required, Validators.minLength(10)]],
      notes: ['', [Validators.maxLength(500)]]
    });
  }

  ngOnInit(): void {
    this.loadSpecializations();
    this.loadCurrentUser();
    this.loadUserProfile();
  }

  loadCurrentUser(): void {
    this.currentUser = this.authService.getCurrentUser();
    if (!this.currentUser) {
      this.router.navigate(['/login']);
    }
  }

  loadUserProfile(): void {
    const currentUser = this.authService.getCurrentUser();
    if (currentUser?.id) {
      this.http.get<any>(`${environment.apiUrl}/api/simple-profile/user/${currentUser.id}`).subscribe({
        next: (response) => {
          this.userProfile = response.data;
        },
        error: (error) => {
          console.error('Error loading user profile:', error);
          // Fallback to basic user data
          this.userProfile = currentUser;
        }
      });
    }
  }

  loadSpecializations(): void {
    this.adminService.getAppointmentSpecializations().subscribe({
      next: (response) => {
        if (response.success) {
          this.specializations = response.data;
        }
      },
      error: (error) => {
        console.error('Error loading specializations:', error);
      }
    });
  }

  searchAppointments(): void {
    if (this.searchForm.valid) {
      this.isLoading = true;
      const formValue = this.searchForm.value;
      
      console.log('=== SEARCHING APPOINTMENTS ===');
      console.log('Specialization ID:', formValue.specializationId);
      console.log('Appointment Date:', formValue.appointmentDate);
      
      this.adminService.getAvailableSlots(formValue.specializationId, formValue.appointmentDate).subscribe({
        next: (response) => {
          if (response.success) {
            console.log('Raw slots data:', response.data);
            console.log('Number of raw slots:', response.data.length);
            
            this.availableSlots = response.data;
            this.currentPage = 1;
            this.groupSlotsByDoctor();
            
            console.log('After grouping - Number of doctors:', this.availableSlots.length);
            console.log('Total items for pagination:', this.totalItems);
            console.log('Total pages:', this.totalPages);
          }
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error loading available slots:', error);
          this.isLoading = false;
        }
      });
    }
  }

  groupSlotsByDoctor(): void {
    // Group slots by doctor for better display
    const groupedSlots = new Map();
    
    console.log('=== GROUPING SLOTS BY DOCTOR ===');
    console.log('Available slots before grouping:', this.availableSlots.length);
    
    this.availableSlots.forEach((slot, index) => {
      const doctorId = slot.doctor.doctorId;
      const doctorName = slot.doctor.user.name;
      
      console.log(`Slot ${index + 1}: Doctor ID ${doctorId} (${doctorName})`);
      
      if (!groupedSlots.has(doctorId)) {
        groupedSlots.set(doctorId, {
          doctor: slot.doctor,
          slots: []
        });
        console.log(`Created new group for doctor: ${doctorName}`);
      }
      groupedSlots.get(doctorId).slots.push(slot);
    });
    
    // Convert to array for display
    this.availableSlots = Array.from(groupedSlots.values());
    
    // Update totalItems to reflect the number of grouped doctors, not individual slots
    this.totalItems = this.availableSlots.length;
    
    console.log('=== GROUPING COMPLETE ===');
    console.log('Number of unique doctors:', this.availableSlots.length);
    console.log('Total items for pagination:', this.totalItems);
    
    // Log each doctor and their slot count
    this.availableSlots.forEach((doctorData: any, index) => {
      console.log(`Doctor ${index + 1}: ${doctorData.doctor.user.name} - ${doctorData.slots?.length || 0} slots`);
    });
  }

  selectDoctor(doctorData: any): void {
    if (doctorData.doctor.deletedAt) {
      return; // Don't allow booking with deleted doctors
    }
    this.selectedDoctor = doctorData.doctor;
    this.showBookingForm = true;
    this.bookingForm.reset();
  }

  proceedToPayment(): void {
    if (this.bookingForm.valid && this.selectedSlot && this.currentUser && this.selectedDoctor) {
      // Store appointment data in session storage for payment flow
      const appointmentData = {
        slotId: this.selectedSlot.slotId,
        patientId: this.currentUser.id,
        doctorId: this.selectedDoctor.doctorId,
        appointmentDate: this.searchForm.value.appointmentDate,
        appointmentTime: this.selectedSlot.startTime,
        endTime: this.selectedSlot.endTime,
        appointmentType: 'CONSULTATION',
        consultationFee: this.selectedDoctor.consultationFee,
        symptoms: this.bookingForm.value.symptoms,
        notes: this.bookingForm.value.notes || '',
        doctorName: this.selectedDoctor.user.name,
        specialization: this.selectedDoctor.specialization.name
      };
      
      sessionStorage.setItem('pendingAppointment', JSON.stringify(appointmentData));
      
      // Redirect to payment selection
      this.router.navigate(['/payments/select']);
    }
  }

  selectSlot(slot: DoctorSlot): void {
    this.selectedSlot = slot;
    // Find the doctor for this slot
    const slotWithDoctor = this.availableSlots.find(s => s.slotId === slot.slotId);
    if (slotWithDoctor && slotWithDoctor.doctor) {
      this.selectedDoctor = slotWithDoctor.doctor;
    }
  }

  bookAppointment(): void {
    if (this.bookingForm.valid && this.selectedSlot && this.currentUser && this.selectedDoctor) {
      this.isBooking = true;

      // Parse time strings to time objects as expected by backend
      const parseTimeString = (timeStr: string) => {
        const [hours, minutes, seconds = 0] = timeStr.split(':').map(Number);
        return {
          hour: hours,
          minute: minutes,
          second: seconds,
          nano: 0
        };
      };

      const bookingData = {
        patientId: this.currentUser.id,
        doctorId: this.selectedDoctor.doctorId,
        appointmentDate: this.searchForm.value.appointmentDate,
        appointmentTime: parseTimeString(this.selectedSlot.startTime),
        endTime: parseTimeString(this.selectedSlot.endTime),
        appointmentType: 'CONSULTATION',
        consultationFee: this.selectedDoctor.consultationFee,
        symptoms: this.bookingForm.value.symptoms,
        notes: this.bookingForm.value.notes || ''
      };

      console.log('=== BOOKING DATA DEBUG ===');
      console.log('Selected slot start time:', this.selectedSlot.startTime);
      console.log('Selected slot end time:', this.selectedSlot.endTime);
      console.log('Parsed appointment time:', parseTimeString(this.selectedSlot.startTime));
      console.log('Parsed end time:', parseTimeString(this.selectedSlot.endTime));
      console.log('Full booking data:', bookingData);
      
      this.adminService.bookAppointment(bookingData).subscribe({
        next: (response) => {
          if (response.success) {
            // Show success toast with navigation options
            const actions: ToastAction[] = [
              {
                label: 'Go to Home',
                action: () => this.router.navigate(['/home']),
                style: 'primary'
              },
              {
                label: 'View My Appointments',
                action: () => this.router.navigate(['/appointments/my-appointments']),
                style: 'secondary'
              }
            ];
            
            this.toastService.showSuccess(
              'Appointment booked successfully! You can view your appointments or return to home.',
              actions,
              8000
            );
            
            // Reset form and hide booking form
            this.showBookingForm = false;
            this.selectedDoctor = null;
            this.selectedSlot = null;
            this.bookingForm.reset();
            this.searchForm.reset();
            this.availableSlots = [];
          }
          this.isBooking = false;
        },
        error: (error) => {
          console.error('Error booking appointment:', error);
          this.toastService.showError('Error booking appointment. Please try again.');
          this.isBooking = false;
        }
      });
    }
  }

  cancelBooking(): void {
    this.showBookingForm = false;
    this.selectedDoctor = null;
    this.selectedSlot = null;
    this.bookingForm.reset();
  }

  get paginatedSlots(): any[] {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    const endIndex = startIndex + this.itemsPerPage;
    const paginated = this.availableSlots.slice(startIndex, endIndex);
    
    console.log('=== PAGINATION DEBUG ===');
    console.log('Current page:', this.currentPage);
    console.log('Items per page:', this.itemsPerPage);
    console.log('Total items:', this.totalItems);
    console.log('Total pages:', this.totalPages);
    console.log('Start index:', startIndex);
    console.log('End index:', endIndex);
    console.log('Available slots length:', this.availableSlots.length);
    console.log('Paginated slots length:', paginated.length);
    console.log('Paginated slots:', paginated.map(d => d.doctor.user.name));
    
    return paginated;
  }

  get totalPages(): number {
    return Math.ceil(this.totalItems / this.itemsPerPage);
  }

  goToPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
    }
  }

  getPageNumbers(): number[] {
    const pages: number[] = [];
    const startPage = Math.max(1, this.currentPage - 2);
    const endPage = Math.min(this.totalPages, this.currentPage + 2);
    
    for (let i = startPage; i <= endPage; i++) {
      pages.push(i);
    }
    
    return pages;
  }

  formatTime(time: string): string {
    return new Date(`2000-01-01T${time}`).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    });
  }

  formatDate(date: string): string {
    return new Date(date).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  downloadAppointmentReceipt(): void {
    if (!this.selectedDoctor || !this.selectedSlot || !this.currentUser) {
      this.toastService.showError('No appointment data available for receipt generation.');
      return;
    }

    try {
      const pdf = new jsPDF();
      
      // Set up colors
      const primaryColor = '#3b82f6';
      const secondaryColor = '#6b7280';
      const successColor = '#059669';
      
      // Header
      pdf.setFillColor(primaryColor);
      pdf.rect(0, 0, 210, 30, 'F');
      
      pdf.setTextColor(255, 255, 255);
      pdf.setFontSize(20);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Hospital Management System', 105, 15, { align: 'center' });
      
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'normal');
      pdf.text('Appointment Booking Receipt', 105, 22, { align: 'center' });
      
      // Reset text color
      pdf.setTextColor(0, 0, 0);
      
      // Receipt number and date
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Booking ID: ${Date.now()}`, 15, 45);
      pdf.text(`Date: ${this.formatDateTime(new Date().toISOString())}`, 15, 50);
      
      // Patient Information
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Patient Information', 15, 65);
      
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Name: ${this.userProfile?.name || this.currentUser?.name || 'N/A'}`, 15, 75);
      pdf.text(`Email: ${this.userProfile?.email || this.currentUser?.email || 'N/A'}`, 15, 80);
      pdf.text(`Phone: ${this.userProfile?.contact || this.currentUser?.contact || 'N/A'}`, 15, 85);
      if (this.userProfile?.address) {
        pdf.text(`Address: ${this.userProfile.address}`, 15, 90);
      }
      
      // Doctor Information
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Doctor Information', 15, 100);
      
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Doctor: ${this.selectedDoctor.user.name}`, 15, 110);
      pdf.text(`Specialization: ${this.selectedDoctor.specialization.name}`, 15, 115);
      pdf.text(`Experience: ${this.selectedDoctor.yearsOfExp} years`, 15, 120);
      
      // Appointment Details
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Appointment Details', 15, 135);
      
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Date: ${this.formatDate(this.searchForm.value.appointmentDate)}`, 15, 145);
      pdf.text(`Time: ${this.formatTime(this.selectedSlot.startTime)} - ${this.formatTime(this.selectedSlot.endTime)}`, 15, 150);
      pdf.text(`Type: CONSULTATION`, 15, 155);
      
      if (this.bookingForm.value.symptoms) {
        pdf.text(`Symptoms: ${this.bookingForm.value.symptoms}`, 15, 160);
      }
      
      if (this.bookingForm.value.notes) {
        pdf.text(`Notes: ${this.bookingForm.value.notes}`, 15, 165);
      }
      
      // Payment Information
      pdf.setFontSize(12);
      pdf.setFont('helvetica', 'bold');
      pdf.text('Payment Information', 15, 180);
      
      pdf.setFontSize(10);
      pdf.setFont('helvetica', 'normal');
      pdf.text(`Status: Pending Payment`, 15, 190);
      pdf.text(`Payment Method: To be selected`, 15, 195);
      pdf.text(`Booking Date: ${this.formatDateTime(new Date().toISOString())}`, 15, 200);
      
      // Amount
      pdf.setFontSize(14);
      pdf.setFont('helvetica', 'bold');
      pdf.setTextColor(successColor);
      pdf.text(`Consultation Fee: ₹${this.selectedDoctor.consultationFee}`, 15, 215);
      
      // Footer
      pdf.setTextColor(0, 0, 0);
      pdf.setFontSize(8);
      pdf.setFont('helvetica', 'normal');
      pdf.text('This is a booking confirmation. Payment is required to confirm the appointment.', 105, 250, { align: 'center' });
      pdf.text('Please proceed to payment to secure your appointment slot.', 105, 255, { align: 'center' });
      pdf.text('For any queries, contact us at support@hospital.com', 105, 260, { align: 'center' });
      
      // Add border
      pdf.setDrawColor(200, 200, 200);
      pdf.rect(10, 35, 190, 220);
      
      // Download the PDF
      const fileName = `appointment-booking-${Date.now()}.pdf`;
      pdf.save(fileName);
      
      this.toastService.showSuccess('Booking receipt downloaded successfully!');
    } catch (error) {
      console.error('Error generating PDF:', error);
      this.toastService.showError('Error generating receipt. Please try again.');
    }
  }

  formatDateTime(dateTime: string): string {
    if (!dateTime) return '';
    return new Date(dateTime).toLocaleString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    });
  }
}
