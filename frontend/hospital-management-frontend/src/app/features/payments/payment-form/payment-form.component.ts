import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { AdminService } from '../../../core/services/admin.service';
import { ToastService } from '../../../core/services/toast.service';
import { User } from '../../../core/models/user.model';

@Component({
  selector: 'app-payment-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  template: `
    <div class="payment-form-container">
      <div class="payment-header">
        <div class="back-button" (click)="goBack()">
          <svg class="back-icon" viewBox="0 0 24 24">
            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
          </svg>
          Back to Payment Methods
        </div>
        <h1 class="page-title">Payment Details</h1>
        <p class="page-subtitle">Complete your payment to confirm your appointment</p>
      </div>

      <div class="payment-summary">
        <div class="summary-card">
          <div class="summary-header">
            <h3>Payment Summary</h3>
            <div class="payment-method-badge" [ngClass]="'method-' + selectedMethod.toLowerCase()">
              {{ selectedMethod }}
            </div>
          </div>
          <div class="summary-details">
            <div class="summary-item">
              <span class="label">Doctor:</span>
              <span class="value">{{ appointmentData?.doctorName }}</span>
            </div>
            <div class="summary-item">
              <span class="label">Date & Time:</span>
              <span class="value">{{ formatDate(appointmentData?.appointmentDate) }} at {{ formatTime(appointmentData?.appointmentTime) }}</span>
            </div>
            <div class="summary-item total">
              <span class="label">Amount to Pay:</span>
              <span class="value">₹{{ appointmentData?.consultationFee }}</span>
            </div>
          </div>
        </div>
      </div>

      <div class="payment-form-section">
        <form [formGroup]="paymentForm" (ngSubmit)="processPayment()">
          <!-- UPI Payment Form -->
          <div *ngIf="selectedMethod === 'UPI'" class="payment-form upi-form">
            <h3>UPI Payment Details</h3>
            <div class="form-group">
              <label class="form-label">UPI ID</label>
              <input type="text" formControlName="upiId" class="form-input" 
                     placeholder="Enter your UPI ID (e.g., yourname@paytm)">
              <div *ngIf="paymentForm.get('upiId')?.invalid && paymentForm.get('upiId')?.touched" 
                   class="form-error">
                Please enter a valid UPI ID
              </div>
            </div>
            
            <div class="form-group">
              <label class="form-label">Mobile Number</label>
              <input type="tel" formControlName="mobileNumber" class="form-input" 
                     placeholder="Enter your mobile number">
              <div *ngIf="paymentForm.get('mobileNumber')?.invalid && paymentForm.get('mobileNumber')?.touched" 
                   class="form-error">
                Please enter a valid 10-digit mobile number
              </div>
            </div>
          </div>

          <!-- Card Payment Form -->
          <div *ngIf="selectedMethod === 'CARD'" class="payment-form card-form">
            <h3>Card Payment Details</h3>
            <div class="form-group">
              <label class="form-label">Cardholder Name</label>
              <input type="text" formControlName="cardholderName" class="form-input" 
                     placeholder="Enter cardholder name">
              <div *ngIf="paymentForm.get('cardholderName')?.invalid && paymentForm.get('cardholderName')?.touched" 
                   class="form-error">
                Please enter a valid cardholder name
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">Card Number</label>
              <input type="text" formControlName="cardNumber" class="form-input" 
                     placeholder="1234 5678 9012 3456" maxlength="19">
              <div *ngIf="paymentForm.get('cardNumber')?.invalid && paymentForm.get('cardNumber')?.touched" 
                   class="form-error">
                Please enter a valid 16-digit card number
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Expiry Date</label>
                <input type="text" formControlName="expiryDate" class="form-input" 
                       placeholder="MM/YY" maxlength="5">
                <div *ngIf="paymentForm.get('expiryDate')?.invalid && paymentForm.get('expiryDate')?.touched" 
                     class="form-error">
                  Please enter expiry date in MM/YY format
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">CVV</label>
                <input type="text" formControlName="cvv" class="form-input" 
                       placeholder="123" maxlength="4">
                <div *ngIf="paymentForm.get('cvv')?.invalid && paymentForm.get('cvv')?.touched" 
                     class="form-error">
                  Please enter a valid CVV
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">Billing Address</label>
              <textarea formControlName="billingAddress" class="form-textarea" 
                        placeholder="Enter your billing address" rows="3"></textarea>
              <div *ngIf="paymentForm.get('billingAddress')?.invalid && paymentForm.get('billingAddress')?.touched" 
                   class="form-error">
                Please enter your billing address
              </div>
            </div>
          </div>

          <div class="form-actions">
            <button type="button" class="btn btn-secondary" (click)="goBack()">
              Back
            </button>
            <button type="submit" class="btn btn-primary" 
                    [disabled]="!paymentForm.valid || isProcessing">
              <svg *ngIf="isProcessing" class="loading-spinner" viewBox="0 0 24 24">
                <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="none" stroke-dasharray="31.416" stroke-dashoffset="31.416">
                  <animate attributeName="stroke-dasharray" dur="2s" values="0 31.416;15.708 15.708;0 31.416" repeatCount="indefinite"/>
                  <animate attributeName="stroke-dashoffset" dur="2s" values="0;-15.708;-31.416" repeatCount="indefinite"/>
                </circle>
              </svg>
              <span *ngIf="!isProcessing">Pay ₹{{ appointmentData?.consultationFee }}</span>
              <span *ngIf="isProcessing">Processing Payment...</span>
            </button>
          </div>
        </form>
      </div>

      <div class="security-notice">
        <div class="security-icon">
          <svg viewBox="0 0 24 24">
            <path d="M12,1L3,5V11C3,16.55 6.84,21.74 12,23C17.16,21.74 21,16.55 21,11V5L12,1M12,7C13.4,7 14.8,8.6 14.8,10V11H16V16H8V11H9.2V10C9.2,8.6 10.6,7 12,7M12,8.2C11.2,8.2 10.4,8.7 10.4,10V11H13.6V10C13.6,8.7 12.8,8.2 12,8.2Z"/>
          </svg>
        </div>
        <div class="security-text">
          <h4>Secure Payment</h4>
          <p>Your payment information is encrypted and secure. We use industry-standard security measures to protect your data.</p>
        </div>
      </div>
    </div>
  `,
  styleUrls: ['./payment-form.component.css']
})
export class PaymentFormComponent implements OnInit {
  paymentForm: FormGroup;
  selectedMethod: string = '';
  appointmentData: any = null;
  currentUser: User | null = null;
  isProcessing = false;

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private authService: AuthService,
    private adminService: AdminService,
    private toastService: ToastService
  ) {
    this.paymentForm = this.fb.group({});
  }

  ngOnInit(): void {
    this.loadData();
    this.initializeForm();
  }

  loadData(): void {
    this.selectedMethod = sessionStorage.getItem('selectedPaymentMethod') || '';
    const appointmentData = sessionStorage.getItem('pendingAppointment');
    
    if (appointmentData) {
      this.appointmentData = JSON.parse(appointmentData);
    } else {
      this.router.navigate(['/appointments/schedule']);
      return;
    }

    this.currentUser = this.authService.getCurrentUser();
    if (!this.currentUser) {
      this.router.navigate(['/login']);
      return;
    }

    if (!this.selectedMethod) {
      this.router.navigate(['/payments/select']);
    }
  }

  initializeForm(): void {
    if (this.selectedMethod === 'UPI') {
      this.paymentForm = this.fb.group({
        upiId: ['', [Validators.required, Validators.pattern(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+$/)]],
        mobileNumber: ['', [Validators.required, Validators.pattern(/^[6-9]\d{9}$/)]]
      });
    } else if (this.selectedMethod === 'CARD') {
      this.paymentForm = this.fb.group({
        cardholderName: ['', [Validators.required, Validators.minLength(3), Validators.pattern(/^[a-zA-Z\s]+$/)]],
        cardNumber: ['', [Validators.required, Validators.pattern(/^\d{16}$/)]],
        expiryDate: ['', [Validators.required, Validators.pattern(/^(0[1-9]|1[0-2])\/([0-9]{2})$/)]],
        cvv: ['', [Validators.required, Validators.pattern(/^\d{3,4}$/)]],
        billingAddress: ['', [Validators.required, Validators.minLength(10)]]
      });
    }
  }

  processPayment(): void {
    if (this.paymentForm.valid && this.appointmentData && this.currentUser) {
      this.isProcessing = true;

      // Create payment with appointment data (payment-first flow)
      const paymentData = {
        patientId: this.currentUser.id,
        amount: this.appointmentData.consultationFee,
        method: this.selectedMethod,
        status: 'PENDING',
        doctorId: this.appointmentData.doctorId,
        appointmentDate: this.appointmentData.appointmentDate,
        appointmentTime: this.parseTimeString(this.appointmentData.appointmentTime),
        endTime: this.parseTimeString(this.appointmentData.endTime),
        appointmentType: 'CONSULTATION',
        symptoms: this.appointmentData.symptoms,
        notes: this.appointmentData.notes || '',
        slotId: this.appointmentData.slotId,
        ...this.paymentForm.value
      };

      this.adminService.createPaymentWithAppointment(paymentData).subscribe({
        next: (paymentResponse) => {
          if (paymentResponse.success) {
            // Simulate payment processing
            setTimeout(() => {
              // Confirm payment and create appointment
              this.adminService.confirmPaymentAndCreateAppointment(paymentResponse.data.paymentId).subscribe({
                next: (appointmentResponse) => {
                  if (appointmentResponse.success) {
                    this.isProcessing = false;
                    
                    // Store success data for the success page
                    sessionStorage.setItem('paymentSuccess', JSON.stringify({
                      appointment: appointmentResponse.data,
                      payment: paymentResponse.data,
                      appointmentData: this.appointmentData
                    }));
                    
                    // Clear session data
                    sessionStorage.removeItem('pendingAppointment');
                    sessionStorage.removeItem('selectedPaymentMethod');
                    
                    // Navigate to success page
                    this.router.navigate(['/payments/success']);
                  } else {
                    this.isProcessing = false;
                    this.toastService.showError('Appointment creation failed. Please contact support.');
                    console.error('Appointment creation failed:', appointmentResponse);
                  }
                },
                error: (error) => {
                  this.isProcessing = false;
                  this.toastService.showError('Appointment creation failed. Please contact support.');
                  console.error('Appointment creation error:', error);
                }
              });
            }, 2000);
          } else {
            this.isProcessing = false;
            this.toastService.showError('Payment processing failed. Please try again.');
            console.error('Payment failed:', paymentResponse);
          }
        },
        error: (error) => {
          this.isProcessing = false;
          this.toastService.showError('Payment processing failed. Please try again.');
          console.error('Payment error:', error);
        }
      });
    }
  }

  parseTimeString(timeStr: string) {
    const [hours, minutes, seconds = 0] = timeStr.split(':').map(Number);
    return {
      hour: hours,
      minute: minutes,
      second: seconds,
      nano: 0
    };
  }

  goBack(): void {
    this.router.navigate(['/payments/select']);
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
}
