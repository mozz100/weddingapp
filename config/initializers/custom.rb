module Wedding
  class Application < Rails::Application
    config.before_initialize do
      config.wedding_name="Edit config/initializers/custom.rb!"
      config.custom_questions = [
        {
          :key => "food_starter",
          :question_text => "Please tell us your food choices.",
          :options => {
            {:key => "crab",    :desc => "Portland crab cakes with rocket and chilli dressing"},
            {:key => "falafel", :desc => "Falafel with rocket and chilli dressing"}
          },
          :type => "radio",
          :between => "<div class='menu_between'>or</div>",
          :before => "<div class='menu_before'>Starter</div>"
        },
        {
          :key => "food_main",
          :question_text => "",
          :options => {
            {:key => "beef", :desc  => "Fillet of Dorset beef with fresh herbs, garlic and olive oil dressing, baby roast potatoes with shallots and fine beans"},
            {:key => "veg",  :desc  => "Char-grilled summer vegetable stack with herb dressing"}
          },
          :type => "radio",
          :between => "<div class='menu_between'>or</div>",
          :before => "<div class='menu_before'>Main course</div>"
        },
      ]
    end
  end
end
