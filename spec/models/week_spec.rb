require 'spec_helper'

describe Week do
  before do
    @week = Week.new
  end
  
  context 'without any attributes' do
    before :each do
      @current_week = Factory(:week)
      @week.nr = @current_week.nr
    end
    
    it 'does not pass' do
      @week.should_not be_valid
    end
    
    it 'has 2 errors' do
      @week.valid?
      @week.errors.should have(2).items
    end
  end
  
  
  context 'with valid attributes' do
    before :each do
      @week.nr = '39'
      @week.available_hours = 60
    end
    
    it 'pass the validations' do
      @week.should be_valid
    end
  end
  
  context 'when destroy a week' do
    before :each do
      @week = Factory(:week, :available_hours => 30, :nr => Date.today.cweek)
      @todo_list = TodoList.new(:estimate => 10)
      @todo_list.project = Project.create(:name => 'test')
      @todo_list.save
      @week.todo_lists << @todo_list
      @week.save
    end
    
    it 'removes the week and associated week todo list' do
      lambda {
        lambda {
          @week.destroy
        }.should change(Week, :count).by(-1)
      }.should change(WeekTodoList, :count).by(-1)
    end
  end
  
  
  it 'has todo_lists' do
    @week.should respond_to(:todo_lists)
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
