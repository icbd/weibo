User.create!(
    name: 'Example',
    email: 'Example@gmail.com',
    password: '123456',
    password_confirmation: '123456',
    admin: true,
    activated: true,
    activated_at: Time.zone.now
)

99.times do |i|
  name = Faker::Name.name
  email = "example-#{i+1}@railstutorial.org"
  password = '123456'

  User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now
  )
end