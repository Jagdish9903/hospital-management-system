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
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';

@Component({
  selector: 'app-register',
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
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatCheckboxModule
  ],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;
  isLoading = false;
  errorMessage = '';
  showPassword = false;
  showConfirmPassword = false;
  formSubmitted = false;

  // Gender options
  genderOptions = [
    { value: 'MALE', label: 'Male' },
    { value: 'FEMALE', label: 'Female' },
    { value: 'OTHER', label: 'Other' }
  ];

  // Blood group options
  bloodGroupOptions = [
    { value: 'A+', label: 'A+' },
    { value: 'A-', label: 'A-' },
    { value: 'B+', label: 'B+' },
    { value: 'B-', label: 'B-' },
    { value: 'AB+', label: 'AB+' },
    { value: 'AB-', label: 'AB-' },
    { value: 'O+', label: 'O+' },
    { value: 'O-', label: 'O-' }
  ];

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.registerForm = this.fb.group({
      // Personal Information
      firstname: ['', [Validators.required, Validators.minLength(2), this.nameValidator]],
      lastname: ['', [Validators.required, Validators.minLength(2), this.nameValidator]],
      email: ['', [Validators.required, Validators.email, this.emailDomainValidator]],
      username: ['', [Validators.required, Validators.minLength(3), this.usernameValidator]],
      password: ['', [Validators.required, Validators.minLength(8), this.passwordStrengthValidator]],
      confirmPassword: ['', [Validators.required]],
      
      // Personal Details
      gender: ['', [Validators.required]],
      birthdate: ['', [Validators.required, this.birthdateValidator]],
      bloodGroup: ['', [Validators.required]],
      
      // Contact Information
      contact: ['', [Validators.required, this.phoneValidator]],
      address: ['', [Validators.required, Validators.minLength(10)]],
      city: ['', [Validators.required, this.nameValidator]],
      state: ['', [Validators.required, this.nameValidator]],
      country: ['', [Validators.required, this.nameValidator]],
      postalCode: ['', [Validators.required, this.postalCodeValidator]],
      
      // Emergency Contact
      emergencyContactName: ['', [Validators.required, this.nameValidator]],
      emergencyContactNum: ['', [Validators.required, this.phoneValidator]],
      
      // Terms and Conditions
      acceptTerms: [false, [Validators.requiredTrue]]
    }, { validators: this.passwordMatchValidator });
  }

  ngOnInit() {
    // Check if user is already logged in
    if (this.authService.isLoggedIn()) {
      this.router.navigate(['/home']);
    }
  }

  onSubmit() {
    this.formSubmitted = true;
    
    if (this.registerForm.valid) {
      this.isLoading = true;
      this.errorMessage = '';

      const formData = this.registerForm.value;
      const registrationData = {
        name: `${formData.firstname} ${formData.lastname}`,
        firstname: formData.firstname,
        lastname: formData.lastname,
        email: formData.email,
        username: formData.username,
        password: formData.password,
        confirmPassword: formData.confirmPassword,
        contact: formData.contact,
        countryCode: formData.countryCode || '+1',
        address: formData.address,
        city: formData.city,
        state: formData.state,
        country: formData.country,
        postalCode: formData.postalCode,
        bloodGroup: formData.bloodGroup,
        emergencyContactName: formData.emergencyContactName,
        emergencyContactNum: formData.emergencyContactNum
      };
      
      this.authService.register(registrationData).subscribe({
        next: (response) => {
          this.isLoading = false;
          if (response.success) {
            this.snackBar.open('Registration successful! Please login to continue.', 'Close', {
              duration: 5000,
              panelClass: ['success-snackbar']
            });
            this.router.navigate(['/login']);
          } else {
            this.errorMessage = response.message || 'Registration failed';
            this.snackBar.open(this.errorMessage, 'Close', {
              duration: 5000,
              panelClass: ['error-snackbar']
            });
          }
        },
        error: (error) => {
          this.isLoading = false;
          this.errorMessage = error.error?.message || 'An error occurred during registration';
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

  toggleConfirmPasswordVisibility() {
    this.showConfirmPassword = !this.showConfirmPassword;
  }

  goToLogin(): void {
    this.router.navigate(['/login']);
  }

  private markFormGroupTouched() {
    Object.keys(this.registerForm.controls).forEach(key => {
      const control = this.registerForm.get(key);
      control?.markAsTouched();
    });
  }

  // Custom validators
  private nameValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const name = control.value.trim();
    if (name.length < 2) {
      return { minlength: true };
    }
    
    if (!/^[a-zA-Z\s]+$/.test(name)) {
      return { invalidName: true };
    }
    
    return null;
  }

  private emailDomainValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const email = control.value;
    const validDomains = ['gmail.com', 'outlook.com', 'yahoo.com', 'hotmail.com', 'email.com'];
    const domain = email.split('@')[1];
    
    if (domain && !validDomains.includes(domain)) {
      return { invalidDomain: true };
    }
    return null;
  }

  private usernameValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const username = control.value;
    if (username.length < 3) {
      return { minlength: true };
    }
    
    if (!/^[a-zA-Z0-9_]+$/.test(username)) {
      return { invalidUsername: true };
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
    
    if (password.length < 8) {
      return { minlength: true };
    }
    
    if (!hasUpperCase || !hasLowerCase || !hasNumbers) {
      return { weakPassword: true };
    }
    
    return null;
  }

  private passwordMatchValidator(control: AbstractControl): ValidationErrors | null {
    const password = control.get('password');
    const confirmPassword = control.get('confirmPassword');
    
    if (password && confirmPassword && password.value !== confirmPassword.value) {
      return { passwordMismatch: true };
    }
    
    return null;
  }

  private birthdateValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const birthdate = new Date(control.value);
    const today = new Date();
    const age = today.getFullYear() - birthdate.getFullYear();
    
    if (age < 0 || age > 120) {
      return { invalidAge: true };
    }
    
    if (age < 18) {
      return { underage: true };
    }
    
    return null;
  }

  private phoneValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const phone = control.value.replace(/\D/g, '');
    if (phone.length < 10 || phone.length > 15) {
      return { invalidPhone: true };
    }
    
    return null;
  }

  private postalCodeValidator(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const postalCode = control.value;
    if (!/^\d{5,6}$/.test(postalCode)) {
      return { invalidPostalCode: true };
    }
    
    return null;
  }

  // Getter methods for template
  get firstname() { return this.registerForm.get('firstname'); }
  get lastname() { return this.registerForm.get('lastname'); }
  get email() { return this.registerForm.get('email'); }
  get username() { return this.registerForm.get('username'); }
  get password() { return this.registerForm.get('password'); }
  get confirmPassword() { return this.registerForm.get('confirmPassword'); }
  get gender() { return this.registerForm.get('gender'); }
  get birthdate() { return this.registerForm.get('birthdate'); }
  get bloodGroup() { return this.registerForm.get('bloodGroup'); }
  get contact() { return this.registerForm.get('contact'); }
  get address() { return this.registerForm.get('address'); }
  get city() { return this.registerForm.get('city'); }
  get state() { return this.registerForm.get('state'); }
  get country() { return this.registerForm.get('country'); }
  get postalCode() { return this.registerForm.get('postalCode'); }
  get emergencyContactName() { return this.registerForm.get('emergencyContactName'); }
  get emergencyContactNum() { return this.registerForm.get('emergencyContactNum'); }
  get acceptTerms() { return this.registerForm.get('acceptTerms'); }

  // Error message getters
  getFieldError(fieldName: string): string {
    const field = this.registerForm.get(fieldName);
    if (field?.errors && (field.touched || this.formSubmitted)) {
      const errors = field.errors;
      
      if (errors['required']) return `${this.getFieldLabel(fieldName)} is required`;
      if (errors['minlength']) return `${this.getFieldLabel(fieldName)} must be at least ${errors['minlength'].requiredLength} characters`;
      if (errors['email']) return 'Please enter a valid email address';
      if (errors['invalidName']) return 'Name can only contain letters and spaces';
      if (errors['invalidDomain']) return 'Please use a valid email domain';
      if (errors['invalidUsername']) return 'Username can only contain letters, numbers, and underscores';
      if (errors['weakPassword']) return 'Password must contain uppercase, lowercase, and numbers';
      if (errors['passwordMismatch']) return 'Passwords do not match';
      if (errors['invalidAge']) return 'Please enter a valid birthdate';
      if (errors['underage']) return 'You must be at least 18 years old';
      if (errors['invalidPhone']) return 'Please enter a valid phone number';
      if (errors['invalidPostalCode']) return 'Please enter a valid postal code';
    }
    return '';
  }

  private getFieldLabel(fieldName: string): string {
    const labels: { [key: string]: string } = {
      'firstname': 'First Name',
      'lastname': 'Last Name',
      'email': 'Email',
      'username': 'Username',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'gender': 'Gender',
      'birthdate': 'Birth Date',
      'bloodGroup': 'Blood Group',
      'contact': 'Contact Number',
      'address': 'Address',
      'city': 'City',
      'state': 'State',
      'country': 'Country',
      'postalCode': 'Postal Code',
      'emergencyContactName': 'Emergency Contact Name',
      'emergencyContactNum': 'Emergency Contact Number'
    };
    return labels[fieldName] || fieldName;
  }

  isFieldInvalid(fieldName: string): boolean {
    const field = this.registerForm.get(fieldName);
    return !!(field && field.invalid && (field.touched || this.formSubmitted));
  }

  isFieldValid(fieldName: string): boolean {
    const field = this.registerForm.get(fieldName);
    return !!(field && field.valid && field.touched);
  }
}