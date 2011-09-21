FactoryGirl.define do
  factory :todo_list do
    estimate { Factory.next(:num) }
  end
end
