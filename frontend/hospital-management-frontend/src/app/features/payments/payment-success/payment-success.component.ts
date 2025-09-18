import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ToastService } from '../../../core/services/toast.service';

@Component({
  selector: 'app-payment-success',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="success-container">
      <div class="success-header">
        <div class="success-icon">
          <svg viewBox="0 0 24 24">
            <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
          </svg>
        </div>
        <h1 class="success-title">Payment Successful!</h1>
        <p class="success-subtitle">Your appointment has been confirmed</p>
      </div>

      <div class="appointment-card">
        <div class="card-header">
          <h3>Appointment Confirmed</h3>
          <div class="status-badge confirmed">Confirmed</div>
        </div>
        
        <div class="appointment-details">
          <div class="detail-section">
            <h4>Doctor Information</h4>
            <div class="detail-item">
              <span class="label">Doctor:</span>
              <span class="value">{{ appointmentData?.doctorName }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Specialization:</span>
              <span class="value">{{ appointmentData?.specialization }}</span>
            </div>
          </div>

          <div class="detail-section">
            <h4>Appointment Details</h4>
            <div class="detail-item">
              <span class="label">Date:</span>
              <span class="value">{{ formatDate(appointmentData?.appointmentDate) }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Time:</span>
              <span class="value">{{ formatTime(appointmentData?.appointmentTime) }} - {{ formatTime(appointmentData?.endTime) }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Type:</span>
              <span class="value">{{ appointmentData?.appointmentType }}</span>
            </div>
            <div class="detail-item" *ngIf="appointmentData?.symptoms">
              <span class="label">Symptoms:</span>
              <span class="value">{{ appointmentData?.symptoms }}</span>
            </div>
          </div>

          <div class="detail-section">
            <h4>Payment Information</h4>
            <div class="detail-item">
              <span class="label">Payment ID:</span>
              <span class="value">{{ paymentData?.paymentId }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Transaction ID:</span>
              <span class="value">{{ paymentData?.transactionId || getTransactionId() }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Amount Paid:</span>
              <span class="value amount">₹{{ appointmentData?.consultationFee }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Payment Method:</span>
              <span class="value">{{ paymentData?.method }}</span>
            </div>
            <div class="detail-item">
              <span class="label">Payment Date:</span>
              <span class="value">{{ formatDateTime(paymentData?.paymentDate) }}</span>
            </div>
          </div>
        </div>
      </div>

      <div class="action-buttons">
        <button class="btn btn-secondary" (click)="downloadReceipt()">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z"/>
          </svg>
          Download Receipt
        </button>
        <button class="btn btn-primary" (click)="goToAppointments()">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
          </svg>
          View My Appointments
        </button>
        <button class="btn btn-outline" (click)="goHome()">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
          </svg>
          Go Home
        </button>
      </div>

      <div class="next-steps">
        <h3>What's Next?</h3>
        <div class="steps-list">
          <div class="step-item">
            <div class="step-icon">
              <svg viewBox="0 0 24 24">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
              </svg>
            </div>
            <div class="step-content">
              <h4>Appointment Confirmed</h4>
              <p>Your appointment has been successfully booked and confirmed.</p>
            </div>
          </div>
          
          <div class="step-item">
            <div class="step-icon">
              <svg viewBox="0 0 24 24">
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
              </svg>
            </div>
            <div class="step-content">
              <h4>Reminder Notification</h4>
              <p>You will receive a reminder notification 24 hours before your appointment.</p>
            </div>
          </div>
          
          <div class="step-item">
            <div class="step-icon">
              <svg viewBox="0 0 24 24">
                <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
              </svg>
            </div>
            <div class="step-content">
              <h4>Prepare for Visit</h4>
              <p>Bring your ID and any relevant medical documents to your appointment.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styleUrls: ['./payment-success.component.css']
})
export class PaymentSuccessComponent implements OnInit {
  appointmentData: any = null;
  paymentData: any = null;
  appointment: any = null;

  constructor(
    private router: Router,
    private toastService: ToastService
  ) {}

  ngOnInit(): void {
    this.loadSuccessData();
  }

  loadSuccessData(): void {
    const successData = sessionStorage.getItem('paymentSuccess');
    if (successData) {
      const data = JSON.parse(successData);
      this.appointmentData = data.appointmentData;
      this.paymentData = data.payment;
      this.appointment = data.appointment;
    } else {
      this.router.navigate(['/appointments/schedule']);
    }
  }

  downloadReceipt(): void {
    // Generate receipt content
    const receiptContent = this.generateReceiptContent();
    
    // Create and download PDF (simplified version)
    const blob = new Blob([receiptContent], { type: 'text/html' });
    const url = window.URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = `appointment-receipt-${this.paymentData?.paymentId}.html`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    window.URL.revokeObjectURL(url);
    
    this.toastService.showSuccess('Receipt downloaded successfully!');
  }

  generateReceiptContent(): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <title>Appointment Receipt</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 20px; }
          .section { margin: 20px 0; }
          .section h3 { color: #333; border-bottom: 1px solid #ccc; padding-bottom: 5px; }
          .detail { display: flex; justify-content: space-between; margin: 5px 0; }
          .label { font-weight: bold; }
          .amount { color: #059669; font-weight: bold; }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>Hospital Management System</h1>
          <h2>Appointment Receipt</h2>
        </div>
        
        <div class="section">
          <h3>Appointment Details</h3>
          <div class="detail">
            <span class="label">Doctor:</span>
            <span>${this.appointmentData?.doctorName}</span>
          </div>
          <div class="detail">
            <span class="label">Specialization:</span>
            <span>${this.appointmentData?.specialization}</span>
          </div>
          <div class="detail">
            <span class="label">Date:</span>
            <span>${this.formatDate(this.appointmentData?.appointmentDate)}</span>
          </div>
          <div class="detail">
            <span class="label">Time:</span>
            <span>${this.formatTime(this.appointmentData?.appointmentTime)} - ${this.formatTime(this.appointmentData?.endTime)}</span>
          </div>
        </div>
        
        <div class="section">
          <h3>Payment Information</h3>
          <div class="detail">
            <span class="label">Payment ID:</span>
            <span>${this.paymentData?.paymentId}</span>
          </div>
          <div class="detail">
            <span class="label">Transaction ID:</span>
            <span>${this.paymentData?.transactionId || this.getTransactionId()}</span>
          </div>
          <div class="detail">
            <span class="label">Amount:</span>
            <span class="amount">₹${this.appointmentData?.consultationFee}</span>
          </div>
          <div class="detail">
            <span class="label">Payment Method:</span>
            <span>${this.paymentData?.method}</span>
          </div>
          <div class="detail">
            <span class="label">Payment Date:</span>
            <span>${this.formatDateTime(this.paymentData?.paymentDate)}</span>
          </div>
        </div>
        
        <div class="section">
          <p><strong>Thank you for choosing our hospital!</strong></p>
          <p>Please arrive 15 minutes before your appointment time.</p>
        </div>
      </body>
      </html>
    `;
  }

  goToAppointments(): void {
    this.router.navigate(['/appointments/my-appointments']);
  }

  goHome(): void {
    this.router.navigate(['/home']);
  }

  formatDate(date: string): string {
    if (!date) return '';
    return new Date(date).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  formatTime(time: string): string {
    if (!time) return '';
    return new Date(`2000-01-01T${time}`).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    });
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

  getTransactionId(): string {
    return 'TXN' + Date.now();
  }
}
