import { Component, OnInit, ViewChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AdminService, Doctor, User, SearchFilters, PaginatedResponse } from '../../../core/services/admin.service';
import { Subject, debounceTime, distinctUntilChanged } from 'rxjs';
import { CustomValidators } from '../../../shared/validators/custom-validators';

@Component({
  selector: 'app-admin-doctors',
  templateUrl: './admin-doctors.component.html',
  styleUrls: ['./admin-doctors.component.css'],
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  standalone: true
})
export class AdminDoctorsComponent implements OnInit {
  @ViewChild('editModal') editModal!: TemplateRef<any>;
  @ViewChild('deleteModal') deleteModal!: TemplateRef<any>;

  doctors: Doctor[] = [];
  paginatedResponse: PaginatedResponse<Doctor> | null = null;
  isLoading = false;
  searchTerm = '';
  searchSubject = new Subject<string>();
  
  // Make Math available in template
  Math = Math;
  
  // Pagination
  currentPage = 0;
  pageSize = 10;
  totalElements = 0;
  
  // Date restrictions
  maxDate: string = '';
  totalPages = 0;
  
  // Sorting
  sortBy = 'doctorId';
  sortDir: 'asc' | 'desc' = 'asc';
  
  // Filters
  showFilters = false;
  filterForm: FormGroup;
  selectedSpecialization = '';
  selectedStatus = '';
  
  // Edit/Delete/Add
  selectedDoctor: Doctor | null = null;
  showEditModal = false;
  showDeleteModal = false;
  showAddModal = false;
  editForm: FormGroup;
  addForm: FormGroup;
  isSubmitting = false;
  
  // Data for dropdowns
  specializations: any[] = [];
  
  // Table columns
  columns = [
    { key: 'doctorId', label: 'ID', sortable: true },
    { key: 'name', label: 'Doctor Name', sortable: true },
    { key: 'email', label: 'Email', sortable: true },
    { key: 'specialization', label: 'Specialization', sortable: true },
    { key: 'licenseNumber', label: 'License', sortable: true },
    { key: 'qualification', label: 'Qualification', sortable: true },
    { key: 'consultationFee', label: 'Fee', sortable: true },
    { key: 'active', label: 'Status', sortable: true },
    { key: 'actions', label: 'Actions', sortable: false }
  ];


  statuses = [
    { value: '', label: 'All Status' },
    { value: 'true', label: 'Active' },
    { value: 'false', label: 'Inactive' }
  ];

  constructor(
    private adminService: AdminService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      specialization: [''],
      active: ['']
    });

    this.editForm = this.fb.group({
      firstName: ['', [Validators.required, CustomValidators.textOnly]],
      lastName: ['', [Validators.required, CustomValidators.textOnly]],
      email: ['', [Validators.required, CustomValidators.email]],
      contact: ['', [CustomValidators.indianPhoneNumber]],
      gender: [''],
      emergencyContactName: ['', [CustomValidators.textOnly]],
      emergencyContactNum: ['', [CustomValidators.indianPhoneNumber]],
      state: ['', [CustomValidators.textOnly]],
      city: ['', [CustomValidators.textOnly]],
      address: [''],
      country: ['', [CustomValidators.textOnly]],
      countryCode: [''],
      postalCode: ['', [CustomValidators.numbersOnly]],
      bloodGroup: [''],
      profileUrl: [''],
      specializationId: ['', [Validators.required]],
      licenseNumber: ['', [Validators.required]],
      qualification: ['', [Validators.required, CustomValidators.textOnly]],
      bio: [''],
      consultationFee: [0, [Validators.required, Validators.min(0)]],
      yearsOfExp: [0, [Validators.required, Validators.min(0)]],
      active: [true, [Validators.required]],
      joiningDate: ['', [Validators.required, CustomValidators.pastDate]],
      // Slot management fields
      slotStartTime: ['09:00', [Validators.required]],
      slotEndTime: ['17:00', [Validators.required]],
      appointmentDuration: [30, [Validators.required, Validators.min(15), Validators.max(60)]],
      workingDays: ['MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY', [Validators.required]]
    });

    this.addForm = this.fb.group({
      firstName: ['', [Validators.required, CustomValidators.textOnly]],
      lastName: ['', [Validators.required, CustomValidators.textOnly]],
      email: ['', [Validators.required, CustomValidators.doctorEmail]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      contact: ['', [CustomValidators.indianPhoneNumber]],
      gender: [''],
      emergencyContactName: ['', [CustomValidators.textOnly]],
      emergencyContactNum: ['', [CustomValidators.indianPhoneNumber]],
      state: ['', [CustomValidators.textOnly]],
      city: ['', [CustomValidators.textOnly]],
      address: [''],
      country: ['', [CustomValidators.textOnly]],
      countryCode: [''],
      postalCode: ['', [CustomValidators.numbersOnly]],
      bloodGroup: [''],
      profileUrl: [''],
      specializationId: ['', [Validators.required]],
      licenseNumber: ['', [Validators.required]],
      qualification: ['', [Validators.required, CustomValidators.textOnly]],
      bio: [''],
      consultationFee: [0, [Validators.required, Validators.min(0)]],
      yearsOfExp: [0, [Validators.required, Validators.min(0)]],
      joiningDate: ['', [Validators.required, CustomValidators.pastDate]],
      active: [true],
      // Slot management fields
      slotStartTime: ['09:00', [Validators.required]],
      slotEndTime: ['17:00', [Validators.required]],
      appointmentDuration: [30, [Validators.required, Validators.min(15), Validators.max(60)]],
      workingDays: ['MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY', [Validators.required]]
    });

    // Add form value change debugging
    this.addForm.valueChanges.subscribe(value => {
      console.log('Form value changed:', value);
    });

    // Setup search debounce
    this.searchSubject.pipe(
      debounceTime(300),
      distinctUntilChanged()
    ).subscribe(searchTerm => {
      this.searchTerm = searchTerm;
      this.currentPage = 0;
      this.loadDoctors();
    });
  }

  ngOnInit(): void {
    this.setDateRestrictions();
    this.loadDoctors();
    this.loadSpecializations();
  }

  setDateRestrictions(): void {
    const today = new Date();
    this.maxDate = today.toISOString().split('T')[0];
  }

  loadDoctors(): void {
    this.isLoading = true;
    const filters: SearchFilters = {
      page: this.currentPage,
      size: this.pageSize,
      sortBy: this.sortBy,
      sortDir: this.sortDir,
      name: this.searchTerm || undefined,
      specialization: this.selectedSpecialization || undefined,
      active: this.selectedStatus || undefined
    };

    console.log('Loading doctors with filters:', filters);
    this.adminService.getDoctors(filters).subscribe({
      next: (response) => {
        console.log('Doctors response:', response);
        if (response.success) {
          this.paginatedResponse = response.data;
          this.doctors = response.data.content;
          this.totalElements = response.data.totalElements;
          this.totalPages = response.data.totalPages;
        } else {
          console.error('API returned error:', response.message);
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error loading doctors:', error);
        console.error('Error details:', error.error);
        this.isLoading = false;
      }
    });
  }

  onSearch(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.searchSubject.next(target.value);
  }

  onSort(column: string): void {
    if (this.sortBy === column) {
      this.sortDir = this.sortDir === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortBy = column;
      this.sortDir = 'asc';
    }
    this.currentPage = 0;
    this.loadDoctors();
  }

  onPageChange(page: number): void {
    this.currentPage = page;
    this.loadDoctors();
  }

  onPageSizeChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    const size = +target.value;
    this.pageSize = size;
    this.currentPage = 0;
    this.loadDoctors();
  }

  applyFilters(): void {
    this.selectedSpecialization = this.filterForm.get('specialization')?.value || '';
    this.selectedStatus = this.filterForm.get('active')?.value || '';
    this.currentPage = 0;
    this.loadDoctors();
  }

  clearFilters(): void {
    this.filterForm.reset();
    this.selectedSpecialization = '';
    this.selectedStatus = '';
    this.currentPage = 0;
    this.loadDoctors();
  }

  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }

  editDoctor(doctor: Doctor): void {
    if (doctor.deletedAt) {
      return; // Don't allow editing deleted doctors
    }
    this.selectedDoctor = doctor;
    this.showEditModal = true;
    this.editForm.patchValue({
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      email: doctor.email,
      contact: doctor.contact || '',
      gender: doctor.gender || '',
      emergencyContactName: doctor.emergencyContactName || '',
      emergencyContactNum: doctor.emergencyContactNum || '',
      state: doctor.state || '',
      city: doctor.city || '',
      address: doctor.address || '',
      country: doctor.country || '',
      countryCode: doctor.countryCode || '',
      postalCode: doctor.postalCode || '',
      bloodGroup: doctor.bloodGroup || '',
      profileUrl: doctor.profileUrl || '',
      specializationId: doctor.specialization.specializationId,
      licenseNumber: doctor.licenseNumber,
      qualification: doctor.qualification,
      bio: doctor.bio || '',
      consultationFee: doctor.consultationFee,
      yearsOfExp: doctor.yearsOfExp,
      active: doctor.active,
      joiningDate: doctor.joiningDate,
      // Slot management fields
      slotStartTime: doctor.slotStartTime || '09:00',
      slotEndTime: doctor.slotEndTime || '17:00',
      appointmentDuration: doctor.appointmentDuration || 30,
      workingDays: doctor.workingDays || 'MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY'
    });
  }

  updateDoctor(): void {
    if (this.editForm.valid && this.selectedDoctor) {
      this.isSubmitting = true;
      const updateData = this.editForm.value;
      
      // Remove critical fields that shouldn't be updated
      delete updateData.email;
      delete updateData.licenseNumber;
      
      this.adminService.updateDoctor(this.selectedDoctor.doctorId, updateData).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadDoctors();
            this.closeEditModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error updating doctor:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  deleteDoctor(doctor: Doctor): void {
    if (doctor.deletedAt) {
      return; // Don't allow deleting already deleted doctors
    }
    this.selectedDoctor = doctor;
    this.showDeleteModal = true;
  }

  confirmDelete(): void {
    if (this.selectedDoctor) {
      this.isSubmitting = true;
      this.adminService.deleteDoctor(this.selectedDoctor.doctorId).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadDoctors();
            this.closeDeleteModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error deleting doctor:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  closeEditModal(): void {
    this.selectedDoctor = null;
    this.showEditModal = false;
    this.editForm.reset();
  }

  closeDeleteModal(): void {
    this.selectedDoctor = null;
    this.showDeleteModal = false;
  }


  loadSpecializations(): void {
    this.adminService.getSpecializations().subscribe({
      next: (response) => {
        console.log('Specializations API response:', response);
        if (response.success) {
          this.specializations = response.data;
          console.log('Loaded specializations:', this.specializations);
        } else {
          console.error('API returned error:', response.message);
        }
      },
      error: (error) => {
        console.error('Error loading specializations:', error);
        console.error('Error details:', error.error);
      }
    });
  }

  addDoctor(): void {
    this.showAddModal = true;
    this.addForm.reset();
    console.log('Add doctor modal opened');
    
    // Load specializations when opening the modal
    this.loadSpecializations();
    
    console.log('Available specializations:', this.specializations);
    
    // Set default values
    const today = new Date().toISOString().split('T')[0]; // Get today's date in YYYY-MM-DD format
    this.addForm.patchValue({
      consultationFee: 0,
      yearsOfExp: 0,
      joiningDate: today, // Set today as default joining date
      slotStartTime: '09:00',
      slotEndTime: '17:00',
      appointmentDuration: 30,
      workingDays: 'MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY',
      active: true
    });
    
    console.log('Form after reset and patch:', this.addForm.value);
  }

  createDoctor(): void {
    console.log('=== CREATE DOCTOR DEBUG ===');
    console.log('Form valid:', this.addForm.valid);
    console.log('Form value:', this.addForm.value);
    console.log('Form errors:', this.addForm.errors);
    
    // Check individual field validity
    console.log('specializationId valid:', this.addForm.get('specializationId')?.valid);
    console.log('licenseNumber valid:', this.addForm.get('licenseNumber')?.valid);
    console.log('qualification valid:', this.addForm.get('qualification')?.valid);
    console.log('joiningDate valid:', this.addForm.get('joiningDate')?.valid);
    console.log('consultationFee valid:', this.addForm.get('consultationFee')?.valid);
    console.log('yearsOfExp valid:', this.addForm.get('yearsOfExp')?.valid);
    
    // Check individual field values
    console.log('specializationId value:', this.addForm.get('specializationId')?.value);
    console.log('licenseNumber value:', this.addForm.get('licenseNumber')?.value);
    console.log('qualification value:', this.addForm.get('qualification')?.value);
    console.log('joiningDate value:', this.addForm.get('joiningDate')?.value);
    console.log('consultationFee value:', this.addForm.get('consultationFee')?.value);
    console.log('yearsOfExp value:', this.addForm.get('yearsOfExp')?.value);
    
    const formValue = this.addForm.value;
    
    // Validate that specializationId is not undefined or empty
    if (!formValue.specializationId || formValue.specializationId === 'undefined' || formValue.specializationId === '') {
      console.error('Specialization ID is undefined or invalid:', formValue.specializationId);
      alert('Please select a specialization');
      return;
    }
    
    // Note: userId is not needed for doctor creation as doctors are separate entities
    
    // Validate that joiningDate is not undefined or empty
    if (!formValue.joiningDate || formValue.joiningDate === 'undefined' || formValue.joiningDate === '') {
      console.error('Joining date is undefined or invalid:', formValue.joiningDate);
      alert('Please select a joining date');
      return;
    }
    
    if (this.addForm.valid) {
      this.isSubmitting = true;
      const doctorData = this.addForm.value;
      
      console.log('Sending doctor data:', doctorData);
      
      this.adminService.createDoctor(doctorData).subscribe({
        next: (response) => {
          console.log('Doctor creation response:', response);
          if (response.success) {
            this.loadDoctors();
            this.closeAddModal();
            this.addForm.reset();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error creating doctor:', error);
          this.isSubmitting = false;
        }
      });
    } else {
      console.log('Form is invalid:', this.addForm.errors);
      console.log('Form value:', this.addForm.value);
      alert('Please fill in all required fields correctly');
    }
  }

  closeAddModal(): void {
    this.showAddModal = false;
    this.addForm.reset();
  }

  getStatusBadgeClass(active: boolean): string {
    return active ? 'badge--green' : 'badge--red';
  }

  formatCurrency(amount: number): string {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  }

  formatDate(dateString: string): string {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  getSortIcon(column: string): string {
    if (this.sortBy !== column) return 'sort';
    return this.sortDir === 'asc' ? 'sort-up' : 'sort-down';
  }

  getPageNumbers(): number[] {
    const pages: number[] = [];
    const start = Math.max(0, this.currentPage - 2);
    const end = Math.min(this.totalPages - 1, this.currentPage + 2);
    
    for (let i = start; i <= end; i++) {
      pages.push(i);
    }
    return pages;
  }

  toggleDoctorStatus(doctor: Doctor): void {
    const newStatus = !doctor.active;
    this.adminService.updateDoctor(doctor.doctorId, { active: newStatus }).subscribe({
      next: (response) => {
        if (response.success) {
          doctor.active = newStatus;
          this.loadDoctors();
        }
      },
      error: (error) => {
        console.error('Error updating doctor status:', error);
      }
    });
  }

  getDoctorName(doctor: Doctor): string {
    return `Dr. ${doctor.firstName} ${doctor.lastName}`;
  }

  updateWorkingDays(event: Event, day: string): void {
    const checkbox = event.target as HTMLInputElement;
    const currentDays = this.addForm.get('workingDays')?.value || '';
    const daysArray = currentDays ? currentDays.split(',') : [];
    
    if (checkbox.checked) {
      if (!daysArray.includes(day)) {
        daysArray.push(day);
      }
    } else {
      const index = daysArray.indexOf(day);
      if (index > -1) {
        daysArray.splice(index, 1);
      }
    }
    
    this.addForm.patchValue({
      workingDays: daysArray.join(',')
    });
  }

  updateWorkingDaysEdit(event: Event, day: string): void {
    const checkbox = event.target as HTMLInputElement;
    const currentDays = this.editForm.get('workingDays')?.value || '';
    const daysArray = currentDays ? currentDays.split(',') : [];
    
    if (checkbox.checked) {
      if (!daysArray.includes(day)) {
        daysArray.push(day);
      }
    } else {
      const index = daysArray.indexOf(day);
      if (index > -1) {
        daysArray.splice(index, 1);
      }
    }
    
    this.editForm.patchValue({
      workingDays: daysArray.join(',')
    });
  }

  // Custom validator for doctor email
  doctorEmailValidator(control: any) {
    if (control.value && !control.value.endsWith('@doctor.com')) {
      return { invalidDoctorEmail: true };
    }
    return null;
  }

  // Input restriction methods
  onTextInput(event: any, controlName: string): void {
    const value = event.target.value;
    const textOnlyRegex = /^[a-zA-Z\s]*$/;
    if (!textOnlyRegex.test(value)) {
      event.target.value = value.replace(/[^a-zA-Z\s]/g, '');
      this.addForm.get(controlName)?.setValue(event.target.value);
    }
  }

  onNumberInput(event: any, controlName: string): void {
    const value = event.target.value;
    const numberOnlyRegex = /^\d*$/;
    if (!numberOnlyRegex.test(value)) {
      event.target.value = value.replace(/\D/g, '');
      this.addForm.get(controlName)?.setValue(event.target.value);
    }
  }

  onPhoneInput(event: any, controlName: string): void {
    const value = event.target.value;
    const phoneRegex = /^[6-9]\d{0,9}$/;
    if (!phoneRegex.test(value)) {
      event.target.value = value.replace(/[^6-9]/, '').substring(0, 10);
      this.addForm.get(controlName)?.setValue(event.target.value);
    }
  }

  // Error message helpers
  getErrorMessage(controlName: string, form: FormGroup): string {
    const control = form.get(controlName);
    if (control?.errors && control.touched) {
      if (control.errors['required']) return `${this.getFieldLabel(controlName)} is required`;
      if (control.errors['invalidText']) return `${this.getFieldLabel(controlName)} should contain only letters and spaces`;
      if (control.errors['invalidPhone']) return 'Phone number should start with 6-9 and have 10 digits';
      if (control.errors['invalidEmail']) return 'Please enter a valid email address';
      if (control.errors['invalidDoctorEmail']) return 'Doctor email must end with @doctor.com';
      if (control.errors['numbersOnly']) return `${this.getFieldLabel(controlName)} should contain only numbers`;
      if (control.errors['pastDate']) return 'Please select a past date';
      if (control.errors['futureDate']) return 'Please select a future date';
      if (control.errors['tooOld']) return `Age cannot be more than ${control.errors['tooOld'].maxAge} years`;
      if (control.errors['minlength']) return `${this.getFieldLabel(controlName)} should be at least ${control.errors['minlength'].requiredLength} characters`;
      if (control.errors['maxlength']) return `${this.getFieldLabel(controlName)} should not exceed ${control.errors['maxlength'].requiredLength} characters`;
      if (control.errors['min']) return `${this.getFieldLabel(controlName)} should be at least ${control.errors['min'].min}`;
      if (control.errors['max']) return `${this.getFieldLabel(controlName)} should not exceed ${control.errors['max'].max}`;
    }
    return '';
  }

  getFieldLabel(controlName: string): string {
    const labels: { [key: string]: string } = {
      'firstName': 'First Name',
      'lastName': 'Last Name',
      'email': 'Email',
      'contact': 'Contact Number',
      'emergencyContactName': 'Emergency Contact Name',
      'emergencyContactNum': 'Emergency Contact Number',
      'state': 'State',
      'city': 'City',
      'country': 'Country',
      'postalCode': 'Postal Code',
      'qualification': 'Qualification',
      'licenseNumber': 'License Number',
      'consultationFee': 'Consultation Fee',
      'yearsOfExp': 'Years of Experience',
      'joiningDate': 'Joining Date',
      'slotStartTime': 'Slot Start Time',
      'slotEndTime': 'Slot End Time',
      'appointmentDuration': 'Appointment Duration',
      'workingDays': 'Working Days'
    };
    return labels[controlName] || controlName;
  }
}
