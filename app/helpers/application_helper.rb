module ApplicationHelper
  
  def render_todo_lists collection, action, week = nil
    week ||= @week
    render :partial => :todo_list, 
      :collection => collection,
      :locals => {
        :action => action,
        :week => week
      }
  end
end
