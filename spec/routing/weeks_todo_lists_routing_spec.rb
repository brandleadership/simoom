require 'spec_helper'

describe 'Routing for weeks_todo_lists' do
  
  it 'routes POST /weeks_todo_lists to weeks_todo_lists#create' do
    { :post => '/weeks_todo_lists' }.should route_to(
      :controller => 'weeks_todo_lists',
      :action => 'create'
    )
  end
  
  it 'routes DELETE /weeks/1 to weeks_todo_lists#destroy' do
    { :delete => '/weeks_todo_lists/1' }.should route_to(
      :controller => 'weeks_todo_lists',
      :action => 'destroy',
      :id => '1'
    )
  end  
end