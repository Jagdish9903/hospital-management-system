import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { AuthService } from '../../core/services/auth.service';
import { ToastService } from '../../core/services/toast.service';
import { environment } from '../../../environments/environment';

interface UserProfile {
  id: number;
  name: string;
  firstname: string;
  lastname: string;
  username: string;
  email: string;
  role: string;
  birthdate?: string;
  contact?: string;
  countryCode?: string;
  gender?: string;
  address?: string;
  city?: string;
  state?: string;
  country?: string;
  postalCode?: string;
  bloodGroup?: string;
  emergencyContactName?: string;
  emergencyContactNum?: string;
  profileUrl?: string;
  createdAt: string;
}

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  template: `
    <div class="profile-container">
      <div class="profile-header">
        <h1>My Profile</h1>
        <p>Manage your personal information and preferences</p>
      </div>

      <div class="profile-content">
        <!-- Profile Overview Card -->
        <div class="profile-overview">
          <div class="profile-avatar">
            <div class="avatar-circle">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                <circle cx="12" cy="7" r="4"/>
              </svg>
            </div>
            <div class="avatar-info">
              <h2>{{ userProfile?.name || 'User' }}</h2>
              <p class="user-role">{{ userProfile?.role || 'Patient' }}</p>
              <p class="user-email">{{ userProfile?.email }}</p>
            </div>
          </div>
          <div class="profile-stats">
            <div class="stat-item">
              <span class="stat-label">Member Since</span>
              <span class="stat-value">{{ formatDate(userProfile?.createdAt) }}</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">Username</span>
              <span class="stat-value">{{ userProfile?.username }}</span>
            </div>
          </div>
        </div>

        <!-- Profile Form -->
        <form [formGroup]="profileForm" (ngSubmit)="onSubmit()" class="profile-form">
          <div class="form-sections">
            <!-- Basic Information -->
            <div class="form-section">
              <h3 class="section-title">
                <svg class="section-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                  <circle cx="12" cy="7" r="4"/>
                </svg>
                Basic Information
              </h3>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">Full Name *</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="name"
                    placeholder="Enter your full name"
                  >
                  <div class="error-message" *ngIf="profileForm.get('name')?.invalid && profileForm.get('name')?.touched">
                    Full name is required
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">First Name *</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="firstname"
                    placeholder="Enter your first name"
                  >
                  <div class="error-message" *ngIf="profileForm.get('firstname')?.invalid && profileForm.get('firstname')?.touched">
                    First name is required
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Last Name *</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="lastname"
                    placeholder="Enter your last name"
                  >
                  <div class="error-message" *ngIf="profileForm.get('lastname')?.invalid && profileForm.get('lastname')?.touched">
                    Last name is required
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Birth Date</label>
                  <input 
                    type="date" 
                    class="form-input" 
                    formControlName="birthdate"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">Gender</label>
                  <select class="form-select" formControlName="gender">
                    <option value="">Select Gender</option>
                    <option value="MALE">Male</option>
                    <option value="FEMALE">Female</option>
                    <option value="OTHER">Other</option>
                  </select>
                </div>

                <div class="form-group">
                  <label class="form-label">Blood Group</label>
                  <select class="form-select" formControlName="bloodGroup">
                    <option value="">Select Blood Group</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                  </select>
                </div>
              </div>
            </div>

            <!-- Contact Information -->
            <div class="form-section">
              <h3 class="section-title">
                <svg class="section-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
                Contact Information
              </h3>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">Phone Number</label>
                  <div class="input-group">
                    <select class="form-select country-code" formControlName="countryCode">
                      <option value="">Code</option>
                      <option value="+1">+1 (US)</option>
                      <option value="+44">+44 (UK)</option>
                      <option value="+91">+91 (India)</option>
                      <option value="+86">+86 (China)</option>
                      <option value="+81">+81 (Japan)</option>
                    </select>
                    <input 
                      type="tel" 
                      class="form-input" 
                      formControlName="contact"
                      placeholder="Enter phone number"
                    >
                  </div>
                  <div class="error-message" *ngIf="profileForm.get('contact')?.invalid && profileForm.get('contact')?.touched">
                    Please enter a valid phone number
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Email Address</label>
                  <input 
                    type="email" 
                    class="form-input readonly" 
                    [value]="userProfile?.email"
                    readonly
                    disabled
                  >
                  <div class="form-help">Email cannot be changed</div>
                </div>
              </div>
            </div>

            <!-- Address Information -->
            <div class="form-section">
              <h3 class="section-title">
                <svg class="section-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
                Address Information
              </h3>
              <div class="form-grid">
                <div class="form-group full-width">
                  <label class="form-label">Street Address</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="address"
                    placeholder="Enter your street address"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">City</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="city"
                    placeholder="Enter city"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">State/Province</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="state"
                    placeholder="Enter state or province"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">Country</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="country"
                    placeholder="Enter country"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">Postal Code</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="postalCode"
                    placeholder="Enter postal code"
                  >
                </div>
              </div>
            </div>

            <!-- Emergency Contact -->
            <div class="form-section">
              <h3 class="section-title">
                <svg class="section-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 12h-4l-3 9L9 3l-3 9H2"/>
                </svg>
                Emergency Contact
              </h3>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">Emergency Contact Name</label>
                  <input 
                    type="text" 
                    class="form-input" 
                    formControlName="emergencyContactName"
                    placeholder="Enter emergency contact name"
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">Emergency Contact Number</label>
                  <input 
                    type="tel" 
                    class="form-input" 
                    formControlName="emergencyContactNum"
                    placeholder="Enter emergency contact number"
                  >
                </div>
              </div>
            </div>
          </div>

        <!-- Form Actions -->
        <div class="form-actions">
          <button 
            type="button" 
            class="btn-secondary" 
            (click)="resetForm()"
            [disabled]="isLoading"
          >
            Reset
          </button>
          <button 
            type="submit" 
            class="btn-primary" 
            [disabled]="profileForm.invalid || isLoading"
          >
            <span *ngIf="isLoading" class="loading-spinner"></span>
            {{ isLoading ? 'Updating...' : 'Update Profile' }}
          </button>
        </div>
        </form>
      </div>
    </div>
  `,
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  userProfile: UserProfile | null = null;
  profileForm: FormGroup;
  isLoading = false;

  constructor(
    private fb: FormBuilder,
    private http: HttpClient,
    private authService: AuthService,
    private toastService: ToastService
  ) {
    this.profileForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      firstname: ['', [Validators.required, Validators.minLength(2)]],
      lastname: ['', [Validators.required, Validators.minLength(2)]],
      birthdate: [''],
      contact: ['', [Validators.pattern(/^[0-9+\-\s()]+$/)]],
      countryCode: [''],
      gender: [''],
      address: [''],
      city: [''],
      state: [''],
      country: [''],
      postalCode: [''],
      bloodGroup: [''],
      emergencyContactName: [''],
      emergencyContactNum: ['', [Validators.pattern(/^[0-9+\-\s()]+$/)]],
      profileUrl: ['']
    });
  }

  ngOnInit(): void {
    this.loadUserProfile();
  }

  loadUserProfile(): void {
    this.isLoading = true;
    
    // Get current user from auth service
    const currentUser = this.authService.getCurrentUser();
    console.log('=== PROFILE DEBUG ===');
    console.log('Current user from auth service:', currentUser);
    console.log('User ID:', currentUser?.id);
    console.log('User email:', currentUser?.email);
    console.log('User name:', currentUser?.name);
    
    if (!currentUser?.id) {
      console.log('No current user found');
      this.toastService.showError('Please login to view your profile');
      this.isLoading = false;
      return;
    }

    // Try multiple approaches to get user data
    this.tryGetUserData(currentUser);
  }

  private tryGetUserData(currentUser: any): void {
    const userId = currentUser.id;
    const userEmail = currentUser.email;
    
    console.log('Trying to get user data for ID:', userId, 'Email:', userEmail);
    
    // Method 1: Try by ID with full URL
    const fullUrlById = `${environment.apiUrl}/api/simple-profile/user/${userId}`;
    console.log('Trying full URL by ID:', fullUrlById);
    
    this.http.get<any>(fullUrlById).subscribe({
      next: (response) => {
        console.log('✅ SUCCESS: Profile loaded by ID:', response);
        this.userProfile = response.data;
        this.populateForm();
        this.isLoading = false;
      },
      error: (error) => {
        console.log('❌ Failed by ID:', error);
        
        // Method 2: Try by email with full URL
        if (userEmail) {
          const fullUrlByEmail = `${environment.apiUrl}/api/simple-profile/email/${encodeURIComponent(userEmail)}`;
          console.log('Trying full URL by email:', fullUrlByEmail);
          
          this.http.get<any>(fullUrlByEmail).subscribe({
            next: (response) => {
              console.log('✅ SUCCESS: Profile loaded by email:', response);
              this.userProfile = response.data;
              this.populateForm();
              this.isLoading = false;
            },
            error: (emailError) => {
              console.log('❌ Failed by email:', emailError);
              
              // Method 3: Try relative URL by ID
              const relativeUrlById = `/api/simple-profile/user/${userId}`;
              console.log('Trying relative URL by ID:', relativeUrlById);
              
              this.http.get<any>(relativeUrlById).subscribe({
                next: (response) => {
                  console.log('✅ SUCCESS: Profile loaded by relative ID:', response);
                  this.userProfile = response.data;
                  this.populateForm();
                  this.isLoading = false;
                },
                error: (relativeError) => {
                  console.log('❌ Failed by relative ID:', relativeError);
                  
                  // Method 4: Try relative URL by email
                  if (userEmail) {
                    const relativeUrlByEmail = `/api/simple-profile/email/${encodeURIComponent(userEmail)}`;
                    console.log('Trying relative URL by email:', relativeUrlByEmail);
                    
                    this.http.get<any>(relativeUrlByEmail).subscribe({
                      next: (response) => {
                        console.log('✅ SUCCESS: Profile loaded by relative email:', response);
                        this.userProfile = response.data;
                        this.populateForm();
                        this.isLoading = false;
                      },
                      error: (finalError) => {
                        console.log('❌ All methods failed:', finalError);
                        console.log('Creating mock profile data for testing...');
                        this.createMockProfileData(currentUser);
                        this.isLoading = false;
                      }
                    });
                  } else {
                    this.toastService.showError('Failed to load profile. No email available.');
                    this.isLoading = false;
                  }
                }
              });
            }
          });
        } else {
          this.toastService.showError('Failed to load profile. No email available.');
          this.isLoading = false;
        }
      }
    });
  }

  populateForm(): void {
    if (this.userProfile) {
      this.profileForm.patchValue({
        name: this.userProfile.name || '',
        firstname: this.userProfile.firstname || '',
        lastname: this.userProfile.lastname || '',
        birthdate: this.userProfile.birthdate || '',
        contact: this.userProfile.contact || '',
        countryCode: this.userProfile.countryCode || '',
        gender: this.userProfile.gender || '',
        address: this.userProfile.address || '',
        city: this.userProfile.city || '',
        state: this.userProfile.state || '',
        country: this.userProfile.country || '',
        postalCode: this.userProfile.postalCode || '',
        bloodGroup: this.userProfile.bloodGroup || '',
        emergencyContactName: this.userProfile.emergencyContactName || '',
        emergencyContactNum: this.userProfile.emergencyContactNum || '',
        profileUrl: this.userProfile.profileUrl || ''
      });
    }
  }

  onSubmit(): void {
    if (this.profileForm.valid) {
      this.isLoading = true;
      const formData = this.profileForm.value;
      
      // Remove empty strings
      Object.keys(formData).forEach(key => {
        if (formData[key] === '') {
          delete formData[key];
        }
      });

      const currentUser = this.authService.getCurrentUser();
      if (!currentUser?.id) {
        this.toastService.showError('Please login to update profile');
        this.isLoading = false;
        return;
      }

      console.log('Updating profile for user ID:', currentUser.id);
      console.log('Update data:', formData);
      
      // Try full URL first
      const fullUrl = `${environment.apiUrl}/api/simple-profile/user/${currentUser.id}`;
      console.log('Update URL:', fullUrl);
      
      this.http.put<any>(fullUrl, formData).subscribe({
        next: (response) => {
          console.log('✅ Profile updated successfully:', response);
          this.userProfile = response.data;
          this.toastService.showSuccess('Profile updated successfully');
          this.isLoading = false;
        },
        error: (error) => {
          console.log('❌ Update failed with full URL:', error);
          
          // Try relative URL as fallback
          const relativeUrl = `/api/simple-profile/user/${currentUser.id}`;
          console.log('Trying relative URL:', relativeUrl);
          
          this.http.put<any>(relativeUrl, formData).subscribe({
            next: (response) => {
              console.log('✅ Profile updated with relative URL:', response);
              this.userProfile = response.data;
              this.toastService.showSuccess('Profile updated successfully');
              this.isLoading = false;
            },
            error: (relativeError) => {
              console.error('❌ Update failed with relative URL:', relativeError);
              this.toastService.showError(relativeError.error?.message || 'Failed to update profile');
              this.isLoading = false;
            }
          });
        }
      });
    } else {
      this.markFormGroupTouched();
    }
  }

  resetForm(): void {
    this.populateForm();
  }

  markFormGroupTouched(): void {
    Object.keys(this.profileForm.controls).forEach(key => {
      const control = this.profileForm.get(key);
      control?.markAsTouched();
    });
  }

  formatDate(dateString?: string): string {
    if (!dateString) return 'N/A';
    return new Date(dateString).toLocaleDateString();
  }

  private createMockProfileData(currentUser: any): void {
    console.log('Creating mock profile data...');
    
    // Create mock user profile data
    this.userProfile = {
      id: currentUser.id,
      name: currentUser.name || 'Test User',
      firstname: currentUser.name?.split(' ')[0] || 'Test',
      lastname: currentUser.name?.split(' ').slice(1).join(' ') || 'User',
      username: currentUser.username || 'testuser',
      email: currentUser.email || 'test@example.com',
      role: currentUser.role || 'PATIENT',
      birthdate: '',
      contact: '',
      countryCode: '',
      gender: '',
      address: '',
      city: '',
      state: '',
      country: '',
      postalCode: '',
      bloodGroup: '',
      emergencyContactName: '',
      emergencyContactNum: '',
      profileUrl: '',
      createdAt: new Date().toISOString()
    };
    
    this.populateForm();
    this.toastService.showSuccess('Profile loaded with mock data. API connection issue detected.');
    console.log('Mock profile data created:', this.userProfile);
  }

  testUpdate(): void {
    console.log('=== TESTING UPDATE ===');
    const currentUser = this.authService.getCurrentUser();
    
    if (!currentUser?.id) {
      this.toastService.showError('No user ID available for testing');
      return;
    }

    const userId = currentUser.id;
    const testUrl = `${environment.apiUrl}/api/simple-profile/test-update/${userId}`;
    console.log('Testing update URL:', testUrl);
    
    this.http.put<any>(testUrl, {}).subscribe({
      next: (response) => {
        console.log('✅ Test update successful:', response);
        this.toastService.showSuccess('Test update successful!');
        // Reload profile to see changes
        this.loadUserProfile();
      },
      error: (error) => {
        console.log('❌ Test update failed:', error);
        console.log('Error details:', error.error);
        this.toastService.showError('Test update failed: ' + error.message);
      }
    });
  }

  testApiCall(): void {
    console.log('=== TESTING API CALL ===');
    const currentUser = this.authService.getCurrentUser();
    console.log('Current user:', currentUser);
    console.log('Environment API URL:', environment.apiUrl);
    
    if (!currentUser?.id) {
      console.log('No user ID available for testing');
      this.toastService.showError('No user ID available for testing');
      return;
    }

    const userId = currentUser.id;
    const userEmail = currentUser.email;
    
    // Test 1: Full URL by ID
    const fullUrlById = `${environment.apiUrl}/api/simple-profile/user/${userId}`;
    console.log('Testing full URL by ID:', fullUrlById);
    
    this.http.get<any>(fullUrlById).subscribe({
      next: (response) => {
        console.log('✅ SUCCESS: Full URL by ID works!', response);
        this.toastService.showSuccess('API call successful with full URL!');
      },
      error: (error) => {
        console.log('❌ Full URL by ID failed:', error);
        
        // Test 2: Relative URL by ID
        const relativeUrlById = `/api/simple-profile/user/${userId}`;
        console.log('Testing relative URL by ID:', relativeUrlById);
        
        this.http.get<any>(relativeUrlById).subscribe({
          next: (response) => {
            console.log('✅ SUCCESS: Relative URL by ID works!', response);
            this.toastService.showSuccess('API call successful with relative URL!');
          },
          error: (relativeError) => {
            console.log('❌ Relative URL by ID failed:', relativeError);
            
            // Test 3: Full URL by email
            if (userEmail) {
              const fullUrlByEmail = `${environment.apiUrl}/api/simple-profile/email/${encodeURIComponent(userEmail)}`;
              console.log('Testing full URL by email:', fullUrlByEmail);
              
              this.http.get<any>(fullUrlByEmail).subscribe({
                next: (response) => {
                  console.log('✅ SUCCESS: Full URL by email works!', response);
                  this.toastService.showSuccess('API call successful with email!');
                },
                error: (emailError) => {
                  console.log('❌ All tests failed:', emailError);
                  this.toastService.showError('All API tests failed. Check console for details.');
                }
              });
            } else {
              this.toastService.showError('All API tests failed. No email available.');
            }
          }
        });
      }
    });
  }
}
