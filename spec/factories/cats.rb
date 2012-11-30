# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cat do
    url 'https://theresashultz.s3.amazonaws.com/cats/4644853935406166.gif'
    original_url 'https://theresashultz.s3.amazonaws.com/cats/71.gif'
    file_name '4644853935406166.gif'
  end
end
