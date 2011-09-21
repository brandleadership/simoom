require 'spec_helper'

describe "CurrentWeeks" do

  context 'when no week has been created' do

    before :each do
      visit weeks_path
      click_link('Aktuelle Woche')
    end

    it 'displays a hint to create a week' do
      Week.all.size.should be 0
      page.should have_content('Es gibt noch keine aktuelle Woche, leg doch mal eine an. Neue Woche anlegen')
    end
  end

  context 'when the current week exists' do

    before :each do
      @week = Factory(:week, :available_hours => 30, :nr => Date.today.cweek)
      @todo_list = TodoList.new(:estimate => 10)
      @todo_list.project = Project.create(:name => 'test')
      @todo_list.save
      @week.todo_lists << @todo_list
      @week.save
      visit weeks_path
      click_link('Aktuelle Woche')
    end

    context 'and no work has been completed' do
      it 'shows that 0 hours have been completed' do
        page.should have_content('Es sind 0h von 30h erledigt. Auf geht\'s!')
      end
    end

    context 'and some work has been completed' do
      it 'shows how much work has been completed' do
        todo = @week.todo_lists.first
        todo.state = TodoList::STATE_DONE
        todo.save
        visit(current_path)
        page.should have_content('Es sind 10h von 30h erledigt. Auf geht\'s!')
      end
    end
  end
end
