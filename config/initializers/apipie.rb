require 'apipie-rails'

Apipie.configure do |config|
  config.app_name                = "ApiFlashcards"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/docs"
  # where is your API defined?
  config.api_controllers_matcher = "#{ApiFlashcards::Engine.root}/app/controllers/**/*.rb"
  config.app_info["1.0"] = "
  API for Flashcards application.
"
end
