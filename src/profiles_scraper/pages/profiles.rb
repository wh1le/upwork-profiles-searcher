require 'selenium-webdriver'
require 'watir'

require_relative '../executor'

# Profiles page scraper
module ProfilesScraper
  module Pages
    class Profiles
      attr_reader :profles

      def initialize(options={})
        @profiles = load_profiles
      end

      def scan_profiles
        # clear_cookies

        # instructions
        instructions = {
          # open_google:      -> { driver.navigate.to('https://www.google.com') },
          open_upwork:      -> { driver.navigate.to('https://www.upwork.com') },
          # click_toogle:     -> { get_elements(:dropdown).last.click },
          # pick_freelancers: -> { get_elements(:freelancer_option).last.click },
          # type_ruby:        -> { get_elements(:search_input).last.send_keys('Ruby') },
          # submit_form:      -> { get_elements(:search_input).last.submit },
          # expand_filter:    -> { get_elements(:filter_btn).last.click },
          # select_rate:      -> { get_elements(:rate_radio_option)[1].click },
        }

        # execute each instruction
        profiles = instructions.inject(nil) do |commutator, (key, instruction)|
          execute(key, instruction)
        end
      end

      private

      def execute(key, instruction)
        Executor.new(
          name:        key,
          instruction: instruction
        ).call
      end

      # not used code for profiles page which scrape profiles links
      def load_profiles
        profiles = driver.find_elements(:css, css_dictionary(:profile))
      end

      # def clear_cookies
      #   driver.manage.delete_all_cookies
      # end

      # abstration for clean code
      def driver
        ProfilesScraper.driver
      end

      # abstartion for clean code
      def get_elements(css_key)
        driver.find_elements(:css, css_dictionary(css_key))
      end

      # abstration for clean code
      def css_dictionary(css_key)
        CSS_MAPPING[css_key]
      end
    end
  end
end
