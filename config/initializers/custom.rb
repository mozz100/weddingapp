module Wedding
  class Application < Rails::Application
    config.after_initialize do
      # add rails root to search path.
      # This means addition of wedding.less followed by rake assets:precompile
      # enables customization of stylesheets
      config.less.paths << Rails.root.to_s
    end

    config.before_initialize do

      config.wedding_name="Edit config/initializers/custom.rb!"
      config.custom_questions = [
        {
          :key => "food_starter",
          :question_text => "Please tell us your food choices.",
          :options => [
            {:key => "crab",    :desc => "Portland crab cakes with rocket and chilli dressing"},
            {:key => "falafel", :desc => "Falafel with rocket and chilli dressing"}
          ],
          :type => "radio",
          :between => "<div class='menu_between'>or</div>",
          :before => "<div class='menu_before'>Starter</div>"
        },
        {
          :key => "food_main",
          :question_text => "",
          :options => [
            {:key => "beef", :desc  => "Fillet of Dorset beef with fresh herbs, garlic and olive oil dressing, baby roast potatoes with shallots and fine beans"},
            {:key => "veg",  :desc  => "Char-grilled summer vegetable stack with herb dressing"}
          ],
          :type => "radio",
          :between => "<div class='menu_between'>or</div>",
          :before => "<div class='menu_before'>Main course</div>"
        },
      ]
      config.map_pins = [
        {:name => "Reception at Brympton House",   :location => [50.936254, -2.684819], :icon => "http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png"},
        {:name => "Ceremony",                      :location => [50.836254, -2.584819], :icon => "http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png"}
      ]
      config.map_centre = nil  # compute automatically
      config.map_zoom_level = 14
      config.map_stylers = [{ "hue" => "#000025"}, {"saturation" => -50 }]
      config.secret_phrase = "CHANGEME"
      config.secret_key = Digest::SHA1.hexdigest(config.secret_phrase)
    end
  end
end
