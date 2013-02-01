module Wedding
  class Application < Rails::Application
    config.after_initialize do
      # add rails root to search path.
      # This means addition of wedding.less in Rails root followed by
      # rake assets:precompile enables customization of stylesheets
      config.less.paths << Rails.root.to_s
    end

    config.before_initialize do
      begin
        load File.join(Rails.root, "customizations.rb")
      rescue LoadError
        # no customizations.rb found; use default values
        config.wedding_name="Create customizations.rb"
        config.custom_questions = [
          {
            :key => "food_starter",
            :question_text => "Please tell us your food choices.",
            :options => [
              {:key => "caviar",    :desc => "Caviar"},
              {:key => "gazpacho",  :desc => "Gazpacho"}
            ],
            :type => "radio",
            :between => "<div class='menu_between'>or</div>",
            :before => "<div class='menu_before'>Starter</div>"
          },
          {
            :key => "food_main",
            :question_text => "",
            :options => [
              {:key => "spam and eggs", :desc  => "Spam and Eggs"},
              {:key => "swan",          :desc  => "Roast swan"},
              {:key => "veg",           :desc  => "Nut roast"}
            ],
            :type => "radio",
            :between => "<div class='menu_between'>or</div>",
            :before => "<div class='menu_before'>Main course</div>"
          },
        ]
        config.map_pins = [
          {:name => "Buckingham Palace",   :location => [51.50142, -0.14158], :icon => "http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png"},
          {:name => "Westminster Abbey",   :location => [51.49941, -0.12729], :icon => "http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png"}
        ]
        config.map_centre = nil  # compute automatically
        config.map_zoom_level = 14
        config.map_stylers = [{ "hue" => "#000025"}, {"saturation" => -50 }]
        config.secret_phrase = "CHANGEME"
        config.secret_key = Digest::SHA1.hexdigest(config.secret_phrase)
      end
    end
  end
end
