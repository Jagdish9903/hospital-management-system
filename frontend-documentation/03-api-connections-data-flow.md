# Frontend-Backend API Connections and Data Flow

## Overview
This document details how the Angular frontend connects to the Spring Boot backend, the API endpoints used, data flow patterns, and the integration between appointment management components.

## API Service Architecture

### AdminService - Central API Service
The `AdminService` is the central service that handles all API communications between the frontend and backend.

```typescript
@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) { }
}
```

**Key Features:**
- **Singleton Service**: Provided at root level for application-wide access
- **Environment Configuration**: Uses `environment.apiUrl` for API base URL
- **HTTP Client**: Angular's HttpClient for making HTTP requests
- **Type Safety**: Strongly typed interfaces for all API responses

## API Endpoints and Data Flow

### 1. User Authentication and Profile

#### Get Current User Profile
```typescript
// Frontend Call
this.http.get<any>(`${environment.apiUrl}/api/simple-profile/user/${currentUser.id}`)

// Backend Endpoint
GET /api/simple-profile/user/{userId}
```

**Data Flow:**
1. **Frontend**: `loadUserProfile()` method calls API
2. **Backend**: Returns user profile data
3. **Frontend**: Stores in `userProfile` property for receipt generation

**Response Structure:**
```typescript
{
  success: boolean,
  data: {
    id: number,
    name: string,
    email: string,
    contact: string,
    address: string,
    // ... other user fields
  }
}
```

### 2. Appointment Management APIs

#### Get User Appointments (Paginated)
```typescript
// Frontend Call
getUserAppointmentsPaginated(userId: number, page: number, size: number, sortBy: string, sortDir: string, status?: string, type?: string): Observable<any>

// Backend Endpoint
GET /api/appointments/patient/{userId}/paginated
```

**Query Parameters:**
- `page`: Page number (0-based)
- `size`: Number of items per page
- `sortBy`: Field to sort by (e.g., 'appointmentDate')
- `sortDir`: Sort direction ('asc' or 'desc')
- `status`: Filter by appointment status
- `type`: Filter by appointment type ('upcoming' or 'past')

**Data Flow:**
1. **Frontend**: `loadAppointments()` method in MyAppointmentsComponent
2. **Backend**: Returns paginated appointment data
3. **Frontend**: Updates component state with appointments, pagination info

**Response Structure:**
```typescript
{
  success: boolean,
  data: {
    appointments: Appointment[],
    currentPage: number,
    totalPages: number,
    totalElements: number
  }
}
```

#### Get Available Slots for Booking
```typescript
// Frontend Call
getAvailableSlots(specializationId: number, date: string): Observable<any>

// Backend Endpoint
GET /api/appointments/available-slots
```

**Query Parameters:**
- `specializationId`: Medical specialization ID
- `date`: Appointment date (YYYY-MM-DD format)

**Data Flow:**
1. **Frontend**: `searchAppointments()` method in ScheduleAppointmentComponent
2. **Backend**: Returns available time slots for the specified specialization and date
3. **Frontend**: Groups slots by doctor using `groupSlotsByDoctor()` method

**Response Structure:**
```typescript
{
  success: boolean,
  data: DoctorSlot[]
}
```

#### Get Doctor Slots for Rescheduling
```typescript
// Frontend Call
getDoctorSlots(doctorId: number, date: string): Observable<any>

// Backend Endpoint
GET /api/appointments/doctors/{doctorId}/slots
```

**Query Parameters:**
- `doctorId`: Doctor ID
- `date`: Appointment date (YYYY-MM-DD format)

**Data Flow:**
1. **Frontend**: `loadAvailableSlots()` method in MyAppointmentsComponent
2. **Backend**: Returns available slots for specific doctor and date
3. **Frontend**: Displays slots in reschedule modal

#### Book New Appointment
```typescript
// Frontend Call
bookAppointment(bookingData: any): Observable<any>

// Backend Endpoint
POST /api/appointments
```

**Request Body:**
```typescript
{
  patientId: number,
  doctorId: number,
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
  },
  appointmentType: string,
  consultationFee: number,
  symptoms: string,
  notes: string
}
```

**Data Flow:**
1. **Frontend**: `bookAppointment()` method in ScheduleAppointmentComponent
2. **Backend**: Creates new appointment record
3. **Frontend**: Shows success message and navigation options

#### Reschedule Appointment
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

**Data Flow:**
1. **Frontend**: `confirmReschedule()` method in MyAppointmentsComponent
2. **Backend**: Updates appointment with new date/time
3. **Frontend**: Refreshes appointment list

#### Cancel Appointment
```typescript
// Frontend Call
cancelAppointment(appointmentId: number, reason: string): Observable<Appointment>

// Backend Endpoint
PUT /api/appointments/{id}/cancel
```

**Query Parameters:**
- `reason`: Cancellation reason

**Data Flow:**
1. **Frontend**: `confirmCancel()` method in MyAppointmentsComponent
2. **Backend**: Updates appointment status to 'CANCELLED'
3. **Frontend**: Refreshes appointment list

### 3. Specialization Management

#### Get Appointment Specializations
```typescript
// Frontend Call
getAppointmentSpecializations(): Observable<any>

// Backend Endpoint
GET /api/appointments/specializations
```

**Data Flow:**
1. **Frontend**: `loadSpecializations()` method in ScheduleAppointmentComponent
2. **Backend**: Returns available medical specializations
3. **Frontend**: Populates specialization dropdown

## Data Transformation Patterns

### 1. Time String to Time Object Conversion

**Frontend to Backend:**
```typescript
// Frontend: Time string from API response
const timeString = "09:30:00";

// Conversion function
const parseTimeString = (timeStr: string) => {
  const [hours, minutes, seconds = 0] = timeStr.split(':').map(Number);
  return {
    hour: hours,
    minute: minutes,
    second: seconds,
    nano: 0
  };
};

// Backend: Time object for API request
const timeObject = parseTimeString(timeString);
// Result: { hour: 9, minute: 30, second: 0, nano: 0 }
```

**Backend to Frontend:**
```typescript
// Backend: Time object in API response
const timeObject = { hour: 9, minute: 30, second: 0, nano: 0 };

// Frontend: Convert to display string
const formatTime = (time: string) => {
  return new Date(`2000-01-01T${time}`).toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  });
};
```

### 2. Date Formatting

**Frontend Display:**
```typescript
// API Response: "2024-01-15"
const apiDate = "2024-01-15";

// Display Format: "Monday, January 15, 2024"
const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('en-US', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};
```

### 3. Data Grouping

**Slot Grouping by Doctor:**
```typescript
groupSlotsByDoctor(): void {
  const groupedSlots = new Map();
  
  this.availableSlots.forEach((slot) => {
    const doctorId = slot.doctor.doctorId;
    
    if (!groupedSlots.has(doctorId)) {
      groupedSlots.set(doctorId, {
        doctor: slot.doctor,
        slots: []
      });
    }
    groupedSlots.get(doctorId).slots.push(slot);
  });
  
  this.availableSlots = Array.from(groupedSlots.values());
}
```

## Error Handling Patterns

### 1. HTTP Error Handling
```typescript
this.adminService.getUserAppointmentsPaginated(...).subscribe({
  next: (data) => {
    // Handle success
    this.appointments = data.appointments;
    this.isLoading = false;
  },
  error: (error) => {
    // Handle error
    this.isLoading = false;
    this.hasFilteredResults = false;
    console.error('Error loading appointments:', error);
    this.toastService.showError('Failed to load appointments');
  }
});
```

### 2. Form Validation
```typescript
// Reactive Form Validation
this.bookingForm = this.fb.group({
  symptoms: ['', [Validators.required, Validators.minLength(10)]],
  notes: ['', [Validators.maxLength(500)]]
});

// Template Validation
<div *ngIf="bookingForm.get('symptoms')?.invalid && bookingForm.get('symptoms')?.touched" 
     class="form-error">
  Please describe your symptoms (minimum 10 characters)
</div>
```

### 3. Loading States
```typescript
// Component Properties
isLoading = false;
isBooking = false;
isLoadingSlots = false;

// Usage in Methods
loadAppointments(): void {
  this.isLoading = true;
  // API call
  // Set this.isLoading = false in success/error handlers
}
```

## State Management Patterns

### 1. Component State
```typescript
// Appointment Data
appointments: Appointment[] = [];
selectedAppointment: Appointment | null = null;

// UI State
showRescheduleModal = false;
showCancelModal = false;
isLoading = false;

// Form Data
rescheduleData = { appointmentDate: '', appointmentTime: '', endTime: '' };
cancelReason = '';
```

### 2. Session Storage
```typescript
// Store appointment data for payment flow
const appointmentData = {
  slotId: this.selectedSlot.slotId,
  patientId: this.currentUser.id,
  doctorId: this.selectedDoctor.doctorId,
  appointmentDate: this.searchForm.value.appointmentDate,
  // ... other data
};

sessionStorage.setItem('pendingAppointment', JSON.stringify(appointmentData));
```

### 3. Service State
```typescript
// AdminService maintains API configuration
private apiUrl = environment.apiUrl;

// AuthService maintains user state
getCurrentUser(): User | null {
  // Returns current authenticated user
}
```

## API Response Handling

### 1. Standardized Response Format
```typescript
interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}
```

### 2. Response Processing
```typescript
// Extract data from API response
this.adminService.getAvailableSlots(...).subscribe({
  next: (response) => {
    if (response.success) {
      this.availableSlots = response.data || [];
    }
  }
});
```

### 3. Error Response Handling
```typescript
error: (error) => {
  console.error('Error loading available slots:', error);
  this.toastService.showError('Failed to load available slots');
  this.isLoadingSlots = false;
}
```

## Authentication and Authorization

### 1. JWT Token Handling
```typescript
// AuthService manages JWT tokens
getCurrentUser(): User | null {
  const token = localStorage.getItem('token');
  if (token) {
    // Decode and return user data
  }
  return null;
}
```

### 2. HTTP Interceptor
```typescript
// AuthInterceptor adds JWT token to requests
intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
  const token = localStorage.getItem('token');
  if (token) {
    req = req.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`
      }
    });
  }
  return next.handle(req);
}
```

## Data Flow Diagrams

### 1. Appointment Booking Flow
```
User Input → Form Validation → API Call → Backend Processing → Database Update → Success Response → UI Update
```

### 2. Appointment Rescheduling Flow
```
Select Appointment → Open Modal → Load Available Slots → Select New Slot → API Call → Update Database → Refresh List
```

### 3. Appointment Cancellation Flow
```
Select Appointment → Open Modal → Enter Reason → API Call → Update Status → Refresh List
```

## Performance Optimizations

### 1. Pagination
```typescript
// Frontend pagination reduces data transfer
get paginatedSlots(): any[] {
  const startIndex = (this.currentPage - 1) * this.itemsPerPage;
  const endIndex = startIndex + this.itemsPerPage;
  return this.availableSlots.slice(startIndex, endIndex);
}
```

### 2. Lazy Loading
```typescript
// Load data only when needed
ngOnInit(): void {
  this.loadSpecializations();
  this.loadCurrentUser();
  this.loadUserProfile();
}
```

### 3. Caching
```typescript
// Cache user profile data
loadUserProfile(): void {
  if (this.userProfile) {
    return; // Already loaded
  }
  // Load from API
}
```

## Security Considerations

### 1. Input Validation
```typescript
// Frontend validation
symptoms: ['', [Validators.required, Validators.minLength(10)]]

// Backend validation (Spring Boot)
@NotNull
@Size(min = 10, message = "Symptoms must be at least 10 characters")
private String symptoms;
```

### 2. XSS Prevention
```typescript
// Angular automatically sanitizes HTML content
<div>{{ appointment.symptoms }}</div>
```

### 3. CSRF Protection
```typescript
// Spring Boot provides CSRF protection by default
// Angular includes CSRF token in requests automatically
```

## Testing Considerations

### 1. Unit Testing
```typescript
// Test component methods
it('should load appointments', () => {
  component.loadAppointments();
  expect(component.isLoading).toBe(true);
});
```

### 2. Integration Testing
```typescript
// Test API integration
it('should call getUserAppointmentsPaginated', () => {
  spyOn(adminService, 'getUserAppointmentsPaginated').and.returnValue(of(mockData));
  component.loadAppointments();
  expect(adminService.getUserAppointmentsPaginated).toHaveBeenCalled();
});
```

### 3. E2E Testing
```typescript
// Test complete user flows
it('should book appointment', () => {
  // Navigate to schedule appointment
  // Fill form
  // Submit
  // Verify success message
});
```

This comprehensive API integration ensures robust communication between the Angular frontend and Spring Boot backend, with proper error handling, data transformation, and user experience optimization.
