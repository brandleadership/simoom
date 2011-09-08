class Project < ActiveRecord::Base

  has_many :todo_lists
  scope :by_name, order('name ASC')

  #
  # Fetch the child items from basecamp
  #
  def fetch_items
    Basecamp::TodoList.find(:all, :params => { :project_id => basecamp_id })
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
        list_attributes = {
          :basecamp_id => list.id,
          :name => list.name,
          :estimate => (list.description.present? ? list.description.match(Basecamp::Importer::ESTIMATE_MATCHER).to_s : nil)
        }

        list = ::TodoList.find_or_initialize_by_basecamp_id(list.id, list_attributes)
        list.sync(log_level)

        list
      end
    end
  end

end
