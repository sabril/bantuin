# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
      addressable_id_user "MyString"
      addressable_id_jobs "MyString"
      salary "MyString"
      cover_letter "MyText"
    end
end