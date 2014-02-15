# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
@lob = Lob(api_key: ENV['LOB_API_KEY'])
Airpic::Application.initialize!
