module Basecamp
  class Importer

    #
    # Projects must include the P-Number, so that developers can log their
    # work hours on them. This means They need to be named according to the
    # predefined pattern: <Project Name> - P<P-Number>
    #
    # Projects not matching this naming pattern will be discarded
    #
    P_NUMBER_MATCHER = / \- P\d+$/
    ESTIMATE_MATCHER = /(\d|\d.\d+)h/

    #
    # Sync Local DB with Basecamp
    #
    def self.perform
      projects = Basecamp::Project.find(:all)

      puts "Found #{projects.size} projects"

      projects = projects.reject { |p| !(p.name =~ P_NUMBER_MATCHER) }

      puts "#{projects.size} projects match naming conventions"

      projects.each do |project|
        puts "importing #{project.name}"
        project_name, p_number = project.name.split('-')

        project_attributes = {
          :basecamp_id => project.id,
          :name => project_name.strip,
          :p_number => p_number.strip
        }

        local_project = ::Project.find_or_initialize_by_basecamp_id(project.id, project_attributes)
        local_project.save

        #
        # Import TodoLists
        #
        puts "updating todo lists for #{}"
        todo_lists = Basecamp::TodoList.find(:all, :params => { :project_id => project.id, :filter => 'all' })
        puts "#{project.name} has #{todo_lists.size} todo lists"

        project_todos = todo_lists.each do |list|
          todo_list_attributes = {
            :basecamp_id => list.id,
            :name => list.name,
            :estimate => (list.description.present? ? list.description.match(ESTIMATE_MATCHER).to_s : nil),
            :project_id => local_project.id
          }
          local_list = ::TodoList.find_or_initialize_by_basecamp_id(list.id, todo_list_attributes)
          local_list.save

          #
          # Import TodoItems
          #
          todo_items = Basecamp::TodoItem.find(:all, :params => { :todo_list_id => list.id, :filter => 'all' })
          todo_items.each do |item|
            item_attributes = {
              :basecamp_id => item.id,
              :name => item.content,
              :todo_list_id => local_list.id
            }
            ::TodoItem.find_or_initialize_by_basecamp_id(list.id, item_attributes).save
          end
        end


      end
    end

  end
end
