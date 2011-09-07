class WeeksController < ApplicationController
  
  respond_to :html
  
  def index
  end

  def edit
    @week = Week.find(params[:id])
    respond_with(@week)
  end
  
  def update
    week = Week.find(params[:id])
    if week.update_attributes(params[:week])
      redirect_to week_path(week)
    else
      render 'edit'
    end
  end

  def show
  end

  def new
    @week = Week.new
    respond_with @week
  end
  
  def create
    week = Week.new params[:week]
    if week.save
      redirect_to week_path(week)
    else
      render 'new'
    end
  end
  
  def current
    if week = Week.last
      redirect_to week_path(week)
    end
  end
  
end
