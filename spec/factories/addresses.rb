# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
      line_1 "MyString"
      line_2 "MyString"
      city "MyString"
      state "MyString"
      zip "MyString"
      longitude "MyString"
      latitude "MyString"
    end
end