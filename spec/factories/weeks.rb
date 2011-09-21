FactoryGirl.define do
  factory :week do
    nr { Factory.next :num }
    available_hours { Factory.next(:num) * 10 }
    done false
  end
end
