# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed
if Refinery::Page.where(:menu_match => "^/$").empty?
  home_page = Refinery::Page.create!({:title => "Home",
              :layout_template => "bootstrap",
              :deletable => false,
              :link_url => "/",
              :show_in_menu => false,
              :menu_match => "^/$"})
  home_page.parts.create({
                :title => "Body",
                :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>",
                :position => 0
              })
  home_page_position = -1

  rsvp_page = Refinery::Page.create!({:title => "RSVP",
              :layout_template => "bootstrap",
              :deletable => false,
              :slug => "rsvp",
              :show_in_menu => true,
              :menu_match => "^/rsvp$"})
  rsvp_page.parts.create({
                :title => "Body",
                :body => "<p>Enter your RSVP code below to let us know if you can come.</p>",
                :position => 0
              })
  rsvp_page_position = 0

  page_not_found_page = home_page.children.create(:title => "Page not found",
              :layout_template => "bootstrap",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>",
                :position => 0
              })

end

