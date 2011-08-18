#
# Central Configuration class for static application settings that can
# be configured on an per environment basis.
#
# See config/application.yml
#
class Configuration

  @@settings ||= YAML::load_file("#{ Rails.root }/config/application.yml")[Rails.env]

  #
  # Each setting will be catched here for the first time
  #
  def self.method_missing(method, *args)
    @@settings.include?(method.to_s) ? create_configuration_accessor(method) : ''
  end

  private

  #
  # Dynamically create a static method to return the setting
  #
  def self.create_configuration_accessor(key)
    result = @@settings[key.to_s]

    self.class.instance_eval do
      define_method key do
        result
      end
    end

    result
  end

end
