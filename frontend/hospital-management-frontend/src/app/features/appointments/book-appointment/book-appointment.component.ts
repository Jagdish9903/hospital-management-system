// frontend/hospital-management-frontend/src/app/features/appointments/book-appointment/book-appointment.component.ts
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-book-appointment',
  standalone: true,
  imports: [CommonModule, MatCardModule, MatButtonModule, MatIconModule],
  template: `
    <div class="book-appointment-container">
      <mat-card>
        <mat-card-header>
          <mat-card-title>Book Appointment</mat-card-title>
        </mat-card-header>
        <mat-card-content>
          <p>Appointment booking feature coming soon...</p>
          <button mat-raised-button color="primary">
            <mat-icon>search</mat-icon>
            Search Doctors
          </button>
        </mat-card-content>
      </mat-card>
    </div>
  `,
  styles: [`
    .book-appointment-container {
      padding: 20px;
      max-width: 1200px;
      margin: 0 auto;
    }
  `]
})
export class BookAppointmentComponent {}
