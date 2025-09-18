// frontend/hospital-management-frontend/src/app/app.routes.ts
import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';
import { AdminGuard } from './core/guards/admin.guard';

export const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'login', loadComponent: () => import('./features/auth/login/login.component').then(m => m.LoginComponent) },
  { path: 'register', loadComponent: () => import('./features/auth/register/register.component').then(m => m.RegisterComponent) },
  { 
    path: 'home', 
    loadComponent: () => import('./features/home/home.component').then(m => m.HomeComponent),
    // canActivate: [authGuard]
  },
  { 
    path: 'appointments', 
    loadComponent: () => import('./features/appointments/appointments.component').then(m => m.AppointmentsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'appointments/my-appointments', 
    loadComponent: () => import('./features/appointments/my-appointments/my-appointments.component').then(m => m.MyAppointmentsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'appointments/schedule', 
    loadComponent: () => import('./features/appointments/schedule-appointment/schedule-appointment.component').then(m => m.ScheduleAppointmentComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'payments', 
    loadComponent: () => import('./features/payments/payments.component').then(m => m.PaymentsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'payments/select', 
    loadComponent: () => import('./features/payments/payment-select/payment-select.component').then(m => m.PaymentSelectComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'payments/form', 
    loadComponent: () => import('./features/payments/payment-form/payment-form.component').then(m => m.PaymentFormComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'payments/success', 
    loadComponent: () => import('./features/payments/payment-success/payment-success.component').then(m => m.PaymentSuccessComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'complaints', 
    loadComponent: () => import('./features/complaints/complaints.component').then(m => m.ComplaintsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'complaints/tracking', 
    loadComponent: () => import('./features/complaints/complaint-tracking/complaint-tracking.component').then(m => m.ComplaintTrackingComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'profile', 
    loadComponent: () => import('./features/profile/profile.component').then(m => m.ProfileComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'admin', 
    loadChildren: () => import('./features/admin/admin-routing.module').then(m => m.AdminRoutingModule),
    canActivate: [AdminGuard]
  },
  { path: '**', redirectTo: '/home' }
];