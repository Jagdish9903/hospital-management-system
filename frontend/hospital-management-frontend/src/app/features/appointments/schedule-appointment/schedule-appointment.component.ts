import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { AdminService, Specialization, DoctorSlot } from '../../../core/services/admin.service';
import { User } from '../../../core/models/user.model';

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
    private authService: AuthService,
    private adminService: AdminService
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
  }

  loadCurrentUser(): void {
    this.currentUser = this.authService.getCurrentUser();
    if (!this.currentUser) {
      this.router.navigate(['/login']);
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
      
      this.adminService.getAvailableSlots(formValue.specializationId, formValue.appointmentDate).subscribe({
        next: (response) => {
          if (response.success) {
            this.availableSlots = response.data;
            this.totalItems = this.availableSlots.length;
            this.currentPage = 1;
            this.groupSlotsByDoctor();
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
    
    this.availableSlots.forEach(slot => {
      const doctorId = slot.doctor.doctorId;
      if (!groupedSlots.has(doctorId)) {
        groupedSlots.set(doctorId, {
          doctor: slot.doctor,
          slots: []
        });
      }
      groupedSlots.get(doctorId).slots.push(slot);
    });
    
    // Convert to array for display
    this.availableSlots = Array.from(groupedSlots.values());
  }

  selectDoctor(doctorData: any): void {
    this.selectedDoctor = doctorData.doctor;
    this.showBookingForm = true;
    this.bookingForm.reset();
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

      const bookingData = {
        patientId: this.currentUser.id,
        doctorId: this.selectedDoctor.doctorId,
        appointmentDate: this.searchForm.value.appointmentDate,
        appointmentTime: this.selectedSlot.startTime, // Send as string directly
        endTime: this.selectedSlot.endTime, // Send as string directly
        appointmentType: 'CONSULTATION',
        consultationFee: this.selectedDoctor.consultationFee,
        symptoms: this.bookingForm.value.symptoms,
        notes: this.bookingForm.value.notes || ''
      };
      
      this.adminService.bookAppointment(bookingData).subscribe({
        next: (response) => {
          if (response.success) {
            alert('Appointment booked successfully!');
            this.router.navigate(['/appointments/my-appointments']);
          }
          this.isBooking = false;
        },
        error: (error) => {
          console.error('Error booking appointment:', error);
          alert('Error booking appointment. Please try again.');
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
    return this.availableSlots.slice(startIndex, endIndex);
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
}
