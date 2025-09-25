import { AbstractControl, ValidationErrors, ValidatorFn } from '@angular/forms';

export class CustomValidators {
  
  // Date validators
  static futureOrToday(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const selectedDate = new Date(control.value);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (selectedDate < today) {
      return { pastDate: true };
    }
    return null;
  }

  static pastDate(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const selectedDate = new Date(control.value);
    const today = new Date();
    today.setHours(23, 59, 59, 999);
    
    if (selectedDate > today) {
      return { futureDate: true };
    }
    return null;
  }

  static maxAge(maxYears: number = 100): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
    if (!control.value) return null;
    
    const selectedDate = new Date(control.value);
    const today = new Date();
    const maxDate = new Date();
    maxDate.setFullYear(today.getFullYear() - maxYears);
    
    if (selectedDate < maxDate) {
      return { tooOld: { maxAge: maxYears } };
    }
    return null;
    };
  }

  // Contact number validators
  static indianPhoneNumber(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const phoneRegex = /^[6-9]\d{9}$/;
    if (!phoneRegex.test(control.value)) {
      return { invalidPhone: true };
    }
    return null;
  }

  // Name validators
  static textOnly(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const textRegex = /^[a-zA-Z\s]+$/;
    if (!textRegex.test(control.value)) {
      return { invalidText: true };
    }
    return null;
  }

  // Email validators
  static email(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(control.value)) {
      return { invalidEmail: true };
    }
    return null;
  }

  // Doctor email validators
  static doctorEmail(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const emailRegex = /^[^\s@]+@doctor\.com$/;
    if (!emailRegex.test(control.value)) {
      return { invalidDoctorEmail: true };
    }
    return null;
  }

  // Input restrictions
  static numbersOnly(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const numberRegex = /^\d+$/;
    if (!numberRegex.test(control.value)) {
      return { numbersOnly: true };
    }
    return null;
  }

  static textOnlyInput(control: AbstractControl): ValidationErrors | null {
    if (!control.value) return null;
    
    const textRegex = /^[a-zA-Z\s]*$/;
    if (!textRegex.test(control.value)) {
      return { textOnly: true };
    }
    return null;
  }
}
