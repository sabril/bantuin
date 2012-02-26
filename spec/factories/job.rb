# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jobs do
      addressable_id "MyString"
      addressable_type "MyString"
      title "MyString"
      description "MyText"
      area "MyString"
      salary "MyString"
      keyword "MyString"
    end
end