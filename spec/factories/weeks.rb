# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :num do |n|
    n
  end
  
  factory :week do
    nr { Factory.next :num }
    available_hours { Factory.next(:num) * 10 }
    done false
  end
end