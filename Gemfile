source "https://rubygems.org"

# Queueing for checks and reports
gem 'resque'

# Scheduling library to run checks every X
gem 'clockwork'

# To run the app with 'foreman start' (and export initscripts)
gem 'foreman'

# To provide rake tasks for resque workers
gem 'rake'

group :test do
  # For the test suite
  gem 'rspec'
  gem 'timecop'
  gem 'webmock'
end

group :development do
  gem 'pry'
  gem 'binding_of_caller'
end
