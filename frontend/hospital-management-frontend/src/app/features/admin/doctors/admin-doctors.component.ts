import { Component, OnInit, ViewChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AdminService, Doctor, User, SearchFilters, PaginatedResponse } from '../../../core/services/admin.service';
import { Subject, debounceTime, distinctUntilChanged } from 'rxjs';

@Component({
  selector: 'app-admin-doctors',
  templateUrl: './admin-doctors.component.html',
  styleUrls: ['./admin-doctors.component.css'],
  imports: [CommonModule, ReactiveFormsModule],
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
  patients: User[] = [];
  specializations: any[] = [];
  
  // Table columns
  columns = [
    { key: 'doctorId', label: 'ID', sortable: true },
    { key: 'name', label: 'Doctor Name', sortable: true },
    { key: 'specialization', label: 'Specialization', sortable: true },
    { key: 'licenseNumber', label: 'License', sortable: true },
    { key: 'qualification', label: 'Qualification', sortable: true },
    { key: 'consultationFee', label: 'Fee', sortable: true },
    { key: 'status', label: 'Status', sortable: true },
    { key: 'actions', label: 'Actions', sortable: false }
  ];


  statuses = [
    { value: '', label: 'All Status' },
    { value: 'ACTIVE', label: 'Active' },
    { value: 'INACTIVE', label: 'Inactive' }
  ];

  constructor(
    private adminService: AdminService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      specialization: [''],
      status: ['']
    });

    this.editForm = this.fb.group({
      licenseNumber: ['', [Validators.required]],
      qualification: ['', [Validators.required]],
      bio: [''],
      consultationFee: [0, [Validators.required, Validators.min(0)]],
      yearsOfExp: [0, [Validators.required, Validators.min(0)]],
      status: ['ACTIVE', [Validators.required]]
    });

    this.addForm = this.fb.group({
      userId: ['', [Validators.required]],
      specializationId: ['', [Validators.required]],
      licenseNumber: ['', [Validators.required]],
      qualification: ['', [Validators.required]],
      bio: [''],
      joiningDate: ['', [Validators.required]],
      consultationFee: [0, [Validators.required, Validators.min(0)]],
      yearsOfExp: [0, [Validators.required, Validators.min(0)]]
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
    this.loadDoctors();
    this.loadPatients();
    this.loadSpecializations();
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
      status: this.selectedStatus || undefined
    };

    this.adminService.getDoctors(filters).subscribe({
      next: (response) => {
        if (response.success) {
          this.paginatedResponse = response.data;
          this.doctors = response.data.content;
          this.totalElements = response.data.totalElements;
          this.totalPages = response.data.totalPages;
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error loading doctors:', error);
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
    this.selectedStatus = this.filterForm.get('status')?.value || '';
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
    this.selectedDoctor = doctor;
    this.showEditModal = true;
    this.editForm.patchValue({
      licenseNumber: doctor.licenseNumber,
      qualification: doctor.qualification,
      bio: doctor.bio || '',
      consultationFee: doctor.consultationFee,
      yearsOfExp: doctor.yearsOfExp,
      status: doctor.status
    });
  }

  updateDoctor(): void {
    if (this.editForm.valid && this.selectedDoctor) {
      this.isSubmitting = true;
      const updateData = this.editForm.value;
      
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

  loadPatients(): void {
    this.adminService.getPatients().subscribe({
      next: (response) => {
        if (response.success) {
          this.patients = response.data;
          console.log('Loaded patients from API:', this.patients); // Debug log
          
          // Filter out any users who are not patients (just in case)
          this.patients = this.patients.filter(user => {
            const isPatient = user.role === 'PATIENT' || user.role === 'Patient';
            console.log(`User ${user.name} (${user.email}) has role: ${user.role}, isPatient: ${isPatient}`);
            return isPatient;
          });
          
          console.log('Filtered patients:', this.patients); // Debug log
        }
      },
      error: (error) => {
        console.error('Error loading patients:', error);
      }
    });
  }

  loadSpecializations(): void {
    this.adminService.getSpecializations().subscribe({
      next: (response) => {
        if (response.success) {
          this.specializations = response.data;
          console.log('Loaded specializations:', this.specializations); // Debug log
        }
      },
      error: (error) => {
        console.error('Error loading specializations:', error);
      }
    });
  }

  addDoctor(): void {
    this.showAddModal = true;
    this.addForm.reset();
    console.log('Add doctor modal opened');
    console.log('Available patients:', this.patients);
    console.log('Available specializations:', this.specializations);
    
    // Set default values for testing
    const today = new Date().toISOString().split('T')[0]; // Get today's date in YYYY-MM-DD format
    this.addForm.patchValue({
      consultationFee: 0,
      yearsOfExp: 0,
      joiningDate: today // Set today as default joining date
    });
    
    console.log('Form after reset and patch:', this.addForm.value);
  }

  createDoctor(): void {
    console.log('=== CREATE DOCTOR DEBUG ===');
    console.log('Form valid:', this.addForm.valid);
    console.log('Form value:', this.addForm.value);
    console.log('Form errors:', this.addForm.errors);
    
    // Check individual field validity
    console.log('userId valid:', this.addForm.get('userId')?.valid);
    console.log('specializationId valid:', this.addForm.get('specializationId')?.valid);
    console.log('licenseNumber valid:', this.addForm.get('licenseNumber')?.valid);
    console.log('qualification valid:', this.addForm.get('qualification')?.valid);
    console.log('joiningDate valid:', this.addForm.get('joiningDate')?.valid);
    console.log('consultationFee valid:', this.addForm.get('consultationFee')?.valid);
    console.log('yearsOfExp valid:', this.addForm.get('yearsOfExp')?.valid);
    
    // Check individual field values
    console.log('userId value:', this.addForm.get('userId')?.value);
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
    
    // Validate that userId is not undefined or empty
    if (!formValue.userId || formValue.userId === 'undefined' || formValue.userId === '') {
      console.error('User ID is undefined or invalid:', formValue.userId);
      alert('Please select a patient');
      return;
    }
    
    // Validate that joiningDate is not undefined or empty
    if (!formValue.joiningDate || formValue.joiningDate === 'undefined' || formValue.joiningDate === '') {
      console.error('Joining date is undefined or invalid:', formValue.joiningDate);
      alert('Please select a joining date');
      return;
    }
    
    if (this.addForm.valid) {
      this.isSubmitting = true;
      
      // Convert string values to proper types
      const doctorData = {
        userId: parseInt(formValue.userId),
        specializationId: parseInt(formValue.specializationId),
        licenseNumber: formValue.licenseNumber,
        qualification: formValue.qualification,
        bio: formValue.bio || '',
        joiningDate: formValue.joiningDate, // Keep as string, backend will convert to LocalDate
        consultationFee: parseFloat(formValue.consultationFee),
        yearsOfExp: parseInt(formValue.yearsOfExp)
      };
      
      console.log('Sending doctor data:', doctorData); // Debug log
      
      this.adminService.createDoctor(doctorData).subscribe({
        next: (response) => {
          console.log('Doctor creation response:', response); // Debug response
          if (response.success) {
            this.loadDoctors();
            this.closeAddModal();
            this.addForm.reset(); // Reset form after successful creation
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error creating doctor:', error);
          console.error('Error details:', error.error); // Debug error details
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

  getStatusBadgeClass(status: string): string {
    switch (status) {
      case 'ACTIVE':
        return 'badge--green';
      case 'INACTIVE':
        return 'badge--red';
      default:
        return 'badge--gray';
    }
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
}
