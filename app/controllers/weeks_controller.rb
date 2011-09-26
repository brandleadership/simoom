class WeeksController < ApplicationController
  
  respond_to :html, :js, :pdf
  
  def index
    @weeks = Week.order('nr DESC')
  end

  def edit
    @week = Week.includes(:todo_lists).find(params[:id])
    @available_projects = Project.by_name.select do |project|
      project.todo_lists.exists?
    end
    respond_with(@week)
  end
  
  def update
    week = Week.find(params[:id])
    if week.update_attributes(params[:week])
      respond_to do |format|
        format.html { redirect_to week_path(week) }
        format.js   { render :update }
      end
    else
      render 'edit'
    end
  end

  def show
    @week = Week.find(params[:id])
    respond_with @week do |format|
      format.pdf do
        @document = PdfTemplate::StoryCard.new(@week)
        send_data @document.to_pdf.render, :filename => "Storycards_Week_#{@week.nr}.pdf", :type => 'application/pdf'
      end
    end
  end

  def new
    @week = Week.new
    respond_with @week
  end
  
  def create
    @week = Week.new params[:week]
    if @week.save
      redirect_to week_path(@week)
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
