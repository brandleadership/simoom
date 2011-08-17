module Basecamp
  class Importer

    #
    # Projects must include the P-Number, so that developers can log their
    # work hours on them. This means They need to be named according to the
    # predefined pattern: <Project Name> - P<P-Number>
    #
    # Projects not matching this naming pattern will be discarded
    #
    PROJECT_MATCHER = / \- P\d+$/

    #
    # Sync Local DB with Basecamp
    #
    def perform
      projects = Basecamp::Project.find(:all)
      projects.delete_if { |p| !!(p.name =~ PROJECT_MATCHER) }

      projects.each do |project|
        # find or initialize project
        # Project.find_or_initialize_by_basecamp_id()
        #
        # get todolists of project
        # exclude todolists that have [exclude] in their name
        # find or initialize todolists with todo items
      end
    end

  end
end
