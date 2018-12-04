# Executor class for lambdas
module ProfilesScraper
  class Executor
    def initialize(options={})
      @name = options[:name]
      @instruction = options[:instruction]
    end

    def call
      sleep(rand(4))
      log(@name)
      @instruction.call
    end

    private
    
    def get_elements(css_key)
      driver.find_elements(:css, css_dictionary(css_key))
    end

    def driver
      ProfilesScraper.driver
    end

    def css_dictionary(key)
      CSS_MAPPING[key]
    end

    def log(description)
      puts description
    end
  end
end
