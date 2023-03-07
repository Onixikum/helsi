# README

## Test task for RoR dev
## Implement a project for managing a polyclinic

### Types of users:

* patient (User)
* doctor (Doctor)
* Admin

### For each type of user, the following functionality must be implemented:

1. The patient can register, log in to their personal account (Profile), view a list of doctors by categories, make an appointment, and receive recommendations from the doctor after the visit.

2. The doctor can log in to their personal account (Profile), view a list of patients who have made appointments, provide recommendations to the patient. The doctor can belong to a certain category (therapist, cardiologist, etc.).

3. The admin has access to the list of patients and doctors. Can create categories, doctors, assign a particular doctor to a category (can be implemented through ActiveAdmin/Administrate).

### Authentication and authorization requirements:

* use devise;
* implement login via phone-password;
* use the cancancan gem to differentiate user rights;

### Requirements for the category table:

* validation for uniqueness by name;
* ability to add multiple doctors;

### Requirements for the Doctor-Patient tables:

* implement a many-to-many relationship;
* a doctor can have only 10 open appointments (simultaneously);
* the appointment is automatically closed (not deleted) after the doctor writes a recommendation to the user;

### Testing:

* For the test project, it is necessary to write 3 types of tests: model, feature, request.
* Use RSpec, preferably factory_bot_rails and faker.
* Model. write a test for validating the phone_number field for the Doctor model
* Request. check the operation of the create action for any controller
* Feature. log in as a doctor and leave a recommendation for the patient
