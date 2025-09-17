import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule, AbstractControl, ValidationErrors } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatCheckboxModule } from '@angular/material/checkbox';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatSnackBarModule,
    MatCheckboxModule
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  isLoading = false;
  errorMessage = '';
  showPassword = false;
  formSubmitted = false;

  // Test credentials for demo
  testCredentials = [
    { role: 'Admin', email: 'admin@hospital.com', password: 'password123' },
    { role: 'Patient', email: 'alice.wilson@email.com', password: 'password123' },
    { role: 'Doctor', email: 'dr.john@hospital.com', password: 'password123' }
  ];

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email, this.emailDomainValidator]],
      password: ['', [Validators.required, Validators.minLength(6), this.passwordStrengthValidator]]
    });
  }

  ngOnInit() {
    // Check if user is already logged in
    if (this.authService.isLoggedIn()) {
      const currentUser = this.authService.getCurrentUser();
      if (currentUser && (currentUser.role === 'ADMIN' || currentUser.role === 'SUPERADMIN')) {
        this.router.navigate(['/admin/dashboard']);
      } else {
        this.router.navigate(['/home']);
      }
    }
  }

  onSubmit() {
    this.formSubmitted = true;
    
    if (this.loginForm.valid) {
      this.isLoading = true;
      this.errorMessage = '';

      const { email, password } = this.loginForm.value;
      
      this.authService.login({ email, password }).subscribe({
        next: (response) => {
          this.isLoading = false;
          if (response.success) {
            this.snackBar.open('Login successful! Welcome back.', 'Close', {
              duration: 3000,
              panelClass: ['success-snackbar']
            });
            // Redirect based on user role
            if (response.data.role === 'ADMIN' || response.data.role === 'SUPERADMIN') {
              this.router.navigate(['/admin/dashboard']);
            } else {
              this.router.navigate(['/home']);
            }
          } else {
            this.errorMessage = response.message || 'Login failed';
            this.snackBar.open(this.errorMessage, 'Close', {
              duration: 5000,
              panelClass: ['error-snackbar']
            });
          }
        },
        error: (error) => {
          this.isLoading = false;
          this.errorMessage = error.error?.message || 'An error occurred during login';
          this.snackBar.open(this.errorMessage, 'Close', {
            duration: 5000,
            panelClass: ['error-snackbar']
          });
        }
      });
    } else {
      this.markFormGroupTouched();
      this.snackBar.open('Please fix the form errors and try again.', 'Close', {
        duration: 3000,
        panelClass: ['warning-snackbar']
      });
    }
  }

  togglePasswordVisibility() {
    this.showPassword = !this.showPassword;
  }

  fillTestCredentials(credential: any) {
    this.loginForm.patchValue({
      email: credential.email,
      password: credential.password
    });
    this.formSubmitted = false;
    this.errorMessage = '';
  }

  goToRegister(): void {
    this.router.navigate(['/register']);
  }

  private markFormGroupTouched() {
    Object.keys(this.loginForm.controls).forEach(key => {
      const control = this.loginForm.get(key);
      control?.markAsTouched();
    });
  }

  // Custom validators
  private emailDomainValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const email = control.value;
    const validDomains = ['hospital.com', 'email.com', 'gmail.com', 'outlook.com'];
    const domain = email.split('@')[1];
    
    if (domain && !validDomains.includes(domain)) {
      return { invalidDomain: true };
    }
    return null;
  }

  private passwordStrengthValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const password = control.value;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasLowerCase = /[a-z]/.test(password);
    const hasNumbers = /\d/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    if (password.length < 6) {
      return { minlength: true };
    }
    
    if (!hasUpperCase || !hasLowerCase || !hasNumbers) {
      return { weakPassword: true };
    }
    
    return null;
  }

  // Getter methods for template
  get email() { return this.loginForm.get('email'); }
  get password() { return this.loginForm.get('password'); }

  getEmailError(): string {
    const emailControl = this.email;
    if (emailControl?.errors && (emailControl.touched || this.formSubmitted)) {
      if (emailControl.errors['required']) return 'Email is required';
      if (emailControl.errors['email']) return 'Please enter a valid email address';
      if (emailControl.errors['invalidDomain']) return 'Please use a valid email domain';
    }
    return '';
  }

  getPasswordError(): string {
    const passwordControl = this.password;
    if (passwordControl?.errors && (passwordControl.touched || this.formSubmitted)) {
      if (passwordControl.errors['required']) return 'Password is required';
      if (passwordControl.errors['minlength']) return 'Password must be at least 6 characters';
      if (passwordControl.errors['weakPassword']) return 'Password must contain uppercase, lowercase, and numbers';
    }
    return '';
  }

  isFieldInvalid(fieldName: string): boolean {
    const field = this.loginForm.get(fieldName);
    return !!(field && field.invalid && (field.touched || this.formSubmitted));
  }

  isFieldValid(fieldName: string): boolean {
    const field = this.loginForm.get(fieldName);
    return !!(field && field.valid && field.touched);
  }
}