Rails.configuration.lob = {
  :api_key => ENV['STRIPE_SK']
}

Lob.api_key = Rails.configuration.stripe[:api_key]