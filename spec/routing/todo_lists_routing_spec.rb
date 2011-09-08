require 'spec_helper'

describe 'Routing for todo lists' do
  
  it 'routes GET /todo_lists to todo_lists#index' do
    { :get => '/todo_lists' }.should route_to(
      :controller => 'todo_lists',
      :action => 'index'
    )
  end

  it 'routes GET /todo_lists/1 to todo_lists#show' do
    { :get => '/todo_lists/1' }.should route_to(
      :controller => 'todo_lists',
      :action => 'show',
      :id => '1'
    )
  end
  
  it 'routes GET /projects/1/todo_lists to todo_lists#show' do
    pending 'do we really need this?'
    { :get => '/projects/1/todo_lists' }.should route_to(
      :controller => 'todo_lists',
      :action => 'index',
      :project_id => '1'
    )
  end  
end