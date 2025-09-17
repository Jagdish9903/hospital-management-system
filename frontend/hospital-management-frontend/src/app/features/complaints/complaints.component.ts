// frontend/hospital-management-frontend/src/app/features/complaints/complaints.component.ts
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-complaints',
  standalone: true,
  imports: [CommonModule, MatCardModule, MatButtonModule, MatIconModule],
  template: `
    <div class="complaints-container">
      <mat-card>
        <mat-card-header>
          <mat-card-title>Complaints</mat-card-title>
        </mat-card-header>
        <mat-card-content>
          <p>Complaint management feature coming soon...</p>
          <button mat-raised-button color="primary">
            <mat-icon>feedback</mat-icon>
            Register Complaint
          </button>
        </mat-card-content>
      </mat-card>
    </div>
  `,
  styles: [`
    .complaints-container {
      padding: 20px;
      max-width: 1200px;
      margin: 0 auto;
    }
  `]
})
export class ComplaintsComponent {}
