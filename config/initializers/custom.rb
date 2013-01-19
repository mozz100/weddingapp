module Wedding
  class Application < Rails::Application
    config.before_initialize do
      config.wedding_name="Edit config/initializers/custom.rb!"
      config.custom_questions = [
        {
          :key => "food_starter",
          :question_text => "Which starter option would you like to go for?",
          :options => {
            "soup" => "Vegetable Soup",
            "melon"  => "Melon"
          },
          :type => "radio"
        },
        {
          :key => "food_main",
          :question_text => "And for main course?",
          :options => {
            "chicken" => "Chicken Cordon Bleu",
            "beef"    => "Beef Wellington",
            "veggie"  => "Nut Roast"
          },
          :type => "radio"
        },
      ]
    end
  end
end
