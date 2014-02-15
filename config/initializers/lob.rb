Rails.configuration.lob = {
  :api_key => ENV['LOB_API_KEY']
}

Lob.api_key = Rails.configuration.lob[:api_key]