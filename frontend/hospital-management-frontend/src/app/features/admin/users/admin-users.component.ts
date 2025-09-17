import { Component, OnInit, ViewChild, TemplateRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AdminService, User, SearchFilters, PaginatedResponse } from '../../../core/services/admin.service';
import { Subject, debounceTime, distinctUntilChanged } from 'rxjs';

@Component({
  selector: 'app-admin-users',
  templateUrl: './admin-users.component.html',
  styleUrls: ['./admin-users.component.css'],
  imports: [CommonModule, ReactiveFormsModule],
  standalone: true
})
export class AdminUsersComponent implements OnInit {
  @ViewChild('editModal') editModal!: TemplateRef<any>;
  @ViewChild('deleteModal') deleteModal!: TemplateRef<any>;

  users: User[] = [];
  paginatedResponse: PaginatedResponse<User> | null = null;
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
  sortBy = 'id';
  sortDir: 'asc' | 'desc' = 'asc';
  
  // Filters
  showFilters = false;
  filterForm: FormGroup;
  selectedRole = '';
  selectedGender = '';
  selectedStatus = '';
  
  // Edit/Delete
  selectedUser: User | null = null;
  showEditModal = false;
  showDeleteModal = false;
  editForm: FormGroup;
  isSubmitting = false;
  
  // Table columns
  columns = [
    { key: 'id', label: 'ID', sortable: true },
    { key: 'name', label: 'Name', sortable: true },
    { key: 'email', label: 'Email', sortable: true },
    { key: 'role', label: 'Role', sortable: true },
    { key: 'contact', label: 'Contact', sortable: false },
    { key: 'city', label: 'City', sortable: true },
    { key: 'createdAt', label: 'Created', sortable: true },
    { key: 'actions', label: 'Actions', sortable: false }
  ];

  roles = [
    { value: '', label: 'All Roles' },
    { value: 'ADMIN', label: 'Admin' },
    { value: 'SUPERADMIN', label: 'Super Admin' },
    { value: 'PATIENT', label: 'Patient' }
  ];

  genders = [
    { value: '', label: 'All Genders' },
    { value: 'MALE', label: 'Male' },
    { value: 'FEMALE', label: 'Female' },
    { value: 'OTHER', label: 'Other' }
  ];

  constructor(
    private adminService: AdminService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      role: [''],
      gender: [''],
      status: ['']
    });

    this.editForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      email: ['', [Validators.required, Validators.email]],
      contact: [''],
      address: [''],
      city: [''],
      state: [''],
      country: [''],
      postalCode: [''],
      bloodGroup: [''],
      emergencyContactName: [''],
      emergencyContactNum: ['']
    });

    // Setup search debounce
    this.searchSubject.pipe(
      debounceTime(300),
      distinctUntilChanged()
    ).subscribe(searchTerm => {
      this.searchTerm = searchTerm;
      this.currentPage = 0;
      this.loadUsers();
    });
  }

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.isLoading = true;
    const filters: SearchFilters = {
      page: this.currentPage,
      size: this.pageSize,
      sortBy: this.sortBy,
      sortDir: this.sortDir,
      name: this.searchTerm || undefined,
      email: this.searchTerm || undefined,
      role: this.selectedRole || undefined,
      gender: this.selectedGender || undefined
    };

    this.adminService.getUsers(filters).subscribe({
      next: (response) => {
        if (response.success) {
          this.paginatedResponse = response.data;
          this.users = response.data.content;
          this.totalElements = response.data.totalElements;
          this.totalPages = response.data.totalPages;
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error loading users:', error);
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
    this.loadUsers();
  }

  onPageChange(page: number): void {
    this.currentPage = page;
    this.loadUsers();
  }

  onPageSizeChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    const size = +target.value;
    this.pageSize = size;
    this.currentPage = 0;
    this.loadUsers();
  }

  applyFilters(): void {
    this.selectedRole = this.filterForm.get('role')?.value || '';
    this.selectedGender = this.filterForm.get('gender')?.value || '';
    this.selectedStatus = this.filterForm.get('status')?.value || '';
    this.currentPage = 0;
    this.loadUsers();
  }

  clearFilters(): void {
    this.filterForm.reset();
    this.selectedRole = '';
    this.selectedGender = '';
    this.selectedStatus = '';
    this.currentPage = 0;
    this.loadUsers();
  }

  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }

  editUser(user: User): void {
    this.selectedUser = user;
    this.showEditModal = true;
    this.editForm.patchValue({
      name: user.name,
      email: user.email,
      contact: user.contact || '',
      address: user.address || '',
      city: user.city || '',
      state: user.state || '',
      country: user.country || '',
      postalCode: user.postalCode || '',
      bloodGroup: user.bloodGroup || '',
      emergencyContactName: user.emergencyContactName || '',
      emergencyContactNum: user.emergencyContactNum || ''
    });
  }

  updateUser(): void {
    if (this.editForm.valid && this.selectedUser) {
      this.isSubmitting = true;
      const updateData = this.editForm.value;
      
      this.adminService.updateUser(this.selectedUser.id, updateData).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadUsers();
            this.closeEditModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error updating user:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  deleteUser(user: User): void {
    this.selectedUser = user;
    this.showDeleteModal = true;
  }

  confirmDelete(): void {
    if (this.selectedUser) {
      this.isSubmitting = true;
      this.adminService.deleteUser(this.selectedUser.id).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadUsers();
            this.closeDeleteModal();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error deleting user:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  closeEditModal(): void {
    this.selectedUser = null;
    this.showEditModal = false;
    this.editForm.reset();
  }

  closeDeleteModal(): void {
    this.selectedUser = null;
    this.showDeleteModal = false;
  }

  getRoleBadgeClass(role: string): string {
    switch (role) {
      case 'SUPERADMIN':
        return 'badge--purple';
      case 'ADMIN':
        return 'badge--blue';
      case 'PATIENT':
        return 'badge--green';
      default:
        return 'badge--gray';
    }
  }

  getGenderBadgeClass(gender: string): string {
    switch (gender) {
      case 'MALE':
        return 'badge--blue';
      case 'FEMALE':
        return 'badge--pink';
      case 'OTHER':
        return 'badge--purple';
      default:
        return 'badge--gray';
    }
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
