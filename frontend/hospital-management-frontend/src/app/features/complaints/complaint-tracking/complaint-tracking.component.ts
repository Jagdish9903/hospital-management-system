// frontend/hospital-management-frontend/src/app/features/complaints/complaint-tracking/complaint-tracking.component.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../../core/services/auth.service';
import { ToastService } from '../../../core/services/toast.service';
import { environment } from '../../../../environments/environment';

interface Complaint {
  complaintId: number;
  title: string;
  description: string;
  category: string;
  priority: string;
  status: string;
  contactPreference: string;
  createdAt: string;
  updatedAt: string;
  appointment?: {
    id: number;
    appointmentDate: string;
    appointmentTime: string;
    doctor: {
      doctorId: number;
      user: {
        firstname: string;
        lastname: string;
      };
      specialization: {
        name: string;
      };
    };
  };
  resolution?: string;
  resolutionNotes?: string;
  customerFeedback?: string;
  assignedTo?: {
    id: number;
    name: string;
    email: string;
  };
}

@Component({
  selector: 'app-complaint-tracking',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  template: `
    <div class="complaint-tracking-container">
      <div class="tracking-header">
        <h1>Complaint Tracking</h1>
        <p>Track the status and progress of your submitted complaints</p>
      </div>

      <!-- Loading State -->
      <div *ngIf="isLoading" class="loading-state">
        <div class="loading-spinner"></div>
        <p>Loading your complaints...</p>
      </div>

      <!-- No Complaints State -->
      <div *ngIf="!isLoading && complaints.length === 0" class="no-complaints-state">
        <div class="no-complaints-content">
          <svg class="no-complaints-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3z"/>
            <circle cx="12" cy="13" r="3"/>
          </svg>
          <h3>No Complaints Found</h3>
          <p>You haven't submitted any complaints yet. <a routerLink="/complaints">Register a complaint</a> to get started.</p>
        </div>
      </div>

      <!-- Complaints List -->
      <div *ngIf="!isLoading && complaints.length > 0" class="complaints-list">
        <div class="complaints-header">
          <h2>Your Complaints ({{ complaints.length }})</h2>
          <div class="filter-controls">
            <select [(ngModel)]="statusFilter" (change)="filterComplaints()" class="filter-select">
              <option value="">All Statuses</option>
              <option value="OPEN">Open</option>
              <option value="IN_PROGRESS">In Progress</option>
              <option value="RESOLVED">Resolved</option>
              <option value="CLOSED">Closed</option>
              <option value="REOPENED">Reopened</option>
            </select>
          </div>
        </div>

        <div class="complaints-grid">
          <div 
            *ngFor="let complaint of filteredComplaints" 
            class="complaint-card"
            (click)="openComplaintDetail(complaint)"
          >
            <div class="complaint-card-header">
              <div class="complaint-title">{{ complaint.title }}</div>
              <div class="complaint-status" [class]="'status-' + complaint.status.toLowerCase().replace('_', '-')">
                {{ formatEnum(complaint.status) }}
              </div>
            </div>

            <div class="complaint-card-body">
              <div class="complaint-meta">
                <span class="complaint-category">{{ formatEnum(complaint.category) }}</span>
                <span class="complaint-priority priority-{{ complaint.priority.toLowerCase() }}">
                  {{ formatEnum(complaint.priority) }}
                </span>
                <span class="complaint-date">{{ formatDate(complaint.createdAt) }}</span>
              </div>

              <div class="complaint-description">
                {{ complaint.description.length > 150 ? complaint.description.substring(0, 150) + '...' : complaint.description }}
              </div>

              <div *ngIf="complaint.appointment" class="complaint-appointment">
                <strong>Related Appointment:</strong> 
                {{ formatAppointmentInfo(complaint.appointment) }}
              </div>

              <div *ngIf="complaint.assignedTo" class="complaint-assigned">
                <strong>Assigned to:</strong> {{ complaint.assignedTo.name }}
              </div>
            </div>

            <div class="complaint-card-footer">
              <div class="complaint-actions">
                <button class="btn-view-details" (click)="openComplaintDetail(complaint); $event.stopPropagation()">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                    <circle cx="12" cy="12" r="3"/>
                  </svg>
                  View Details
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Complaint Detail Modal -->
      <div *ngIf="selectedComplaint" class="modal-overlay" (click)="closeComplaintDetail()">
        <div class="modal-content" (click)="$event.stopPropagation()">
          <div class="modal-header">
            <h2>Complaint Details</h2>
            <button class="modal-close" (click)="closeComplaintDetail()">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <line x1="18" y1="6" x2="6" y2="18"/>
                <line x1="6" y1="6" x2="18" y2="18"/>
              </svg>
            </button>
          </div>

          <div class="modal-body">
            <!-- Complaint Header -->
            <div class="complaint-detail-header">
              <div class="complaint-detail-title">{{ selectedComplaint.title }}</div>
              <div class="complaint-detail-status" [class]="'status-' + selectedComplaint.status.toLowerCase().replace('_', '-')">
                {{ formatEnum(selectedComplaint.status) }}
              </div>
            </div>

            <!-- Complaint Meta -->
            <div class="complaint-detail-meta">
              <div class="meta-item">
                <label>Category:</label>
                <span class="complaint-category">{{ formatEnum(selectedComplaint.category) }}</span>
              </div>
              <div class="meta-item">
                <label>Priority:</label>
                <span class="complaint-priority priority-{{ selectedComplaint.priority.toLowerCase() }}">
                  {{ formatEnum(selectedComplaint.priority) }}
                </span>
              </div>
              <div class="meta-item">
                <label>Contact Preference:</label>
                <span>{{ formatEnum(selectedComplaint.contactPreference) }}</span>
              </div>
              <div class="meta-item">
                <label>Submitted:</label>
                <span>{{ formatDate(selectedComplaint.createdAt) }}</span>
              </div>
              <div class="meta-item" *ngIf="selectedComplaint.updatedAt !== selectedComplaint.createdAt">
                <label>Last Updated:</label>
                <span>{{ formatDate(selectedComplaint.updatedAt) }}</span>
              </div>
            </div>

            <!-- Complaint Description -->
            <div class="complaint-detail-section">
              <h3>Description</h3>
              <div class="complaint-description-full">{{ selectedComplaint.description }}</div>
            </div>

            <!-- Related Appointment -->
            <div *ngIf="selectedComplaint.appointment" class="complaint-detail-section">
              <h3>Related Appointment</h3>
              <div class="appointment-details">
                <div class="appointment-info">
                  <strong>Appointment #{{ selectedComplaint.appointment.id }}</strong>
                  <div class="appointment-meta">
                    <span>Date: {{ formatDate(selectedComplaint.appointment.appointmentDate) }}</span>
                    <span>Time: {{ selectedComplaint.appointment.appointmentTime }}</span>
                    <span>Doctor: {{ formatDoctorName(selectedComplaint.appointment.doctor) }}</span>
                    <span>Specialization: {{ selectedComplaint.appointment.doctor.specialization.name }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Assignment Info -->
            <div *ngIf="selectedComplaint.assignedTo" class="complaint-detail-section">
              <h3>Assignment</h3>
              <div class="assignment-info">
                <strong>Assigned to:</strong> {{ selectedComplaint.assignedTo.name }}
                <div class="assignment-contact">Email: {{ selectedComplaint.assignedTo.email }}</div>
              </div>
            </div>

            <!-- Resolution -->
            <div *ngIf="selectedComplaint.resolution" class="complaint-detail-section">
              <h3>Resolution</h3>
              <div class="resolution-content">
                <div class="resolution-text">{{ selectedComplaint.resolution }}</div>
                <div *ngIf="selectedComplaint.resolutionNotes" class="resolution-notes">
                  <strong>Resolution Notes:</strong> {{ selectedComplaint.resolutionNotes }}
                </div>
              </div>
            </div>

            <!-- Customer Feedback -->
            <div *ngIf="selectedComplaint.customerFeedback" class="complaint-detail-section">
              <h3>Your Feedback</h3>
              <div class="customer-feedback">{{ selectedComplaint.customerFeedback }}</div>
            </div>

            <!-- Status Timeline -->
            <div class="complaint-detail-section">
              <h3>Status Timeline</h3>
              <div class="status-timeline">
                <div class="timeline-item">
                  <div class="timeline-marker status-open"></div>
                  <div class="timeline-content">
                    <div class="timeline-title">Complaint Submitted</div>
                    <div class="timeline-date">{{ formatDate(selectedComplaint.createdAt) }}</div>
                  </div>
                </div>
                <div *ngIf="selectedComplaint.status !== 'OPEN'" class="timeline-item">
                  <div class="timeline-marker" [class]="'status-' + selectedComplaint.status.toLowerCase().replace('_', '-')"></div>
                  <div class="timeline-content">
                    <div class="timeline-title">Status: {{ formatEnum(selectedComplaint.status) }}</div>
                    <div class="timeline-date">{{ formatDate(selectedComplaint.updatedAt) }}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Feedback Form -->
          <div *ngIf="showFeedbackForm" class="feedback-form">
            <h3>Provide Feedback</h3>
            <div class="feedback-form-content">
              <textarea 
                [(ngModel)]="feedbackText" 
                placeholder="Please share your feedback about how this complaint was resolved..."
                class="feedback-textarea"
                rows="4"
                maxlength="1000">
              </textarea>
              <div class="feedback-actions">
                <button class="btn-secondary" (click)="cancelFeedback()" [disabled]="isSubmittingFeedback">
                  Cancel
                </button>
                <button class="btn-primary" (click)="submitFeedback()" [disabled]="isSubmittingFeedback || !feedbackText.trim()">
                  <span *ngIf="isSubmittingFeedback">Submitting...</span>
                  <span *ngIf="!isSubmittingFeedback">Submit Feedback</span>
                </button>
              </div>
            </div>
          </div>

          <div class="modal-footer">
            <button class="btn-secondary" (click)="closeComplaintDetail()">Close</button>
            <button *ngIf="selectedComplaint.status === 'RESOLVED' || selectedComplaint.status === 'CLOSED'" 
                    class="btn-primary" (click)="provideFeedback()">
              {{ selectedComplaint.customerFeedback ? 'Update Feedback' : 'Provide Feedback' }}
            </button>
          </div>
        </div>
      </div>
    </div>
  `,
  styleUrls: ['./complaint-tracking.component.css']
})
export class ComplaintTrackingComponent implements OnInit {
  complaints: Complaint[] = [];
  filteredComplaints: Complaint[] = [];
  selectedComplaint: Complaint | null = null;
  isLoading = false;
  statusFilter = '';
  showFeedbackForm = false;
  feedbackText = '';
  isSubmittingFeedback = false;

  constructor(
    private http: HttpClient,
    private authService: AuthService,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadComplaints();
  }

  loadComplaints(): void {
    const currentUser = this.authService.getCurrentUser();
    if (!currentUser?.id) {
      this.toastService.showError('User not authenticated');
      return;
    }

    this.isLoading = true;
    this.http.get<any>(`${environment.apiUrl}/api/simple-complaints/patient/${currentUser.id}`).subscribe({
      next: (response) => {
        this.complaints = response.data;
        this.filteredComplaints = [...this.complaints];
        this.isLoading = false;
        console.log('Complaints loaded:', this.complaints);
      },
      error: (error) => {
        this.isLoading = false;
        console.error('Error loading complaints:', error);
        this.toastService.showError('Failed to load complaints');
      }
    });
  }

  filterComplaints(): void {
    if (!this.statusFilter) {
      this.filteredComplaints = [...this.complaints];
    } else {
      this.filteredComplaints = this.complaints.filter(complaint => 
        complaint.status === this.statusFilter
      );
    }
  }

  openComplaintDetail(complaint: Complaint): void {
    this.selectedComplaint = complaint;
  }

  closeComplaintDetail(): void {
    this.selectedComplaint = null;
  }

  provideFeedback(): void {
    this.showFeedbackForm = true;
    this.feedbackText = this.selectedComplaint?.customerFeedback || '';
  }

  submitFeedback(): void {
    if (!this.selectedComplaint || !this.feedbackText.trim()) {
      this.toastService.showError('Please enter your feedback');
      return;
    }

    this.isSubmittingFeedback = true;
    const feedbackData = {
      customerFeedback: this.feedbackText.trim()
    };

    this.http.put<any>(`${environment.apiUrl}/api/simple-complaints/${this.selectedComplaint.complaintId}/feedback`, feedbackData).subscribe({
      next: (response) => {
        this.isSubmittingFeedback = false;
        this.showFeedbackForm = false;
        this.feedbackText = '';
        
        // Update the complaint in the list
        const complaintIndex = this.complaints.findIndex(c => c.complaintId === this.selectedComplaint!.complaintId);
        if (complaintIndex !== -1) {
          this.complaints[complaintIndex].customerFeedback = feedbackData.customerFeedback;
          this.selectedComplaint!.customerFeedback = feedbackData.customerFeedback;
        }
        
        this.toastService.showSuccess('Feedback submitted successfully!');
      },
      error: (error) => {
        this.isSubmittingFeedback = false;
        console.error('Error submitting feedback:', error);
        this.toastService.showError('Failed to submit feedback');
      }
    });
  }

  cancelFeedback(): void {
    this.showFeedbackForm = false;
    this.feedbackText = '';
  }

  formatEnum(value: string): string {
    if (!value) return '';
    return value.split('_').map(word => 
      word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
    ).join(' ');
  }

  formatDate(dateString: string): string {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' at ' + date.toLocaleTimeString();
  }

  formatAppointmentInfo(appointment: any): string {
    const date = new Date(appointment.appointmentDate);
    const formattedDate = date.toLocaleDateString();
    const doctorName = appointment.doctor?.user ? 
      `${appointment.doctor.user.firstname} ${appointment.doctor.user.lastname}` : 
      'Unknown Doctor';
    return `Appointment #${appointment.id} - ${formattedDate} at ${appointment.appointmentTime} (Dr. ${doctorName})`;
  }

  formatDoctorName(doctor: any): string {
    return doctor?.user ? 
      `${doctor.user.firstname} ${doctor.user.lastname}` : 
      'Unknown Doctor';
  }
}
