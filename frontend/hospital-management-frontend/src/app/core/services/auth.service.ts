// frontend/hospital-management-frontend/src/app/core/services/auth.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { environment } from '../../../environments/environment';
import { LoginRequest, LoginResponse, PatientRegistrationRequest, User } from '../models/user.model';
import { ApiResponse } from '../models/api-response.model';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly API_URL = `${environment.apiUrl}/api/auth`;
  private currentUserSubject = new BehaviorSubject<User | null>(null);
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient) {
    this.loadUserFromStorage();
  }

  login(credentials: LoginRequest): Observable<ApiResponse<LoginResponse>> {
    return this.http.post<ApiResponse<LoginResponse>>(`${this.API_URL}/login`, credentials)
      .pipe(
        tap(response => {
          if (response.success) {
            if (typeof window !== 'undefined') {
              localStorage.setItem('token', response.data.token);
              localStorage.setItem('user', JSON.stringify(response.data));
            }
            this.setCurrentUser(response.data);
          }
        })
      );
  }

  register(patientData: PatientRegistrationRequest): Observable<ApiResponse<User>> {
    return this.http.post<ApiResponse<User>>(`${this.API_URL}/register`, patientData);
  }

  logout(): void {
    if (typeof window !== 'undefined') {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
    }
    this.currentUserSubject.next(null);
  }

  getToken(): string | null {
    if (typeof window !== 'undefined') {
      return localStorage.getItem('token');
    }
    return null;
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }

  getCurrentUser(): User | null {
    return this.currentUserSubject.value;
  }

  isAdmin(): boolean {
    const user = this.getCurrentUser();
    return user?.role === 'ADMIN' || user?.role === 'SUPERADMIN';
  }

  validateToken(): Observable<boolean> {
    const token = this.getToken();
    if (!token) {
      return new BehaviorSubject(false).asObservable();
    }

    // In a real app, you would validate the token with the backend
    // For now, we'll just check if it exists and is not expired
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      const isExpired = payload.exp * 1000 < Date.now();
      
      if (isExpired) {
        this.logout();
        return new BehaviorSubject(false).asObservable();
      }
      
      return new BehaviorSubject(true).asObservable();
    } catch (error) {
      this.logout();
      return new BehaviorSubject(false).asObservable();
    }
  }

  private setCurrentUser(loginResponse: LoginResponse): void {
    const user: User = {
      id: loginResponse.id,
      name: loginResponse.name,
      firstname: loginResponse.name.split(' ')[0] || '',
      lastname: loginResponse.name.split(' ').slice(1).join(' ') || '',
      username: loginResponse.username,
      email: loginResponse.email,
      contact: '',
      countryCode: '',
      address: '',
      role: loginResponse.role as 'ADMIN' | 'SUPERADMIN' | 'PATIENT',
      createdAt: '',
      updatedAt: ''
    };
    this.currentUserSubject.next(user);
  }

  private loadUserFromStorage(): void {
    if (typeof window !== 'undefined') {
      const token = this.getToken();
      const userData = localStorage.getItem('user');
      
      if (token && userData) {
        try {
          // Validate token first
          const payload = JSON.parse(atob(token.split('.')[1]));
          const isExpired = payload.exp * 1000 < Date.now();
          
          if (isExpired) {
            this.logout();
            return;
          }
          
          const loginResponse: LoginResponse = JSON.parse(userData);
          this.setCurrentUser(loginResponse);
        } catch (error) {
          console.error('Error parsing user data from localStorage:', error);
          this.logout();
        }
      }
    }
  }
}
