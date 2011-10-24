require 'spec_helper'

describe "Weeks" do
  
  describe '#index' do
    before :each do
      @week = Factory(:week, :available_hours => 30, :nr => Date.today.cweek)
      visit weeks_path
    end
    
    it 'lists existing week' do
      page.should have_selector('ul.list li')
      all('ul.list li').should have(1).item
    end
    
    
    describe '#destroy' do
      before :each do
        click_link 'löschen'
      end
      
      it 'does not display any weeks in the overview' do
        all('ul.list li').should have(0).item
        page.should_not have_selector('ul.list li')
      end
      
      it 'removes the week factory in db' do
        Week.where(:nr => @week.nr).should be_blank
      end
    end
  end
end