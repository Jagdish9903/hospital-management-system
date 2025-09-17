import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { AdminService } from '../../../core/services/admin.service';
import { User } from '../../../core/models/user.model';

interface Appointment {
  id: number;
  doctor: {
    user: {
      name: string;
    };
    specialization: {
      name: string;
    };
  };
  appointmentDate: string;
  appointmentTime: string;
  endTime: string;
  status: string;
  appointmentType: string;
  consultationFee: number;
  symptoms: string;
  notes: string;
  createdAt: string;
}

@Component({
  selector: 'app-my-appointments',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './my-appointments.component.html',
  styleUrls: ['./my-appointments.component.css']
})
export class MyAppointmentsComponent implements OnInit {
  appointments: Appointment[] = [];
  upcomingAppointments: Appointment[] = [];
  pastAppointments: Appointment[] = [];
  currentUser: User | null = null;
  activeTab: 'upcoming' | 'past' = 'upcoming';
  isLoading = false;

  constructor(
    public router: Router,
    private authService: AuthService,
    private adminService: AdminService
  ) {}

  ngOnInit(): void {
    this.loadCurrentUser();
    if (this.currentUser) {
      this.loadAppointments();
    }
  }

  loadCurrentUser(): void {
    this.currentUser = this.authService.getCurrentUser();
    if (!this.currentUser) {
      this.router.navigate(['/login']);
    }
  }

  loadAppointments(): void {
    this.isLoading = true;
    // For now, we'll use a mock API call since we need to create the patient appointments endpoint
    // In a real implementation, this would call: this.adminService.getPatientAppointments(this.currentUser!.id)
    
    // Mock data for demonstration
    this.appointments = [
      {
        id: 1,
        doctor: {
          user: { name: 'Dr. John Smith' },
          specialization: { name: 'Cardiology' }
        },
        appointmentDate: '2024-01-20',
        appointmentTime: '09:00:00',
        endTime: '09:30:00',
        status: 'SCHEDULED',
        appointmentType: 'CONSULTATION',
        consultationFee: 150,
        symptoms: 'Chest pain and shortness of breath',
        notes: 'Patient reports chest pain for the past week',
        createdAt: '2024-01-15T10:00:00'
      },
      {
        id: 2,
        doctor: {
          user: { name: 'Dr. Sarah Johnson' },
          specialization: { name: 'Neurology' }
        },
        appointmentDate: '2024-01-18',
        appointmentTime: '10:00:00',
        endTime: '10:45:00',
        status: 'CONFIRMED',
        appointmentType: 'CONSULTATION',
        consultationFee: 200,
        symptoms: 'Frequent headaches and dizziness',
        notes: 'Patient experiencing migraines for 2 weeks',
        createdAt: '2024-01-10T14:30:00'
      },
      {
        id: 3,
        doctor: {
          user: { name: 'Dr. Michael Brown' },
          specialization: { name: 'Orthopedics' }
        },
        appointmentDate: '2024-01-05',
        appointmentTime: '08:00:00',
        endTime: '09:00:00',
        status: 'CANCELLED',
        appointmentType: 'CONSULTATION',
        consultationFee: 180,
        symptoms: 'Knee pain and swelling',
        notes: 'Patient injured knee during sports activity',
        createdAt: '2024-01-01T09:15:00'
      }
    ];

    this.categorizeAppointments();
    this.isLoading = false;
  }

  categorizeAppointments(): void {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    this.upcomingAppointments = this.appointments.filter(apt => {
      const appointmentDate = new Date(apt.appointmentDate);
      return appointmentDate >= today && apt.status !== 'CANCELLED';
    }).sort((a, b) => new Date(a.appointmentDate).getTime() - new Date(b.appointmentDate).getTime());

    this.pastAppointments = this.appointments.filter(apt => {
      const appointmentDate = new Date(apt.appointmentDate);
      return appointmentDate < today || apt.status === 'CANCELLED';
    }).sort((a, b) => new Date(b.appointmentDate).getTime() - new Date(a.appointmentDate).getTime());
  }

  setActiveTab(tab: 'upcoming' | 'past'): void {
    this.activeTab = tab;
  }

  getCurrentAppointments(): Appointment[] {
    return this.activeTab === 'upcoming' ? this.upcomingAppointments : this.pastAppointments;
  }

  cancelAppointment(appointment: Appointment): void {
    if (confirm('Are you sure you want to cancel this appointment?')) {
      // In a real implementation, this would call: this.adminService.cancelAppointment(appointment.id)
      console.log('Cancelling appointment:', appointment.id);
      alert('Appointment cancelled successfully!');
      this.loadAppointments();
    }
  }

  rescheduleAppointment(appointment: Appointment): void {
    // Navigate to schedule appointment page with pre-filled data
    this.router.navigate(['/schedule-appointment'], {
      queryParams: {
        doctorId: appointment.doctor.user.name,
        specialization: appointment.doctor.specialization.name
      }
    });
  }

  formatDate(date: string): string {
    return new Date(date).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  formatTime(time: string): string {
    return new Date(`2000-01-01T${time}`).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    });
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

  getAppointmentTypeClass(type: string): string {
    switch (type) {
      case 'CONSULTATION':
        return 'type--consultation';
      case 'FOLLOW_UP':
        return 'type--followup';
      case 'EMERGENCY':
        return 'type--emergency';
      default:
        return 'type--default';
    }
  }

  canCancelAppointment(appointment: Appointment): boolean {
    const appointmentDate = new Date(appointment.appointmentDate);
    const today = new Date();
    const hoursUntilAppointment = (appointmentDate.getTime() - today.getTime()) / (1000 * 60 * 60);
    
    return appointment.status === 'SCHEDULED' && hoursUntilAppointment > 24;
  }

  canRescheduleAppointment(appointment: Appointment): boolean {
    const appointmentDate = new Date(appointment.appointmentDate);
    const today = new Date();
    const hoursUntilAppointment = (appointmentDate.getTime() - today.getTime()) / (1000 * 60 * 60);
    
    return appointment.status === 'SCHEDULED' && hoursUntilAppointment > 24;
  }
}
