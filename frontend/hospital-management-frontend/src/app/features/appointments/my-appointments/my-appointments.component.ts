import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AdminService, Appointment } from '../../../core/services/admin.service';
import { AuthService } from '../../../core/services/auth.service';
import { ToastService } from '../../../core/services/toast.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-my-appointments',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="appointments-container">
      <div class="appointments-header">
        <h1>My Appointments</h1>
        <div class="appointment-stats">
          <div class="stat-card upcoming">
            <div class="stat-number">{{ appointmentStats.totalUpcoming }}</div>
            <div class="stat-label">Upcoming</div>
          </div>
          <div class="stat-card past">
            <div class="stat-number">{{ appointmentStats.totalPast }}</div>
            <div class="stat-label">Past</div>
          </div>
        </div>
      </div>

      <div class="appointments-tabs">
        <button 
          class="tab-btn" 
          [class.active]="activeTab === 'upcoming'"
          (click)="setActiveTab('upcoming')"
        >
          Upcoming Appointments
        </button>
        <button 
          class="tab-btn" 
          [class.active]="activeTab === 'past'"
          (click)="setActiveTab('past')"
        >
          Past Appointments
        </button>
      </div>

      <div class="appointments-content">
        <!-- Upcoming Appointments -->
        <div *ngIf="activeTab === 'upcoming'" class="appointments-list">
          <div *ngIf="upcomingAppointments.length === 0" class="empty-state">
            <div class="empty-icon">📅</div>
            <h3>No upcoming appointments</h3>
            <p>You don't have any upcoming appointments scheduled.</p>
            <button class="btn-primary" (click)="bookNewAppointment()">
              Book New Appointment
            </button>
          </div>
          
          <div *ngFor="let appointment of upcomingAppointments" class="appointment-card upcoming">
            <div class="appointment-header">
              <div class="appointment-date">
                <div class="date-day">{{ getDayOfWeek(appointment.appointmentDate) }}</div>
                <div class="date-full">{{ formatDate(appointment.appointmentDate) }}</div>
              </div>
              <div class="appointment-time">
                <div class="time-start">{{ formatTime(appointment.appointmentTime) }}</div>
                <div class="time-end">{{ formatTime(appointment.endTime) }}</div>
              </div>
              <div class="appointment-status" [ngClass]="'status-' + appointment.status.toLowerCase()">
                {{ appointment.status }}
              </div>
            </div>
            
            <div class="appointment-body">
              <div class="doctor-info">
                <div class="doctor-name">{{ appointment.doctor.user.name || 'Dr. Unknown' }}</div>
                <div class="doctor-specialization">{{ appointment.doctor.specialization.name || 'General' }}</div>
              </div>
              
              <div class="appointment-details">
                <div class="detail-item">
                  <span class="detail-label">Type:</span>
                  <span class="detail-value">{{ appointment.appointmentType }}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Fee:</span>
                  <span class="detail-value">{{ appointment.consultationFee }}</span>
                </div>
                <div class="detail-item" *ngIf="appointment.symptoms">
                  <span class="detail-label">Symptoms:</span>
                  <span class="detail-value">{{ appointment.symptoms }}</span>
                </div>
              </div>
            </div>
            
            <div class="appointment-actions" *ngIf="appointment.status !== 'CANCELLED'">
              <button class="btn-secondary" (click)="rescheduleAppointment(appointment)">
                Reschedule
              </button>
              <button class="btn-danger" (click)="cancelAppointment(appointment)">
                Cancel
              </button>
            </div>
          </div>
        </div>

        <!-- Past Appointments -->
        <div *ngIf="activeTab === 'past'" class="appointments-list">
          <div *ngIf="pastAppointments.length === 0" class="empty-state">
            <div class="empty-icon">📋</div>
            <h3>No past appointments</h3>
            <p>You haven't had any appointments yet.</p>
          </div>
          
          <div *ngFor="let appointment of pastAppointments" class="appointment-card past">
            <div class="appointment-header">
              <div class="appointment-date">
                <div class="date-day">{{ getDayOfWeek(appointment.appointmentDate) }}</div>
                <div class="date-full">{{ formatDate(appointment.appointmentDate) }}</div>
              </div>
              <div class="appointment-time">
                <div class="time-start">{{ formatTime(appointment.appointmentTime) }}</div>
                <div class="time-end">{{ formatTime(appointment.endTime) }}</div>
              </div>
              <div class="appointment-status" [ngClass]="'status-' + appointment.status.toLowerCase()">
                {{ appointment.status }}
              </div>
            </div>
            
            <div class="appointment-body">
              <div class="doctor-info">
                <div class="doctor-name">{{ appointment.doctor.user.name || 'Dr. Unknown' }}</div>
                <div class="doctor-specialization">{{ appointment.doctor.specialization.name || 'General' }}</div>
              </div>
              
              <div class="appointment-details">
                <div class="detail-item">
                  <span class="detail-label">Type:</span>
                  <span class="detail-value">{{ appointment.appointmentType }}</span>
                </div>
                <div class="detail-item">
                  <span class="detail-label">Fee:</span>
                  <span class="detail-value">{{ appointment.consultationFee }}</span>
                </div>
                <div class="detail-item" *ngIf="appointment.symptoms">
                  <span class="detail-label">Symptoms:</span>
                  <span class="detail-value">{{ appointment.symptoms }}</span>
                </div>
                <div class="detail-item" *ngIf="appointment.cancellationReason">
                  <span class="detail-label">Cancellation Reason:</span>
                  <span class="detail-value">{{ appointment.cancellationReason }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Reschedule Modal -->
    <div *ngIf="showRescheduleModal" class="modal-overlay" (click)="closeRescheduleModal()">
      <div class="modal-content" (click)="$event.stopPropagation()">
        <div class="modal-header">
          <h3>Reschedule Appointment</h3>
          <button class="modal-close" (click)="closeRescheduleModal()">×</button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>New Date:</label>
            <input type="date" [(ngModel)]="rescheduleData.appointmentDate" [min]="today">
          </div>
          <div class="form-group">
            <label>New Time:</label>
            <input type="time" [(ngModel)]="rescheduleData.appointmentTime">
          </div>
          <div class="form-group">
            <label>End Time:</label>
            <input type="time" [(ngModel)]="rescheduleData.endTime">
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn-secondary" (click)="closeRescheduleModal()">Cancel</button>
          <button class="btn-primary" (click)="confirmReschedule()" [disabled]="!rescheduleData.appointmentDate || !rescheduleData.appointmentTime">
            Reschedule
          </button>
        </div>
      </div>
    </div>

    <!-- Cancel Modal -->
    <div *ngIf="showCancelModal" class="modal-overlay" (click)="closeCancelModal()">
      <div class="modal-content" (click)="$event.stopPropagation()">
        <div class="modal-header">
          <h3>Cancel Appointment</h3>
          <button class="modal-close" (click)="closeCancelModal()">×</button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>Reason for cancellation:</label>
            <textarea [(ngModel)]="cancelReason" placeholder="Please provide a reason for cancelling this appointment..." rows="3"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn-secondary" (click)="closeCancelModal()">Keep Appointment</button>
          <button class="btn-danger" (click)="confirmCancel()" [disabled]="!cancelReason.trim()">
            Cancel Appointment
          </button>
        </div>
      </div>
    </div>
  `,
  styleUrls: ['./my-appointments.component.css']
})
export class MyAppointmentsComponent implements OnInit {
  activeTab: 'upcoming' | 'past' = 'upcoming';
  upcomingAppointments: Appointment[] = [];
  pastAppointments: Appointment[] = [];
  appointmentStats = { totalUpcoming: 0, totalPast: 0 };
  
  showRescheduleModal = false;
  showCancelModal = false;
  selectedAppointment: Appointment | null = null;
  rescheduleData = { appointmentDate: '', appointmentTime: '', endTime: '' };
  cancelReason = '';
  today = new Date().toISOString().split('T')[0];

  constructor(
    private adminService: AdminService,
    private authService: AuthService,
    private toastService: ToastService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadAppointments();
  }

  loadAppointments(): void {
    const currentUser = this.authService.getCurrentUser();
    if (currentUser?.id) {
      this.adminService.getUserAppointments(currentUser.id).subscribe({
        next: (data) => {
          this.upcomingAppointments = data.upcoming;
          this.pastAppointments = data.past;
          this.appointmentStats = {
            totalUpcoming: data.totalUpcoming,
            totalPast: data.totalPast
          };
        },
        error: (error) => {
          this.toastService.showError('Failed to load appointments');
          console.error('Error loading appointments:', error);
        }
      });
    }
  }

  setActiveTab(tab: 'upcoming' | 'past'): void {
    this.activeTab = tab;
  }

  bookNewAppointment(): void {
    this.router.navigate(['/appointments/schedule']);
  }

  rescheduleAppointment(appointment: Appointment): void {
    this.selectedAppointment = appointment;
    this.rescheduleData = {
      appointmentDate: appointment.appointmentDate,
      appointmentTime: appointment.appointmentTime,
      endTime: appointment.endTime
    };
    this.showRescheduleModal = true;
  }

  closeRescheduleModal(): void {
    this.showRescheduleModal = false;
    this.selectedAppointment = null;
    this.rescheduleData = { appointmentDate: '', appointmentTime: '', endTime: '' };
  }

  confirmReschedule(): void {
    if (!this.selectedAppointment) return;

    const appointmentData = {
      appointmentDate: this.rescheduleData.appointmentDate,
      appointmentTime: {
        hour: parseInt(this.rescheduleData.appointmentTime.split(':')[0]),
        minute: parseInt(this.rescheduleData.appointmentTime.split(':')[1]),
        second: 0,
        nano: 0
      },
      endTime: {
        hour: parseInt(this.rescheduleData.endTime.split(':')[0]),
        minute: parseInt(this.rescheduleData.endTime.split(':')[1]),
        second: 0,
        nano: 0
      }
    };

    this.adminService.rescheduleAppointment(this.selectedAppointment.id!, appointmentData).subscribe({
      next: () => {
        this.toastService.showSuccess('Appointment rescheduled successfully');
        this.closeRescheduleModal();
        this.loadAppointments();
      },
      error: (error) => {
        this.toastService.showError(error.error?.message || 'Failed to reschedule appointment');
      }
    });
  }

  cancelAppointment(appointment: Appointment): void {
    this.selectedAppointment = appointment;
    this.cancelReason = '';
    this.showCancelModal = true;
  }

  closeCancelModal(): void {
    this.showCancelModal = false;
    this.selectedAppointment = null;
    this.cancelReason = '';
  }

  confirmCancel(): void {
    if (!this.selectedAppointment) return;

    this.adminService.cancelAppointment(this.selectedAppointment.id!, this.cancelReason).subscribe({
      next: () => {
        this.toastService.showSuccess('Appointment cancelled successfully');
        this.closeCancelModal();
        this.loadAppointments();
      },
      error: (error) => {
        this.toastService.showError(error.error?.message || 'Failed to cancel appointment');
      }
    });
  }

  formatDate(date: string): string {
    return new Date(date).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  formatTime(time: string): string {
    return new Date(`2000-01-01T${time}`).toLocaleTimeString('en-US', {
      hour: 'numeric',
      minute: '2-digit',
      hour12: true
    });
  }

  getDayOfWeek(date: string): string {
    return new Date(date).toLocaleDateString('en-US', { weekday: 'short' });
  }
}