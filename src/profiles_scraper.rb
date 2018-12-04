require_relative 'profiles_scraper/pages/profiles'

CSS_MAPPING = {
  dropdown: '.dropdown-toggle',
  freelancer_option: '[data-label="Freelancers"]',
  search_input: 'input[placeholder="Find Freelancers"]',
  filter_btn:  '.filters-button',
  rate_radio_option: '[data-label="Hourly Rate"] .radio',
  profile: '[data-ng-include="templateUrl"] h4 a'
}

module ProfilesScraper
  # scrape profles
  def self.process(options={})
    profiles = scrape_profiles
  end

  # We should have one global instasnce for the app
  def self.driver
    @@driver ||= Proc.new {
      # More options: --disable-gpu --headless
      options = Selenium::WebDriver::Chrome::Options.new(
        args: %w[ 
          incognito 
          disable-extensions
          profile-directory=Default
          disable-plugins-discovery
          start-maximized
        ]
      )

      profile = Selenium::WebDriver::Chrome::Profile.new
      profile['general.useragent.override'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
      profile['modifyheaders.headers.dnt'] = 1

      Selenium::WebDriver.for(:chrome, 
        options: options,
        profile: profile
      )
    }.call
  end

  private

  def self.scrape_profiles
    Pages::Profiles.new.scan_profiles
  end
end
