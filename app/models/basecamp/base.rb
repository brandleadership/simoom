module Basecamp
  class Base < ActiveResource::Base
    self.site = Configuration.basecamp_url
    self.user = Configuration.basecamp_token
    self.password = 'password'

    # For some reason, json is broken
    self.format = :xml
  end
end
