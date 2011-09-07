require 'spec_helper'

describe 'Routing for weeks' do
  
  it 'routes GET /weeks/current to weeks#current' do
    { :get => '/weeks/current' }.should route_to(
      :controller => 'weeks',
      :action => 'current'
    )
  end
  
  it 'routes GET /weeks to weeks#index' do
    { :get => '/weeks' }.should route_to(
      :controller => 'weeks',
      :action => 'index'
    )
  end

  it 'routes GET /weeks/1 to weeks#show' do
    { :get => '/weeks/1' }.should route_to(
      :controller => 'weeks',
      :action => 'show',
      :id => '1'
    )
  end
  
  it 'routes GET /weeks/new to weeks#new' do
    { :get => '/weeks/new' }.should route_to(
      :controller => 'weeks',
      :action => 'new'
    )
  end
  
  it 'routes GET /weeks/1/edit to weeks#edit' do
    { :get => '/weeks/1/edit' }.should route_to(
      :controller => 'weeks',
      :action => 'edit',
      :id => '1'
    )
  end
  
end