class Project < ActiveRecord::Base

  STATUS_ACTIVE = 'active'
  STATUS_ARCHIVED = 'archived'

  has_many :todo_lists
  scope :by_name, order('name ASC')
  scope :active, where('status = ?', STATUS_ACTIVE)
  
  #
  # Fetch the child items from basecamp
  #
  def fetch_items(options = {})
    exclude = true
    exclude = false if options.delete(:exclude) == false

    list = Basecamp::TodoList.find(:all, :params => { :project_id => basecamp_id })
    list = list.reject { |t| t.name.include?('[exclude]') } if list.present? && exclude == true
    list
  end

  #
  # Map the child items from basecamp to local child objects
  #
  def sync(log_level = :info)
    @logger = Basecamp::ImportLogger.new(log_level)
    basecamp_lists = fetch_items

    unless basecamp_lists.blank?
      @logger.log :debug, "found #{basecamp_lists.size} Todo Lists for #{name}"
      todo_lists << basecamp_lists.map do |list|
        list_attributes = list.extract_attributes
        
        list = ::TodoList.find_or_initialize_by_basecamp_id(list.id, list_attributes)
        list.update_attributes(list_attributes) if list.persisted?
        list.sync(log_level)

        list
      end
    end
  end
end
