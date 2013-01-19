module Wedding
  class Application < Rails::Application
    config.before_initialize do
      config.wedding_name="Edit config/initializers/custom.rb!"
      config.food_choices = {
        "chicken" => "Chicken Cordon Bleu",
        "beef"    => "Beef Wellington",
        "veggie"  => "Nut Roast"
      }
    end
  end
end
