module Wedding
  class Application < Rails::Application
    config.before_initialize do
      config.wedding_name="Edit config/initializers/custom.rb!"

      config.home_page =       {:title => "Home", :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>"}
      config.rsvp_page =       {:title => "RSVP", :slug => "rsvp", :body => "<p>Enter your RSVP code below to let us know if you can come.</p>"}
      config.not_found_page  = {:title => "Page not found", :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>"}

    end
  end
end
