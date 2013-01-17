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
  config = Rails.application.config

  home_page = Refinery::Page.create!({:title => config.home_page[:title],
              :layout_template => "bootstrap",
              :deletable => false,
              :link_url => "/",
              :show_in_menu => false,
              :menu_match => "^/$"})
  home_page.parts.create({
                :title => "Body",
                :body => config.home_page[:body],
                :position => 0
              })
  home_page_position = -1

  rsvp_page = Refinery::Page.create!({:title => config.rsvp_page[:title],
              :layout_template => "bootstrap",
              :deletable => false,
              :slug => config.rsvp_page[:slug],
              :show_in_menu => true,
              :menu_match => "^/" + config.rsvp_page[:slug] + "$"})
  rsvp_page.parts.create({
                :title => "Body",
                :body => config.rsvp_page[:body],
                :position => 0
              })
  rsvp_page_position = 0

  page_not_found_page = home_page.children.create(:title => config.not_found_page[:title],
              :layout_template => "bootstrap",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => config.not_found_page[:body],
                :position => 0
              })

end

