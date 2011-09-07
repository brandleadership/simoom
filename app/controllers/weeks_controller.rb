class WeeksController < ApplicationController
  
  def index
  end

  def edit
  end

  def show
  end

  def new
  end
  
  def current
    redirect_to week_path(Week.last)
  end
  
end
