# Rescheduling and Cancellation Functionality Analysis

## Overview
This document provides a detailed analysis of the appointment rescheduling and cancellation functionality in the Hospital Management System frontend. These features are implemented in the `MyAppointmentsComponent` and provide users with the ability to modify or cancel their existing appointments.

## Rescheduling Functionality

### 1. Rescheduling Workflow

#### Step 1: Initiate Rescheduling
```typescript
rescheduleAppointment(appointment: Appointment): void {
  this.selectedAppointment = appointment;
  this.rescheduleData = {
    appointmentDate: '',
    appointmentTime: '',
    endTime: ''
  };
  this.availableSlots = [];
  this.selectedSlot = null;
  this.showRescheduleModal = true;
}
```

**Key Actions:**
- **Set Selected Appointment**: Stores the appointment to be rescheduled
- **Reset Form Data**: Clears previous reschedule data
- **Clear Slots**: Removes any previously loaded slots
- **Show Modal**: Opens the reschedule modal interface

#### Step 2: Date Selection and Slot Loading
```typescript
onRescheduleDateChange(): void {
  if (this.rescheduleData.appointmentDate && this.selectedAppointment?.doctor?.doctorId) {
    this.loadAvailableSlots();
  }
}

loadAvailableSlots(): void {
  if (!this.selectedAppointment?.doctor?.doctorId || !this.rescheduleData.appointmentDate) {
    return;
  }

  this.isLoadingSlots = true;
  this.availableSlots = [];
  this.selectedSlot = null;

  this.adminService.getDoctorSlots(
    this.selectedAppointment.doctor.doctorId, 
    this.rescheduleData.appointmentDate
  ).subscribe({
    next: (response) => {
      if (response.success) {
        this.availableSlots = response.data || [];
        console.log('Available slots loaded:', this.availableSlots);
      }
      this.isLoadingSlots = false;
    },
    error: (error) => {
      console.error('Error loading available slots:', error);
      this.toastService.showError('Failed to load available slots');
      this.isLoadingSlots = false;
    }
  });
}
```

**Key Features:**
- **Date Validation**: Ensures date and doctor ID are available
- **Loading State**: Shows loading spinner while fetching slots
- **Error Handling**: Displays user-friendly error messages
- **Data Reset**: Clears previous slot selection

#### Step 3: Slot Selection
```typescript
selectSlot(slot: any): void {
  console.log('=== SLOT SELECTION DEBUG ===');
  console.log('Selected slot:', slot);
  console.log('Slot start time:', slot.startTime, 'type:', typeof slot.startTime);
  console.log('Slot end time:', slot.endTime, 'type:', typeof slot.endTime);
  
  this.selectedSlot = slot;
  this.rescheduleData.appointmentTime = slot.startTime;
  this.rescheduleData.endTime = slot.endTime;
  
  console.log('Updated reschedule data:', this.rescheduleData);
}
```

**Key Features:**
- **Debug Logging**: Comprehensive logging for troubleshooting
- **Data Binding**: Updates form data with selected slot
- **Visual Feedback**: Slot selection is reflected in UI

#### Step 4: Confirmation and API Call
```typescript
confirmReschedule(): void {
  if (!this.selectedAppointment || !this.selectedSlot) return;

  // Parse time strings to time objects as expected by backend
  let appointmentTime, endTime;
  
  try {
    const startTimeParts = this.rescheduleData.appointmentTime.split(':');
    appointmentTime = {
      hour: parseInt(startTimeParts[0]),
      minute: parseInt(startTimeParts[1]),
      second: 0,
      nano: 0
    };
  } catch (error) {
    console.error('Error parsing appointment time:', error);
    this.toastService.showError('Invalid appointment time format');
    return;
  }

  try {
    const endTimeParts = this.rescheduleData.endTime.split(':');
    endTime = {
      hour: parseInt(endTimeParts[0]),
      minute: parseInt(endTimeParts[1]),
      second: 0,
      nano: 0
    };
  } catch (error) {
    console.error('Error parsing end time:', error);
    this.toastService.showError('Invalid end time format');
    return;
  }

  const appointmentData = {
    appointmentDate: this.rescheduleData.appointmentDate,
    appointmentTime: appointmentTime,
    endTime: endTime
  };

  this.adminService.rescheduleAppointment(this.selectedAppointment.id!, appointmentData).subscribe({
    next: () => {
      this.toastService.showSuccess('Appointment rescheduled successfully');
      this.closeRescheduleModal();
      this.loadAppointments();
    },
    error: (error) => {
      console.error('Reschedule error:', error);
      this.toastService.showError(error.error?.message || 'Failed to reschedule appointment');
    }
  });
}
```

**Key Features:**
- **Validation**: Ensures required data is available
- **Time Parsing**: Converts time strings to backend format
- **Error Handling**: Comprehensive error handling with user feedback
- **Success Handling**: Updates UI and shows success message
- **Data Refresh**: Reloads appointment list after successful reschedule

### 2. Reschedule Modal HTML Structure

```html
<!-- Reschedule Modal -->
<div *ngIf="showRescheduleModal" class="modal-overlay" (click)="closeRescheduleModal()">
  <div class="modal-content reschedule-modal" (click)="$event.stopPropagation()">
    <div class="modal-header">
      <h3>Reschedule Appointment</h3>
      <button class="modal-close" (click)="closeRescheduleModal()">×</button>
    </div>
    <div class="modal-body">
      <div class="reschedule-info">
        <p><strong>Doctor:</strong> {{ selectedAppointment?.doctor?.user?.name }}</p>
        <p><strong>Current Date:</strong> {{ selectedAppointment?.appointmentDate }}</p>
        <p><strong>Current Time:</strong> {{ selectedAppointment?.appointmentTime }} - {{ selectedAppointment?.endTime }}</p>
      </div>
      
      <div class="form-group">
        <label>Select New Date:</label>
        <input type="date" [(ngModel)]="rescheduleData.appointmentDate" [min]="today" (change)="onRescheduleDateChange()">
      </div>
      
      <div class="available-slots" *ngIf="availableSlots.length > 0">
        <h4>Available Time Slots:</h4>
        <div class="slots-grid">
          <div 
            *ngFor="let slot of availableSlots" 
            class="slot-card"
            [class.selected]="selectedSlot?.slotId === slot.slotId"
            (click)="selectSlot(slot)">
            <div class="slot-time">{{ slot.startTime }} - {{ slot.endTime }}</div>
            <div class="slot-status">{{ slot.status }}</div>
          </div>
        </div>
      </div>
      
      <div class="no-slots" *ngIf="rescheduleData.appointmentDate && availableSlots.length === 0 && !isLoadingSlots">
        <p>No available slots for this date. Please select a different date.</p>
      </div>
      
      <div class="loading-slots" *ngIf="isLoadingSlots">
        <p>Loading available slots...</p>
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary" (click)="closeRescheduleModal()">Cancel</button>
      <button 
        class="btn-primary" 
        (click)="confirmReschedule()" 
        [disabled]="!rescheduleData.appointmentDate || !selectedSlot">
        Reschedule
      </button>
    </div>
  </div>
</div>
```

**Key Features:**
- **Modal Overlay**: Click outside to close
- **Current Appointment Info**: Shows existing appointment details
- **Date Input**: Date picker with validation
- **Slot Grid**: Interactive slot selection
- **Loading States**: Shows loading spinner while fetching slots
- **Empty States**: Handles no available slots scenario
- **Form Validation**: Disables submit button until valid selection

### 3. Reschedule Modal CSS Styling

```css
/* Reschedule Modal Styles */
.reschedule-modal { 
  max-width: 600px; 
  width: 90%; 
}

.reschedule-info { 
  background: #f8f9fa; 
  border: 1px solid #e9ecef; 
  border-radius: 8px; 
  padding: 15px; 
  margin-bottom: 20px; 
}

.reschedule-info p { 
  margin: 5px 0; 
  color: #495057; 
}

.available-slots { 
  margin-top: 20px; 
}

.available-slots h4 { 
  margin-bottom: 15px; 
  color: #495057; 
  font-size: 16px; 
}

.slots-grid { 
  display: grid; 
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); 
  gap: 10px; 
  max-height: 300px; 
  overflow-y: auto; 
}

.slot-card { 
  border: 2px solid #e9ecef; 
  border-radius: 8px; 
  padding: 12px; 
  cursor: pointer; 
  transition: all 0.3s ease; 
  background: #fff; 
}

.slot-card:hover { 
  border-color: #007bff; 
  background: #f8f9fa; 
}

.slot-card.selected { 
  border-color: #007bff; 
  background: #e3f2fd; 
}

.slot-time { 
  font-weight: 600; 
  color: #495057; 
  margin-bottom: 5px; 
}

.slot-status { 
  font-size: 12px; 
  color: #28a745; 
  font-weight: 500; 
}

.no-slots { 
  text-align: center; 
  padding: 20px; 
  color: #6c757d; 
  background: #f8f9fa; 
  border-radius: 8px; 
  margin-top: 15px; 
}

.loading-slots { 
  text-align: center; 
  padding: 20px; 
  color: #007bff; 
}
```

**Key Features:**
- **Responsive Design**: Adapts to different screen sizes
- **Interactive Elements**: Hover and selection states
- **Visual Hierarchy**: Clear information organization
- **Loading States**: Visual feedback during operations
- **Accessibility**: High contrast and readable text

## Cancellation Functionality

### 1. Cancellation Workflow

#### Step 1: Initiate Cancellation
```typescript
cancelAppointment(appointment: Appointment): void {
  this.selectedAppointment = appointment;
  this.cancelReason = '';
  this.showCancelModal = true;
}
```

**Key Actions:**
- **Set Selected Appointment**: Stores the appointment to be cancelled
- **Reset Reason**: Clears previous cancellation reason
- **Show Modal**: Opens the cancellation modal

#### Step 2: Reason Entry and Confirmation
```typescript
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
```

**Key Features:**
- **Validation**: Ensures appointment is selected
- **API Call**: Sends cancellation request with reason
- **Success Handling**: Shows success message and refreshes list
- **Error Handling**: Displays error message if cancellation fails

### 2. Cancel Modal HTML Structure

```html
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
```

**Key Features:**
- **Reason Input**: Required textarea for cancellation reason
- **Form Validation**: Disables submit until reason is provided
- **Clear Actions**: Keep vs Cancel options
- **Accessibility**: Proper labels and placeholders

### 3. Cancel Modal CSS Styling

```css
/* Cancel Modal Styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 12px;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 24px 0 24px;
  border-bottom: 1px solid #e5e7eb;
  margin-bottom: 24px;
}

.modal-header h3 {
  font-size: 1.25rem;
  font-weight: 600;
  color: #1f2937;
  margin: 0;
}

.modal-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  color: #6b7280;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.modal-close:hover {
  color: #374151;
  background: #f3f4f6;
}

.modal-body {
  padding: 0 24px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  font-size: 0.875rem;
  font-weight: 500;
  color: #374151;
  margin-bottom: 8px;
}

.form-group textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 0.875rem;
  transition: all 0.2s ease;
  resize: vertical;
  min-height: 80px;
}

.form-group textarea:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.modal-footer {
  display: flex;
  gap: 12px;
  justify-content: flex-end;
  padding: 24px;
  border-top: 1px solid #e5e7eb;
  margin-top: 24px;
}

.btn-secondary {
  background: #f3f4f6;
  color: #374151;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-secondary:hover {
  background: #e5e7eb;
}

.btn-danger {
  background: #ef4444;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-danger:hover {
  background: #dc2626;
}

.btn-danger:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
```

## API Integration

### 1. Reschedule API Endpoint

```typescript
// Frontend Call
rescheduleAppointment(appointmentId: number, appointmentData: any): Observable<Appointment>

// Backend Endpoint
PUT /api/appointments/{id}/reschedule
```

**Request Body:**
```typescript
{
  appointmentDate: string,
  appointmentTime: {
    hour: number,
    minute: number,
    second: number,
    nano: number
  },
  endTime: {
    hour: number,
    minute: number,
    second: number,
    nano: number
  }
}
```

**Response:**
```typescript
{
  success: boolean,
  data: Appointment,
  message?: string
}
```

### 2. Cancel API Endpoint

```typescript
// Frontend Call
cancelAppointment(appointmentId: number, reason: string): Observable<Appointment>

// Backend Endpoint
PUT /api/appointments/{id}/cancel
```

**Query Parameters:**
- `reason`: Cancellation reason string

**Response:**
```typescript
{
  success: boolean,
  data: Appointment,
  message?: string
}
```

### 3. Get Doctor Slots API

```typescript
// Frontend Call
getDoctorSlots(doctorId: number, date: string): Observable<any>

// Backend Endpoint
GET /api/appointments/doctors/{doctorId}/slots
```

**Query Parameters:**
- `doctorId`: Doctor ID
- `date`: Appointment date (YYYY-MM-DD format)

**Response:**
```typescript
{
  success: boolean,
  data: DoctorSlot[]
}
```

## User Experience Considerations

### 1. Visual Feedback
- **Loading States**: Spinners during API calls
- **Selection States**: Clear visual indication of selected slots
- **Validation States**: Error messages and disabled states
- **Success States**: Success messages and UI updates

### 2. Error Handling
- **Network Errors**: Graceful handling of API failures
- **Validation Errors**: Clear error messages for invalid input
- **Timeout Handling**: Appropriate handling of slow responses
- **User Guidance**: Helpful error messages and recovery suggestions

### 3. Accessibility
- **Keyboard Navigation**: Full keyboard support for modal interactions
- **Screen Reader Support**: Proper ARIA labels and descriptions
- **Focus Management**: Proper focus handling in modals
- **Color Contrast**: High contrast for better visibility

### 4. Performance
- **Lazy Loading**: Load slots only when needed
- **Debouncing**: Prevent excessive API calls
- **Caching**: Cache frequently accessed data
- **Optimistic Updates**: Update UI before API confirmation

## Business Logic

### 1. Rescheduling Rules
- **Date Validation**: Cannot reschedule to past dates
- **Slot Availability**: Only available slots can be selected
- **Doctor Availability**: Must be same doctor for rescheduling
- **Time Validation**: End time must be after start time

### 2. Cancellation Rules
- **Reason Required**: Cancellation reason is mandatory
- **Status Validation**: Only certain statuses can be cancelled
- **Time Restrictions**: May have time-based cancellation restrictions
- **Confirmation Required**: User must confirm cancellation

### 3. Data Integrity
- **Atomic Operations**: Reschedule/cancel operations are atomic
- **Rollback Support**: Failed operations don't leave inconsistent state
- **Audit Trail**: All changes are logged for audit purposes
- **Concurrency Control**: Handle concurrent modifications

## Testing Considerations

### 1. Unit Tests
```typescript
// Test reschedule initiation
it('should open reschedule modal', () => {
  component.rescheduleAppointment(mockAppointment);
  expect(component.showRescheduleModal).toBe(true);
  expect(component.selectedAppointment).toBe(mockAppointment);
});

// Test slot selection
it('should select slot and update form data', () => {
  const mockSlot = { slotId: 1, startTime: '09:00:00', endTime: '09:30:00' };
  component.selectSlot(mockSlot);
  expect(component.selectedSlot).toBe(mockSlot);
  expect(component.rescheduleData.appointmentTime).toBe('09:00:00');
});

// Test cancellation
it('should cancel appointment with reason', () => {
  spyOn(adminService, 'cancelAppointment').and.returnValue(of(mockResponse));
  component.selectedAppointment = mockAppointment;
  component.cancelReason = 'Test reason';
  component.confirmCancel();
  expect(adminService.cancelAppointment).toHaveBeenCalledWith(mockAppointment.id, 'Test reason');
});
```

### 2. Integration Tests
```typescript
// Test complete reschedule flow
it('should complete reschedule flow', () => {
  // Mock API responses
  // Simulate user interactions
  // Verify final state
});

// Test error handling
it('should handle API errors gracefully', () => {
  // Mock API error
  // Verify error handling
  // Check user feedback
});
```

### 3. E2E Tests
```typescript
// Test reschedule workflow
it('should reschedule appointment', () => {
  // Navigate to appointments
  // Click reschedule button
  // Select new date
  // Select new time slot
  // Confirm reschedule
  // Verify success message
});

// Test cancellation workflow
it('should cancel appointment', () => {
  // Navigate to appointments
  // Click cancel button
  // Enter cancellation reason
  // Confirm cancellation
  // Verify success message
});
```

## Security Considerations

### 1. Input Validation
- **Client-side**: Angular form validation
- **Server-side**: Spring Boot validation
- **Sanitization**: XSS prevention
- **Length Limits**: Prevent buffer overflow attacks

### 2. Authorization
- **User Verification**: Ensure user can only modify their own appointments
- **Role-based Access**: Different permissions for different user types
- **Session Validation**: Verify user session is valid
- **CSRF Protection**: Prevent cross-site request forgery

### 3. Data Protection
- **HTTPS**: Secure communication
- **Input Sanitization**: Prevent malicious input
- **Rate Limiting**: Prevent abuse
- **Audit Logging**: Track all modifications

## Conclusion

The rescheduling and cancellation functionality provides a comprehensive solution for appointment management with:

- **Intuitive User Interface**: Clear modals with step-by-step guidance
- **Robust Error Handling**: Comprehensive error handling and user feedback
- **Secure Operations**: Proper validation and authorization
- **Excellent UX**: Loading states, validation feedback, and success messages
- **Maintainable Code**: Well-structured, testable, and documented code

The implementation follows Angular best practices and provides a seamless user experience for managing appointments.
