require 'spec_helper'

describe WeeksController do
  before do
    @week = Factory(:week)
  end
  
  describe "GET 'index'" do
    it "is successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "is successful" do
      get 'edit', :id => @week.id
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "is successful" do
      get 'show', :id => @week.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "is successful" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'current'" do
    it 'redirects to the latest week' do
      get 'current'
      response.should be_redirect
    end
  end

end