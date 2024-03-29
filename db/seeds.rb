# frozen_string_literal: true

require 'faker'

AdminUser.create!(phone: '+380631234567', password: 'password', password_confirmation: 'password') if Rails.env.development?

20.times do
  user = User.create!(
    phone: "+38063#{Faker::Number.number(digits: 7)}",
    password: 'password',
    password_confirmation: 'password'
  )

  Profile.create!(
    person_id: user.id,
    person_type: 'User',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

p "Created #{User.count} users"

20.times do
  doctor = Doctor.create!(
    phone: "+38063#{Faker::Number.number(digits: 7)}",
    password: 'password',
    password_confirmation: 'password'
  )

  Profile.create!(
    person_id: doctor.id,
    person_type: 'Doctor',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

p "Created #{Doctor.count} doctors"

categories = [
  'Allergy and immunology',
  'Anesthesiology',
  'Dermatology',
  'Diagnostic radiology',
  'Emergency medicine',
  'Family medicine',
  'Internal medicine',
  'Medical genetics',
  'Neurology',
  'Nuclear medicine',
  'Obstetrics and gynecology',
  'Ophthalmology',
  'Pathology',
  'Pediatrics',
  'Physical medicine and rehabilitation',
  'Preventive medicine',
  'Psychiatry',
  'Radiation oncology',
  'Surgery',
  'Urology'
]

categories.map do |category|
  Category.create!(name: category)
end

p "Created #{Category.count} categories of doctors"

doctor_ids = Doctor.pluck(:id)

doctor_ids.map do |id|
  category_sample_id = Category.find(Category.pluck(:id).sample).id

  Specialization.create!(doctor_id: id, category_id: category_sample_id)
end

p 'The categories are intended for doctors'

user_ids = User.pluck(:id)

user_ids.map do |id|
  6.times do
    Appointment.create!(
      doctor_id: doctor_ids.sample,
      user_id: id,
      appointment_date: DateTime.now,
      symptoms: Faker::Lorem.paragraph_by_chars
    )

    Appointment.create!(
      doctor_id: doctor_ids.sample,
      user_id: id,
      appointment_date: DateTime.now,
      symptoms: Faker::Lorem.paragraph_by_chars,
      recommendation: Faker::Lorem.paragraph_by_chars,
      aasm_state: :closing
    )
  end
end

p "Appointments #{Appointment.count} created"
