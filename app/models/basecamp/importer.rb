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
    def self.perform(log_level = :info)
      @logger = Basecamp::ImportLogger.new(log_level)
      @logger.log :info, 'starting synchronization with basecamp'

      projects = Basecamp::Project.find(:all)
      @logger.log :debug, "Found #{projects.size} projects"

      projects = projects.reject { |p| !(p.name =~ P_NUMBER_MATCHER) }
      @logger.log :debug, "#{projects.size} projects match naming conventions"

      projects.each do |project|
        @logger.log :debug, "importing #{project.name}"
        project_name, p_number = project.name.split('-')

        project_attributes = {
          :basecamp_id => project.id,
          :name => project_name.strip,
          :p_number => p_number.strip
        }

        local_project = ::Project.find_or_initialize_by_basecamp_id(project.id, project_attributes)
        local_project.sync(log_level)
        local_project.save
      end
      @logger.log :info, 'finished synchronization with basecamp'
    end
  end
end
