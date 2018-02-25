FactoryBot.define do

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "johndoetest#{n}"
    end 
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
  end 

  factory :piece do
  end 

end 