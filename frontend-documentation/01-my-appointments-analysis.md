# My Appointments Component Analysis

## Overview
The `MyAppointmentsComponent` is a comprehensive Angular component that allows patients to view, manage, and reschedule their appointments. It provides a tabbed interface for upcoming and past appointments with advanced filtering, sorting, and pagination capabilities.

## File Structure
- **TypeScript**: `my-appointments.component.ts` (339 lines)
- **HTML Template**: `my-appointments.component.html` (289 lines)
- **CSS Styles**: `my-appointments.component.css` (914 lines)

## Component Architecture

### 1. Component Declaration and Imports

```typescript
@Component({
  selector: 'app-my-appointments',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './my-appointments.component.html',
  styleUrls: ['./my-appointments.component.css']
})
export class MyAppointmentsComponent implements OnInit
```

**Key Points:**
- **Standalone Component**: Uses Angular's standalone component architecture (no NgModule required)
- **Imports**: `CommonModule` for basic Angular directives, `FormsModule` for two-way data binding
- **OnInit Interface**: Implements lifecycle hook for initialization logic

### 2. Component Properties

#### State Management Properties
```typescript
activeTab: 'upcoming' | 'past' = 'upcoming';
appointments: Appointment[] = [];
appointmentStats = { totalUpcoming: 0, totalPast: 0 };
```

**Purpose:**
- `activeTab`: Controls which tab is currently active (upcoming or past appointments)
- `appointments`: Array holding the current page of appointments
- `appointmentStats`: Statistics for dashboard display (currently commented out in template)

#### Pagination Properties
```typescript
currentPage = 0;
pageSize = 10;
totalPages = 0;
totalElements = 0;
pageSizeOptions = [5, 10, 20, 50];
sortBy = 'appointmentDate';
sortDir = 'desc';
statusFilter = '';
```

**Purpose:**
- **Pagination Control**: Manages which page of results to display
- **Page Size Options**: Allows users to choose how many appointments per page
- **Sorting**: Default sort by appointment date in descending order (newest first)
- **Filtering**: Status-based filtering for appointments

#### Modal and Form Properties
```typescript
showRescheduleModal = false;
showCancelModal = false;
selectedAppointment: Appointment | null = null;
rescheduleData = { appointmentDate: '', appointmentTime: '', endTime: '' };
cancelReason = '';
today = new Date().toISOString().split('T')[0];
```

**Purpose:**
- **Modal States**: Control visibility of reschedule and cancel modals
- **Selected Appointment**: Tracks which appointment is being modified
- **Reschedule Data**: Stores new appointment details for rescheduling
- **Cancel Reason**: Captures reason for appointment cancellation
- **Today**: Current date for date validation (prevents past date selection)

#### Loading and UI States
```typescript
isLoading = false;
hasFilteredResults = true;
availableSlots: any[] = [];
selectedSlot: any = null;
isLoadingSlots = false;
```

**Purpose:**
- **Loading States**: Control loading spinners and disable interactions
- **Results State**: Track if filtered results exist
- **Slot Management**: Handle available time slots for rescheduling

### 3. Constructor and Dependency Injection

```typescript
constructor(
  private adminService: AdminService,
  private authService: AuthService,
  private toastService: ToastService,
  private router: Router
) {}
```

**Dependencies:**
- **AdminService**: Handles all API calls for appointment management
- **AuthService**: Manages user authentication and current user data
- **ToastService**: Displays success/error messages to users
- **Router**: Handles navigation between components

### 4. Core Methods Analysis

#### loadAppointments() Method
```typescript
loadAppointments(): void {
  const currentUser = this.authService.getCurrentUser();
  if (!currentUser?.id) {
    this.toastService.showError('User not authenticated');
    return;
  }

  this.isLoading = true;
  
  // Determine status filter based on active tab
  let statusFilter = this.statusFilter;
  if (this.activeTab === 'upcoming') {
    statusFilter = this.statusFilter === 'CANCELLED' ? '' : this.statusFilter;
  } else if (this.activeTab === 'past') {
    statusFilter = this.statusFilter;
  }

  this.adminService.getUserAppointmentsPaginated(
    currentUser.id, 
    this.currentPage, 
    this.pageSize, 
    this.sortBy, 
    this.sortDir, 
    statusFilter, 
    this.activeTab
  ).subscribe({
    next: (data) => {
      this.appointments = data.appointments;
      this.currentPage = data.currentPage;
      this.totalPages = data.totalPages;
      this.totalElements = data.totalElements;
      this.hasFilteredResults = data.totalElements > 0;
      this.isLoading = false;
      console.log('Appointments loaded:', this.appointments);
    },
    error: (error) => {
      this.isLoading = false;
      this.hasFilteredResults = false;
      console.error('Error loading appointments:', error);
      this.toastService.showError('Failed to load appointments');
    }
  });
}
```

**Key Features:**
1. **Authentication Check**: Verifies user is logged in before making API call
2. **Smart Filtering**: Automatically excludes cancelled appointments from upcoming tab
3. **Loading State Management**: Shows loading spinner during API call
4. **Error Handling**: Displays user-friendly error messages
5. **Data Binding**: Updates component state with API response
6. **Debug Logging**: Console logs for development debugging

#### Pagination Methods

##### onPageChange()
```typescript
onPageChange(page: number): void {
  this.currentPage = page;
  this.loadAppointments();
}
```
**Purpose**: Updates current page and reloads appointments

##### onPageSizeChange()
```typescript
onPageSizeChange(size: number): void {
  this.pageSize = size;
  this.currentPage = 0; // Reset to first page
  this.loadAppointments();
}
```
**Purpose**: Changes page size and resets to first page

##### getPageNumbers()
```typescript
getPageNumbers(): number[] {
  const pages: number[] = [];
  const startPage = Math.max(0, this.currentPage - 2);
  const endPage = Math.min(this.totalPages - 1, this.currentPage + 2);
  
  for (let i = startPage; i <= endPage; i++) {
    pages.push(i);
  }
  return pages;
}
```
**Purpose**: Generates page numbers for pagination UI (shows 5 pages around current page)

#### Sorting Methods

##### onSortChange()
```typescript
onSortChange(sortBy: string): void {
  if (this.sortBy === sortBy) {
    this.sortDir = this.sortDir === 'asc' ? 'desc' : 'asc';
  } else {
    this.sortBy = sortBy;
    this.sortDir = 'desc';
  }
  this.currentPage = 0;
  this.loadAppointments();
}
```
**Purpose**: 
- Toggles sort direction if same column is clicked
- Sets new sort column and defaults to descending
- Resets to first page when sorting changes

#### Tab Management

##### setActiveTab()
```typescript
setActiveTab(tab: 'upcoming' | 'past'): void {
  this.activeTab = tab;
  this.statusFilter = ''; // Reset status filter when switching tabs
  this.currentPage = 0; // Reset to first page
  this.loadAppointments();
}
```
**Purpose**: Switches between upcoming and past appointments, resets filters

### 5. Rescheduling Functionality

#### rescheduleAppointment()
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
**Purpose**: Opens reschedule modal and resets form data

#### loadAvailableSlots()
```typescript
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
**Purpose**: Fetches available time slots for selected doctor and date

#### selectSlot()
```typescript
selectSlot(slot: any): void {
  console.log('=== SLOT SELECTION DEBUG ===');
  console.log('Selected slot:', slot);
  
  this.selectedSlot = slot;
  this.rescheduleData.appointmentTime = slot.startTime;
  this.rescheduleData.endTime = slot.endTime;
  
  console.log('Updated reschedule data:', this.rescheduleData);
}
```
**Purpose**: Handles slot selection and updates form data

#### confirmReschedule()
```typescript
confirmReschedule(): void {
  if (!this.selectedAppointment || !this.selectedSlot) return;

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

  const appointmentData = {
    appointmentDate: this.rescheduleData.appointmentDate,
    appointmentTime: parseTimeString(this.rescheduleData.appointmentTime),
    endTime: parseTimeString(this.rescheduleData.endTime)
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
**Purpose**: 
- Validates selected appointment and slot
- Converts time strings to backend-expected format
- Calls API to reschedule appointment
- Handles success/error responses

### 6. Cancellation Functionality

#### cancelAppointment()
```typescript
cancelAppointment(appointment: Appointment): void {
  this.selectedAppointment = appointment;
  this.cancelReason = '';
  this.showCancelModal = true;
}
```
**Purpose**: Opens cancel modal and resets reason field

#### confirmCancel()
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
**Purpose**: Calls API to cancel appointment with reason

### 7. Utility Methods

#### Date and Time Formatting
```typescript
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
```
**Purpose**: Format dates and times for display in user-friendly format

#### Business Logic Methods
```typescript
isAppointmentUpcoming(appointment: Appointment): boolean {
  const appointmentDate = new Date(appointment.appointmentDate);
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return appointmentDate >= today && appointment.status !== 'CANCELLED';
}

shouldShowActions(appointment: Appointment): boolean {
  return this.activeTab === 'upcoming' && this.isAppointmentUpcoming(appointment);
}
```
**Purpose**: Determine if appointment is upcoming and if actions should be shown

## HTML Template Analysis

### 1. Component Structure
```html
<div class="appointments-container">
  <div class="appointments-header">
    <h1>My Appointments</h1>
  </div>
  
  <div class="appointments-tabs">
    <!-- Tab buttons -->
  </div>
  
  <div class="appointments-content">
    <!-- Main content area -->
  </div>
</div>
```

### 2. Tab Navigation
```html
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
```
**Features:**
- Dynamic active state using `[class.active]` binding
- Click handlers for tab switching
- Visual feedback for active tab

### 3. Loading State
```html
<div *ngIf="isLoading" class="loading-state">
  <div class="loading-spinner"></div>
  <p>Loading appointments...</p>
</div>
```
**Purpose**: Shows loading spinner while data is being fetched

### 4. Appointments Table
```html
<table class="appointments-table">
  <thead>
    <tr>
      <th class="sortable" (click)="onSortChange('appointmentDate')">
        Date
        <span class="sort-indicator" *ngIf="sortBy === 'appointmentDate'">
          {{ sortDir === 'asc' ? '↑' : '↓' }}
        </span>
      </th>
      <!-- More columns -->
    </tr>
  </thead>
  <tbody>
    <tr *ngFor="let appointment of appointments" class="appointment-row">
      <!-- Appointment data -->
    </tr>
  </tbody>
</table>
```
**Features:**
- Sortable columns with visual indicators
- Dynamic data binding with `*ngFor`
- Responsive table design

### 5. Pagination Controls
```html
<div class="pagination-container">
  <div class="pagination-info">
    Showing {{ (currentPage * pageSize) + 1 }} to {{ Math.min((currentPage + 1) * pageSize, totalElements) }} of {{ totalElements }} appointments
  </div>
  <div class="pagination-controls">
    <!-- Pagination buttons -->
  </div>
</div>
```
**Features:**
- Dynamic page information display
- First/Previous/Next/Last buttons
- Page number buttons with active state

### 6. Modals

#### Reschedule Modal
```html
<div *ngIf="showRescheduleModal" class="modal-overlay" (click)="closeRescheduleModal()">
  <div class="modal-content reschedule-modal" (click)="$event.stopPropagation()">
    <!-- Modal content -->
  </div>
</div>
```
**Features:**
- Backdrop click to close
- Event propagation prevention
- Conditional rendering with `*ngIf`

#### Cancel Modal
```html
<div *ngIf="showCancelModal" class="modal-overlay" (click)="closeCancelModal()">
  <div class="modal-content" (click)="$event.stopPropagation()">
    <!-- Cancel form -->
  </div>
</div>
```

## CSS Styling Analysis

### 1. Container and Layout
```css
.appointments-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
}
```
**Purpose**: Centers content with maximum width constraint

### 2. Tab Styling
```css
.tab-btn {
  background: none;
  border: none;
  padding: 12px 24px;
  font-size: 1rem;
  font-weight: 500;
  color: #6b7280;
  cursor: pointer;
  border-bottom: 2px solid transparent;
  transition: all 0.2s ease;
}

.tab-btn.active {
  color: #3b82f6;
  border-bottom-color: #3b82f6;
}
```
**Features:**
- Clean button styling
- Smooth transitions
- Active state highlighting

### 3. Table Styling
```css
.appointments-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.875rem;
}

.appointments-table thead {
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  border-bottom: 2px solid #e2e8f0;
}
```
**Features:**
- Full-width table
- Gradient header background
- Professional styling

### 4. Status Badges
```css
.appointment-status {
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: inline-block;
}

.status-scheduled {
  background: #dbeafe;
  color: #1e40af;
}

.status-completed {
  background: #dcfce7;
  color: #166534;
}

.status-cancelled {
  background: #fee2e2;
  color: #dc2626;
}
```
**Features:**
- Color-coded status indicators
- Consistent styling across all statuses
- High contrast for accessibility

### 5. Responsive Design
```css
@media (max-width: 768px) {
  .appointments-container {
    padding: 16px;
  }
  
  .appointments-header {
    flex-direction: column;
    gap: 16px;
    align-items: flex-start;
  }
  
  .table-container {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
}
```
**Features:**
- Mobile-first responsive design
- Horizontal scrolling for tables on small screens
- Flexible layout adjustments

## API Integration

### Backend Endpoints Used
1. **GET** `/api/appointments/patient/{userId}/paginated` - Fetch paginated appointments
2. **GET** `/api/appointments/doctors/{doctorId}/slots` - Get available slots for rescheduling
3. **PUT** `/api/appointments/{id}/reschedule` - Reschedule appointment
4. **PUT** `/api/appointments/{id}/cancel` - Cancel appointment

### Data Flow
1. **Component Initialization** → `ngOnInit()` → `loadAppointments()`
2. **User Interaction** → Method calls → API requests
3. **API Response** → State updates → UI updates
4. **Error Handling** → Toast notifications → User feedback

## Key Features Summary

1. **Comprehensive Appointment Management**: View, reschedule, and cancel appointments
2. **Advanced Filtering**: Status-based filtering with smart tab logic
3. **Sorting and Pagination**: Full sorting capabilities with efficient pagination
4. **Modal-based Interactions**: Clean modal interfaces for rescheduling and cancellation
5. **Responsive Design**: Mobile-friendly interface with adaptive layouts
6. **Error Handling**: Comprehensive error handling with user feedback
7. **Loading States**: Visual feedback during API operations
8. **Date/Time Formatting**: User-friendly date and time display
9. **Business Logic**: Smart appointment status determination
10. **Accessibility**: Proper ARIA labels and keyboard navigation support

This component demonstrates modern Angular development practices with clean separation of concerns, reactive programming, and excellent user experience design.
