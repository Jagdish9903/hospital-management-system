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
    path: 'my-appointments', 
    loadComponent: () => import('./features/appointments/my-appointments/my-appointments.component').then(m => m.MyAppointmentsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'book-appointment', 
    loadComponent: () => import('./features/appointments/book-appointment/book-appointment.component').then(m => m.BookAppointmentComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'schedule-appointment', 
    loadComponent: () => import('./features/appointments/schedule-appointment/schedule-appointment.component').then(m => m.ScheduleAppointmentComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'payments', 
    loadComponent: () => import('./features/payments/payments.component').then(m => m.PaymentsComponent),
    canActivate: [authGuard]
  },
  { 
    path: 'complaints', 
    loadComponent: () => import('./features/complaints/complaints.component').then(m => m.ComplaintsComponent),
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