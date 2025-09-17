import { Component, OnInit, ViewChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AdminService, Appointment, SearchFilters, PaginatedResponse } from '../../../core/services/admin.service';
import { Subject, debounceTime, distinctUntilChanged } from 'rxjs';

@Component({
  selector: 'app-admin-appointments',
  templateUrl: './admin-appointments.component.html',
  styleUrls: ['./admin-appointments.component.css'],
  imports: [CommonModule, ReactiveFormsModule],
  standalone: true
})
export class AdminAppointmentsComponent implements OnInit {
  @ViewChild('editModal') editModal!: TemplateRef<any>;
  @ViewChild('deleteModal') deleteModal!: TemplateRef<any>;

  appointments: Appointment[] = [];
  paginatedResponse: PaginatedResponse<Appointment> | null = null;
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
  sortBy = 'appointmentDate';
  sortDir: 'asc' | 'desc' = 'desc';
  
  // Filters
  showFilters = false;
  filterForm: FormGroup;
  selectedStatus = '';
  selectedType = '';
  selectedDateFrom = '';
  selectedDateTo = '';
  
  // Edit/Delete
  selectedAppointment: Appointment | null = null;
  showEditModal = false;
  showDeleteModal = false;
  editForm: FormGroup;
  isSubmitting = false;
  
  // Table columns
  columns = [
    { key: 'id', label: 'ID', sortable: true },
    { key: 'patient', label: 'Patient', sortable: true },
    { key: 'doctor', label: 'Doctor', sortable: true },
    { key: 'appointmentDate', label: 'Date', sortable: true },
    { key: 'appointmentTime', label: 'Time', sortable: true },
    { key: 'appointmentType', label: 'Type', sortable: true },
    { key: 'status', label: 'Status', sortable: true },
    { key: 'consultationFee', label: 'Fee', sortable: true },
    { key: 'actions', label: 'Actions', sortable: false }
  ];

  statuses = [
    { value: '', label: 'All Status' },
    { value: 'SCHEDULED', label: 'Scheduled' },
    { value: 'CONFIRMED', label: 'Confirmed' },
    { value: 'CANCELLED', label: 'Cancelled' }
  ];

  types = [
    { value: '', label: 'All Types' },
    { value: 'CONSULTATION', label: 'Consultation' },
    { value: 'FOLLOW_UP', label: 'Follow Up' },
    { value: 'EMERGENCY', label: 'Emergency' }
  ];

  constructor(
    private adminService: AdminService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      status: [''],
      type: [''],
      dateFrom: [''],
      dateTo: ['']
    });

    this.editForm = this.fb.group({
      appointmentDate: ['', [Validators.required]],
      appointmentTime: ['', [Validators.required]],
      appointmentType: ['CONSULTATION', [Validators.required]],
      status: ['SCHEDULED', [Validators.required]],
      symptoms: [''],
      notes: [''],
      consultationFee: [0, [Validators.required, Validators.min(0)]]
    });

    // Setup search debounce
    this.searchSubject.pipe(
      debounceTime(300),
      distinctUntilChanged()
    ).subscribe(searchTerm => {
      this.searchTerm = searchTerm;
      this.currentPage = 0;
      this.loadAppointments();
    });
  }

  ngOnInit(): void {
    this.loadAppointments();
  }

  loadAppointments(): void {
    this.isLoading = true;
    const filters: SearchFilters = {
      page: this.currentPage,
      size: this.pageSize,
      sortBy: this.sortBy,
      sortDir: this.sortDir,
      patientName: this.searchTerm || undefined,
      doctorName: this.searchTerm || undefined,
      status: this.selectedStatus || undefined,
      appointmentType: this.selectedType || undefined,
      dateFrom: this.selectedDateFrom || undefined,
      dateTo: this.selectedDateTo || undefined
    };

    this.adminService.getAppointments(filters).subscribe({
      next: (response) => {
        if (response.success) {
          this.paginatedResponse = response.data;
          this.appointments = response.data.content;
          this.totalElements = response.data.totalElements;
          this.totalPages = response.data.totalPages;
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error loading appointments:', error);
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
    this.loadAppointments();
  }

  onPageChange(page: number): void {
    this.currentPage = page;
    this.loadAppointments();
  }

  onPageSizeChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    const size = +target.value;
    this.pageSize = size;
    this.currentPage = 0;
    this.loadAppointments();
  }

  applyFilters(): void {
    this.selectedStatus = this.filterForm.get('status')?.value || '';
    this.selectedType = this.filterForm.get('type')?.value || '';
    this.selectedDateFrom = this.filterForm.get('dateFrom')?.value || '';
    this.selectedDateTo = this.filterForm.get('dateTo')?.value || '';
    this.currentPage = 0;
    this.loadAppointments();
  }

  clearFilters(): void {
    this.filterForm.reset();
    this.selectedStatus = '';
    this.selectedType = '';
    this.selectedDateFrom = '';
    this.selectedDateTo = '';
    this.currentPage = 0;
    this.loadAppointments();
  }

  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }

  editAppointment(appointment: Appointment): void {
    this.selectedAppointment = appointment;
    this.showEditModal = true;
    this.editForm.patchValue({
      appointmentDate: appointment.appointmentDate.split('T')[0],
      appointmentTime: appointment.appointmentTime,
      appointmentType: appointment.appointmentType,
      status: appointment.status,
      symptoms: appointment.symptoms || '',
      notes: appointment.notes || '',
      consultationFee: appointment.consultationFee
    });
  }

  updateAppointment(): void {
    if (this.editForm.valid && this.selectedAppointment) {
      this.isSubmitting = true;
      const updateData = this.editForm.value;
      
      this.adminService.updateAppointment(this.selectedAppointment.id, updateData).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadAppointments();
            this.closeEditModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error updating appointment:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  deleteAppointment(appointment: Appointment): void {
    this.selectedAppointment = appointment;
    this.showDeleteModal = true;
  }

  confirmDelete(): void {
    if (this.selectedAppointment) {
      this.isSubmitting = true;
      this.adminService.deleteAppointment(this.selectedAppointment.id).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadAppointments();
            this.closeDeleteModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error deleting appointment:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  closeEditModal(): void {
    this.selectedAppointment = null;
    this.showEditModal = false;
    this.editForm.reset();
  }

  closeDeleteModal(): void {
    this.selectedAppointment = null;
    this.showDeleteModal = false;
  }

  getStatusBadgeClass(status: string): string {
    switch (status) {
      case 'SCHEDULED':
        return 'badge--blue';
      case 'CONFIRMED':
        return 'badge--green';
      case 'CANCELLED':
        return 'badge--red';
      default:
        return 'badge--gray';
    }
  }

  getTypeBadgeClass(type: string): string {
    switch (type) {
      case 'CONSULTATION':
        return 'badge--blue';
      case 'FOLLOW_UP':
        return 'badge--purple';
      case 'EMERGENCY':
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

  formatDateTime(dateString: string, timeString: string): string {
    const date = new Date(dateString);
    const time = timeString.split(':').slice(0, 2).join(':');
    return `${date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' })} at ${time}`;
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