require_relative '../src/profiles_scraper.rb'

PROFILES_URL = "https://www.upwork.com/o/profiles/browse/?nbs=1&q=ruby"

ENV['APP_ENV'] ||= 'Development'

result = ProfilesScraper.process
