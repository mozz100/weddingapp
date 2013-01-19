module Wedding
  class Application < Rails::Application
    config.before_initialize do
      config.wedding_name="Edit config/initializers/custom.rb!"
    end
  end
end
