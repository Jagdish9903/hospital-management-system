import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AdminService, Complaint, User, ApiResponse } from '../../../core/services/admin.service';

@Component({
  selector: 'app-complaint-details',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './complaint-details.component.html',
  styleUrls: ['./complaint-details.component.css']
})
export class ComplaintDetailsComponent implements OnInit {
  complaint: Complaint | null = null;
  admins: User[] = [];
  isLoading = false;
  isSubmitting = false;
  
  // Forms
  assignmentForm: FormGroup;
  resolutionForm: FormGroup;
  notesForm: FormGroup;
  
  // Status options
  statusOptions = [
    { value: 'OPEN', label: 'Open' },
    { value: 'IN_PROGRESS', label: 'In Progress' },
    { value: 'RESOLVED', label: 'Resolved' },
    { value: 'CLOSED', label: 'Closed' },
  ];
  
  priorityOptions = [
    { value: 'LOW', label: 'Low' },
    { value: 'MEDIUM', label: 'Medium' },
    { value: 'HIGH', label: 'High' },
    { value: 'URGENT', label: 'Urgent' }
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private adminService: AdminService,
    private fb: FormBuilder
  ) {
    this.assignmentForm = this.fb.group({
      assignedTo: ['', [Validators.required]]
    });
    
    this.resolutionForm = this.fb.group({
      status: ['', [Validators.required]],
      priority: ['', [Validators.required]],
      resolution: ['', [Validators.required]]
    });
    
    this.notesForm = this.fb.group({
      note: ['', [Validators.required]]
    });
  }

  ngOnInit(): void {
    const complaintId = this.route.snapshot.paramMap.get('id');
    if (complaintId) {
      this.loadComplaintDetails(complaintId);
      this.loadAdmins();
    }
  }

  loadComplaintDetails(id: string): void {
    this.isLoading = true;
    this.adminService.getComplaintById(parseInt(id)).subscribe({
      next: (response) => {
        if (response.success) {
          this.complaint = response.data;
          this.initializeForms();
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error loading complaint details:', error);
        this.isLoading = false;
      }
    });
  }

  loadAdmins(): void {
    this.adminService.getAdmins().subscribe({
      next: (response) => {
        if (response.success) {
          this.admins = response.data;
        }
      },
      error: (error) => {
        console.error('Error loading admins:', error);
      }
    });
  }

  initializeForms(): void {
    if (this.complaint) {
      this.assignmentForm.patchValue({
        assignedTo: this.complaint.assignedTo?.id || ''
      });
      
      this.resolutionForm.patchValue({
        status: this.complaint.status || '',
        priority: this.complaint.priority || '',
        resolution: this.complaint.resolution || ''
      });
    }
  }

  assignComplaint(): void {
    if (this.assignmentForm.valid && this.complaint) {
      this.isSubmitting = true;
      const assignedToId = this.assignmentForm.value.assignedTo;
      
      this.adminService.assignComplaint(this.complaint.complaintId, assignedToId).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadComplaintDetails(this.complaint!.complaintId.toString());
            this.assignmentForm.reset();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error assigning complaint:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  updateResolution(): void {
    if (this.resolutionForm.valid && this.complaint) {
      this.isSubmitting = true;
      const resolutionData = this.resolutionForm.value;
      
      this.adminService.updateComplaintResolution(this.complaint.complaintId, resolutionData).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadComplaintDetails(this.complaint!.complaintId.toString());
            this.resolutionForm.reset();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error updating resolution:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  addNote(): void {
    if (this.notesForm.valid && this.complaint) {
      this.isSubmitting = true;
      const note = this.notesForm.value.note;
      
      this.adminService.addComplaintNote(this.complaint.complaintId, note).subscribe({
        next: (response) => {
          if (response.success) {
            this.loadComplaintDetails(this.complaint!.complaintId.toString());
            this.notesForm.reset();
          }
          this.isSubmitting = false;
        },
        error: (error) => {
          console.error('Error adding note:', error);
          this.isSubmitting = false;
        }
      });
    }
  }

  goBack(): void {
    this.router.navigate(['/admin/complaints']);
  }

  getStatusBadgeClass(status: string): string {
    switch (status) {
      case 'OPEN':
        return 'badge--red';
      case 'IN_PROGRESS':
        return 'badge--yellow';
      case 'RESOLVED':
        return 'badge--green';
      case 'CLOSED':
        return 'badge--gray';
      default:
        return 'badge--gray';
    }
  }

  getPriorityBadgeClass(priority: string): string {
    switch (priority) {
      case 'LOW':
        return 'badge--green';
      case 'MEDIUM':
        return 'badge--yellow';
      case 'HIGH':
        return 'badge--orange';
      case 'URGENT':
        return 'badge--red';
      default:
        return 'badge--gray';
    }
  }
}