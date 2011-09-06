require 'spec_helper'

describe Week do
  before do
    @week = Week.new
  end
  
  it 'has todo items' do
    @week.should respond_to(:todo_items)
  end
  
  it 'has a week number' do
    @week.should respond_to(:nr)
  end
  
  it 'has an amount available hours' do
    @week.should respond_to(:available_hours)
  end
  
  it 'has an amount of completed hours' do
    @week.should respond_to(:completed_hours)
  end
  
  it 'has an amount of planned hours' do
    @week.should respond_to(:planned_hours)
  end
  
  it 'has a state of done/not done' do
    @week.should respond_to(:done)
  end
end
