I want to create a full-stack project of hospital-management system in angular 19 and spring boot using h2 database. dont use ngmodel in angular or no need to use builder in spring boot if it is complicated to use, It has following features/modules:
I want you to go step by step, read all the following features and actions first, then I have defined the backend schema for you in detail. create all of them for backend part, follow industry standard for project structure and codes, means create all those folders like dto, controller, repository, entity, service, exception. For authentication use jwt auth with HS256 algorithm. 


1
Patient Registration/Login
US001
As a User,i want register a patient by entering their perosonal and medical details so that they can recieve treatment
Patient should be able to acess registration page from the homepage.
1. It should have a clean UI with a heading: "Patient Registration".
The page should include the following fields:
-Patient Name (Text input, Required)
-Email (Text input, Required, Unique)
-Mobile Number (Country Code Dropdown + Number Input, Required, Unique)
-Address (Textarea, Required)
-Username (Text input, Required, Unique)
-Password (Password input, Required)
-Confirm Password (Password input, Required, Must match Password)
-Register Button (Disabled until all fields are valid)
-Reset Button (Clears all input fields)

Field Validations & Error Messages:
1. Patient Name: Required, Minimum 3 characters, Only alphabets & spaces allowed
-In case of error : "Name must be at least 3 characters long and contain only letters."
2. Email: Required, Valid Email Format (example@domain.com), Unique
- In case of error: "Enter a valid email address."
-In case of duplicate registration: "Email already registered”.
3. Mobile Number: Required, Country Code Dropdown (Mandatory), Only numbers, Min: 8 digits, Max: 10 digits, Unique
- In case of error : "Enter a valid mobile number." / "Mobile number already registered."
4. Address: Required, Minimum 10 characters
- In case of error: "Address must be at least 10 characters long."
5. Username: Required, Min: 5 characters, No spaces, Unique
- In case of erro: "Username must be at least 5 characters and unique."
6. Password: Required, Min: 8 characters, Must contain at least 1 uppercase, 1 lowercase, 1 digit, and 1 special character
- In case of error: "Password must be at least 8 characters and include a mix of uppercase, lowercase, number, and special character."
7. Confirm Password: Required, Must match Password
- In case of error: "Passwords do not match."
8. Register Button: Enabled only when all fields are valid.
9. Passwords should be encrypted before storing in the database.

Successful Registration Flow(Toast should be implemented).
2
Homepage (Web)
US002
As a patient, I want to access the homepage to view features offered, so that I can easily navigate and understand the services available.
1. Home Page Layout & Navigation
The home page should display a personalized welcome message with the customer’s name (e.g., "Welcome, <name>!").

The navigation menu should include the following options:
-Home (Redirects to the main landing page)
-book Appointments (Displays search form with required fields)
-My Appointments (Displays current and past appointment data, Update or cancel appointments)
- payments
-Register Complaint (Allows the user to submit a complaint, See a list of their registered complaints,View complaint statuses (Pending, In Progress, Resolved ,implement pagination) )
-Profile (Shows Patient details, edit profile, logout)

All menu options should be clickable and redirect to the appropriate pages.

2. Profile Section & Logout

The profile section should include:
-My Profile (Displays Patient name, email, mobile number, address)
-Edit Profile option to update personal details
-Logout Button to securely log out of the system. Clicking Logout should:
-End the session
-Redirect the user to the login page
-Prevent access to the home page after logout
* Use web concepts for the necessary actions if necessary.
3
Schedule a new appointment
US003
As a Patient, i want to schedule a patient appointment with a doctor .
1. Search Doctor Availability:
Recpetionist should be able to search for Doctor's availability based on below fields:
- Speciality
- Date for Appointment
- Search Button

When the search button is clicked, the system should validate all required fields.
If matching Details of the doctor are found:
-The system should fetch available the details like years of experience Qualification on the entered criteria.
-Provide a "Book Now" button for available rooms.
If no Doctor is available, a user-friendly message should be displayed. eg "No Doctor Found"

2. Field Validations & Error Handling:
1.Start time Validation:
-The field must be required.
-The date must be in the future (i.e., today's date or later).
-Selecting a past date should show an error:
-"Appointment date cannot be in the past.".
3.Search Button Validation:
-Should be disabled until all required fields are filled correctly.
-Clicking without valid input should not proceed and display error messages.
-If all inputs are valid, clicking should redirect to the results page.

3. Displaying Search Results:
After clicking Search, the system should display a list of available doctors matching the search criteria.Each Doctor's listing should include:
Name Of Doctors
Qualifications
Years Of Experience

4. Sorting & Filtering Options
Customers should be able to sort the search results by:
-Price: Low to High / High to Low
-Availability

5. User Interaction & Navigation
-Clicking "Book Now"(Enabled if the Doctor is available) should redirect the customer to the booking form with pre-filled details based on the search.

Expected User Flow:
1.User lands on the homepage.
2.User clicks on Search Doctors availability
3.User Clicks and selects the Speciality
4.User clicks Search (only enabled if all fields are valid).
5.System validates inputs and fetches available Doctors with details.
6.If doctorss are available, the user is redirected to the Details page.
7.If no Doctors are available, a message No Doctor Found within the provided time slot is Shown.
4
Payment(Web)
US004
As a Patient, I want to securely enter my payment details and complete the payment process, so that I can confirm my Appointments.
"1. Navigating to the Payment Screen
-Clicking ""Proceed to Pay"" on the Appointment Details confirmation page should navigate to the Payment Screen for card payments.

2. Payment Form Fields & Validations
The card payment form should include the following fields with validation:
-Cardholder Name: Required, alphabetic characters only (Min: 3, Max: 50)
-Card Number: Required, 16-digit numeric input
-Expiry Date (MM/YY):Required, must be in valid future format.
-CVV: Required, 3-digit numeric input for VISA/MasterCard, 4-digit for AMEX
-Billing Address: Optional, but if entered, must be at least 5 characters
Validations
-Invalid inputs should display an inline error message.
-If the card number is invalid, an error ""Invalid card number"" should be displayed.
-Expired cards should show an error ""Card expiry date must be in the future.""
-If CVV is incorrect, show ""Invalid CVV. Please check again.""

3. Clicking ""Pay Now"" should:
-Validate all inputs before proceeding.
-Redirect to a secure payment gateway for transaction processing.

4. Payment Success & Failure Handling
On successful payment:
-Redirect to Appointment Details Confirmation Page with success message popup ""Payment successful! Your Appointment Details is confirmed."" and following details:
1. Appointment Details ID
2. Payment transaction ID
3. Patient Names
4. Doctor Name,Timing for the appointment
5. Payment Amount
6. Reciept download option (PDF format)
On payment failure:
-Display an error message: "Transaction failed. Please check your details and try again."
-Allow the user to retry or choose a different payment method.

On session timeout:
-Redirect to the payment screen with a warning: "Your session has expired. Please re-enter your payment details.""

5. Post-Appointment Details confirmation
-The customer should be able to View the Appointment Details under ""My Appointment Detailss"".
-Cancel the Appointment Details.
- if Patient cancels the Appointment Details he should get a popup for confirmation and password should be entered to cancel the Appointment Details. after cancellation Patient will get a message. Popup should be displayed to user for refund in 3 to 5 working days .
-The system should prevent duplicate Appointment Detailss for the same class and Patient on same seat on same dates.
* Use web concepts for the necessary actions if necessary."

5
Reschedule/Cancel an Appointment(Web)
US005
As a Patient,i want to reschedule or cancel an appointment so that patient can re-scheduleing can be managed effieciently.
1. Accessing the Modify Booking Option
-The ""Modify Booking"" button should be available only for upcoming bookings (not for past or canceled bookings).
-Clicking ""Modify Booking"" should open a form allowing modifications.

2. Editable Fields in the Modify Booking Form
The customer should be able to edit the following:
-Date: Must be in the future; cannot be before the current date.
-The system should display real-time availability when changing dates.

3. Restrictions on Modifications
-Recalculate the total cost based on new details.
-Show any additional amount payable or refund due to modification.
-If the modification results in a higher price(Incase of change in doctor, the user must pay the difference before confirming changes.)
-After modifying the booking, the customer must review and confirm changes.
-A confirmation screen should show below details:
-Updated booking details.
-Any additional charges or refunds.
-A ""Proceed to Pay"" button if extra payment is needed.
-If the modification increases the price, the system should redirect the user to the payment screen before confirming changes.
-If the modification reduces the price, the system should: Display a message: ""Your updated booking costs less. Refund (if applicable) will be processed as per the cancellation policy.""
-Once successfully modified, the system should: Update the booking history with modified details and Show a success message: ""Your Changes has been successfully Implemenented.""
-Allow the customer to download the updated invoice.

4. Error Handling & Validations
-If the selected doctor is no longer available, display: ""The requested doctor is type is fully booked for these dates. Please choose another option.""
-If payment fails for additional charges, show: ""Modification failed due to payment error. Please try again.""

"The ""Cancel Booking"" button should be available only for upcoming bookings (not for past or already canceled bookings).
Clicking ""Cancel Booking"" should open a confirmation prompt asking the user to confirm the cancellation.

1. Cancellation of booking
-Free cancellation if done within the allowed period (e.g- before appointment date)

2. Refund Processing
-If eligible for a refund:
-Calculate the refund amount based on the policy.
-Display the refund amount before confirming cancellation.
-Show a confirmation message: ""Your booking has been canceled. A refund of ₹XXXX will be processed within 3-5 business days.""
-If not eligible for a refund, display a warning: ""As per the hotel’s policy, this booking is non-refundable.""

3. Post-Cancellation of booking
-After cancellation, the system should:
-Remove the ""Modify Booking"" option for the canceled Appointment Details.
-Update the booking status in ""Booking History"" as ""Canceled"".
-Disable the ""Download Invoice"" option.

3. Error Handling & Validations
-If cancellation is attempted after the allowed time, show: ""This booking cannot be canceled as it is past the allowed cancellation window.""
-If the booking is already checked in, do not allow cancellation
* Use web concepts for the necessary actions if necessary."
* Use web concepts for the necessary actions if necessary."
6
Admin Login(Web)
US006
As an admin, I want to access the homepage to view features offered, so that I can manage the operations
Only authorized admin users can access the admin home page. The home page should display a personalized welcome message (e.g., "Welcome, <name>!").

1. Provide a clear navigation menu with links to:
-Staff Management.(list of all doctors ,add doctor, Update details for doctors, remove Doctors)
-Booking Management.(view booking, add booking, update booking, cancel booking and search specific bookings by Appointment ID or Patient name.)
-Reports and Analytics.
-Profile (Shows admin details, edit profile, logout)
2. Dashboard Overview
-Display total number of bookings (daily, weekly, monthly).
-Total Revenue Generated.
-Present data in graphical formats (e.g., charts, graphs) for quick analysis.
7
Admin-Manage Doctor Profiles(Web)
US007
As an admin ,i want to add and update doctor profiles so that patient appointments are assigned correctly.
Validations such as -
Doctors Profile can be added and removed only by admin.
Qualifications can be updated and only allowed to in a cetain format only (String)
Years of experience should be number only(Greater Than 0)


Name in String Only.(In Case numbers are there toast should be raised saying that name cannot have numbers)
Years of experience should be in numbers only.(Greater Than 0)
Qualifications can be added and message displayed as (Updated Successfull !)
8
Admin Manage Appointments - Web
US008
As an Administrator, I want to view/add/modify/delete customer Appointment Detailss so that I can manage bookings effectively.
1. View All Appointment Detailss
On clicking the View Appointment Detailss, the system displays a comprehensive list of all Appointment Detailss with proper paginations, including details such as:
-Appointment ID
-Patient Name
-Appointment Details Status (e.g., Confirmed, Checked-in, Cancelled)

2. Sorting and Filtering:
-Administrators can sort and filter Appointment Detailss based on criteria like date range,or Appointment Details status to efficiently manage bookings.
-For large sets of results, the system implements pagination to display a manageable number of records per page (e.g., 10 Appointment Detailss per page).
-Administrators can sort search results by any column in ascending or descending order.
-Additional filters can be applied to narrow down results based on specific criteria (e.g., filtering by Appointment Details status).

3. List Appointment Details Display
The system displays results in a tabular format, including:
-Appointment ID
-Time
-Patient Name
- Doctor name to be consulted
-Appointment Details Status

Within the results, administrators have access to quick action buttons for each Appointment Details, such as:
-Edit Appointment Details
-Cancel Appointment Details

4. Edit Appointment Detailss
Administrators can update Appointment Details details, including:
-Date
-Time
-Assigned Doctor
-Special Requests or Notes

Validations:
-Modifications to dates must not conflict with existing Appointment Detailss or result in overbooking.
-Reassigning a Doctor should only be possible if the a new Doctor is available for the entire Appointment Details period.
-If a modification violates any validation rules, the system provides a clear error message, and the changes are not saved.

5. Cancel Appointment Detailss
Administrators can cancel Appointment Detailss, prompting:
-A confirmation dialog to prevent accidental cancellations.
Validations:
-Appointment Detailss that are currently checked-in or already completed cannot be canceled.
-Cancelled Appointment Detailss remain in the system for record-keeping and reporting purposes but are marked distinctly as canceled.

6. Create New Appointment Detailss
Administrators can access a form to input Appointment Details details, including:
-Patient Information:
-Appointment ID
-Full Name
-Contact Details (phone number and email address)
-Appointment Details Details:
-Appointment Date
-Payment Information:
-Payment Method (e.g., credit card, cash)
Validations:
-The system checks that the selected Doctor is available for the specified dates.
-All required information must be provided before saving the Appointment Details.
-Upon successful Booking of appointment, the system generates a unique Appointment Details id and displays a confirmation message to the admin."You have successfully reserved the Doctor" along with appointment id and customer details.
9
Search Appointments- Web
US009
As an administrator, I want to search customer Appointment Detailss using various criteria so that I can efficiently manage bookings.
1. Search Appointment Details
Administrators can search Appointment Detailss using the following criteria:
-Appointment ID
-Patient Name
-Appointment Details Status (e.g., Confirmed, Checked-in, Cancelled)
-Booking Date

2. Input Validation
-The system validates search inputs to prevent errors:
-Date fields must be in the correct format (e.g., MM/DD/YYYY).
-Text fields should not contain special characters unless necessary (e.g., hyphens in names).
-If invalid input is detected, the system prompts the administrator to correct it.

3. Search Results Display
The system displays search results in a tabular format, including:
-Appointment ID
-Patient Name
-Room Number
-Date
-Appointment Details Status
-Total Amount

Within the search results, administrators have access to quick action buttons for each Appointment Details, such as:
-Edit Appointment Details
-Cancel Appointment Details
-For large sets of results, the system implements pagination to display a manageable number of records per page (e.g., 10 Appointment Detailss per page).
10
Patient Complaint
US0010
As a patient i should be able to raise a compliant. about any type of issues that i have faced during my treatment period in hospital.
Clicking on "Register Complaint" should open the complaint submission form.

1. Complaint Registration Form Fields & Validations
-Complaint Category: Mandatory dropdown with predefined options (Treatment Issue, Service Issue, Billing Issue, Other).
-Appointment ID : Appointment ID of Patient.
-Complaint Title: Mandatory, min 10 characters, max 100 characters.
-Complaint Description: Mandatory, min 20 characters, max 500 characters. Should provide a clear explanation of the issue.
-Contact Preference: Mandatory radio button (Call, Email).
-Submit Button: Enabled only when all mandatory fields are filled.
-Reset Button: Clears the form fields.

2. When the user clicks "Submit", the system should:
-Validate all inputs.
-Generate a unique complaint reference number.
-Store the complaint details in the database.
-Display a confirmation screen with: "Your complaint has been successfully submitted. Complaint ID: #XXXXXX. Our support team will get back to you soon."
-The system should send a complaint acknowledgment SMS/email with the complaint ID and expected resolution time.
-Update the "View Complaints" section so that the customer can track the complaint status.
-Allow the user to edit the complaint if it is in the "Open" status.

3. Error Handling & Validations
-If a mandatory field is missing, display an error: "Please fill in all required fields."
-If the complaint is too short, prompt: "Please provide more details to help us resolve your issue."
* Use web concepts for the necessary actions if necessary.
11
Track Complaint
US0011
As a patient, I want to track the status of my complaint to see if it is resolved or in progress, so that I know when to expect a resolution.
A "View Complaints" option should be available in the navigation menu. On clicking "View Complaints" should open a list of previously registered complaints.
1. Displaying Complaint Details
-The complaint list should display:
-Complaint ID
-Complaint Category (Treatment Issue, Service Issue, Billing Issue, Other)
-Complaint Title
-Submission Date
-Current Status (Open, In Progress, Resolved, Closed)
-Expected Resolution Date
-If no complaints are found, display: "You have not registered any complaints."

2. Viewing Complaint Details
-Clicking on a complaint should open a detailed complaint view, showing:
-Full complaint description
-Response from support team (if any)
-Resolution notes (if resolved)

3. Complaint Status Updates
-The complaint should have a status that updates based on progress:
-Open: Complaint has been submitted but not yet reviewed.
-In Progress: Support team is working on the resolution.
-Resolved: Issue has been resolved, pending customer confirmation.
-Closed: Complaint is closed and cannot be modified.
-If a complaint is marked Resolved, the user should have an option to:
-Confirm Resolution (marks it as Closed).
-Reopen Complaint (if the issue is not resolved).
-If a complaint is Closed, the customer should:
-Be able to view but not edit the complaint.
-View the final resolution details.

4. Error Handling & Validations
-If the user tries to view a complaint that does not exist: "The complaint you are looking for does not exist or has been deleted."
-If there is a server error, display: "Unable to fetch complaint status. Please try again later."
* Use web concepts for the necessary actions if necessary.
12
Manage Complaints – Admin
US012
As an admin, I want to view and manage all customer complaints so that I can ensure prompt resolution.
1. Complaint Dashboard
-Administrators have access to a complaint dashboard displaying all complaints with key information:
-Complaint ID
-Customer Name
-Submission Date
-Category
-Current Status
-Assigned Staff Member

2. Search and Filter Functionality:
-Administrators can search and filter complaints based on various criteria, such as:
-Date Range
-Complaint Category
-Status
-Customer Name or ID

3. Complaint Assignment:
-The system notifies the assigned personnel and updates the complaint status accordingly.

4. Status Updates and Notifications:
-The system allows administrators and assigned staff to update the status of complaints as they progress through resolution stages.

5. Response and Resolution Tracking:
-Administrators can record actions taken to address each complaint, including:
-Date and Time of Actions
-Details of Investigations or Interactions
-Resolutions Provided





I have already defined the backend schema for it, and i want you to strictly follow that only:

You are an expert backend developer who has the best possible knowledge of Spring Boot and api creation with an industry-standard structure. I am working on a hospital management system, which has several related tables that I have already defined. Now, I am trying to make them work in Spring Boot along with working APIs. I already have the setup ready and working for the users table; it is up and running perfectly with JWT authentication. It has the following folders in my project:

Config 
Controller
Dto
Entity
Exception
Repository
Security
Service

The users table includes various fields that you may not need to worry about now, as it is done, but just for your context, I am gonna give you all the tables and their fields so you may understand their relations properly and can design their APIs accordingly. so here are the tables:

users
id
name
birthdate
firstname
lastname
username
role - [ADMIN, SUPERADMIN, PATIENT]
email
contact
gender [male, female, other]
password_hash
emergency_contact_name na
emergency_contact_num na
state na
city na
address na
country na
country_code na
postalCode na
blood group na
profile_url na
last_login_at na

Specialization
SpecializationId unique,
name unique [ex - neurology, cardiology, orthopedics] think about more for advanced options,
description na, 
status -['active','inactive']

Doctors
DoctorId unique, 
User_Id(foreign key from users cause doctor is also a user too
Specialization_Id (foreign key from specialization table),
License_number,
Years_of_exp,
Qualification,
Consultation_fee,
Status -['active','Inactive'],
Joining_date,
bio na

Doctor_slot_template
Id,
doctor_id(foreign key from doctors),
day_of_week(0-6),
startTime,
endTime,
slot_duration (minutes),
break_duration (minutes),
is_active(true, false)


Complaints 
Complaint id unique
Patientidforeign key from users
Appointmentid from appointments table
Category - (treatment issue, service, billing, staff, facility, other) - think about them on your own appropriately
Title
Description 
Contact_preference (call, email, sms)
Priority (low, medium, high, critical) (by default medium)
Status (open, in-progress, resolved, closed, reopened) 
Assigned to - foreign key from users (userId)
Resolution notes na
CustomerFeedback na


Appointments
Id
Patientid foreign key from users with the role patient
Doctorid foreign key from doctors
Appointmentdate
Appointment time
End time
Status (scheduled, confirmed, cancelled)
Appointment type (consultation, follow-up, emergency)
Consultation fee
Symptoms na
Notes na
Cancelled by na - user id from users
Cancelled at na
Cancellation reason na

Payment table
id → Primary Key
payment_id → Business identifier (unique string/number)
appointment_id → Foreign key to appointments table
patient_id → Foreign key to patients table
amount → Numeric field
method → Enum / String (Card, Cash, UPI, NetBanking)
status → Enum / String (SUCCESS, PENDING, FAILED)
transaction_id → External transaction reference
payment_date → Timestamp


Doctor slots
id → Primary key
doctor_id → Foreign key (to doctors table)
slot_date → Date of slot
start_time → Start time of slot
end_time → End time of slot
status → Enum (AVAILABLE, BOOKED, BLOCKED)

Doctor slots table is completely based on doctor slot template table, here i am hoping to have slots available for a doctor up to next one month, slots should be created based on the date's day of week and that doctors' schedule on that day, you know that slot duration, start-end time, and break duration, so make it work that way to divide slots, and keep them available initially, as someone books it, status should change and get to booked. The doctor may block that session based on his availability.

Session table
id 
user-id (from users table)
session-token.
Is-active.
expires-at

Audit logs table
id
user-id (from users table)
action (Insert, update, delete, select
table name
time


Wherever I have written na means that the field can be null or empty, as per my understanding, apply the same as you feel where necessary. also, i need deletedAt, deletedBy, createdAt, createdBy, updatedAt, updatedBy fileds for all tables for soft deletions and tracking you know. My package name is com.example.SpringDemo, so keep that in mind too.

That was all for tables and their relation. now, important part: I want you to create all the relevant files for whatever I am asking you in a proper structure. I have a users table part with proper structure and JWT auth for securely accessing APIs. So, follow that. Make all the needed APIs for my part, following proper industry standards. Suppose there is a get api, then apply pagination. There is a response (so data does not get flooded with huge responses), in search, apply it like ontext change, where search text is there along with a parameter, meaning search based on what is in the query params. for filters and sorting too follow it, like asc desc and filtering based on what through query params properly. So, give me all the related codes and required APIs for it, based on your understanding and relations between tables. You are free to make improvements where you feel, but don't overdo it. Just follow what I have instructed you:

So I need their codes along with the required APIs in proper structure.


You are an experienced senior master full stack developer, who has all possible knowledge of
frontend and backend system design, architecture, JS, TS, angular, modern styling and themes, 
JAVA Spring Boot for backend, API designing, modular features implementation, Now, I want your assistance in creating my collaboration project of hospital management, I want you to follow the best possible practices of creating angular project in a way that when we are merging it with other members' codes, it creates least difficulties for us, Use modern design
themes, i m thinking of blue, white kind of design, we are supposed to use normal CSS only, not tailwind. Angular version is 20. the design should be clean, very modern, engaging, user-friendly it should give positive vibes, and feeling of trust.

just for your context the full system has features;
Patient registration, login
View Home page
Schedule a new appointment
Payment
Reschedule/cancel appointment
create invoice
register complaint
track complaint
Update profile details

Admin:
login
manage doctor profiles
manage users
Add doctor
Manage and search customer appointments
Manage customer complaints


the routes are like normal but for admin special pages they will be followed by /admin and will be blocked for normal users to access. Make use of best modern design patterns, themes, different icons, etc.

Now, I will be giving you detailed description of my parts of features, you help me set up angular project having files for those, right noI want codes for TS, html, CSS of Angular components that i will be creating with proper file structure, since i m new to angular, help me get those done step by step. my project should be up and running showing these beautiful UI. In all files on top write a comment showing full path to that file...



