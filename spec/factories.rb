FactoryBot.define do

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    username "johndoetest"
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
    name "Test" 
  end 

end 