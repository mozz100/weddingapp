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

  home_page = Refinery::Page.create!({:title => I18n.t('home.title'),
              :layout_template => "bootstrap",
              :deletable => false,
              :link_url => "/",
              :show_in_menu => false,
              :menu_match => "^/$"})
  home_page.parts.create({
                :title => "Body",
                :body => "<p>" + I18n.t('home.body') + "</p>",
                :position => 0
              })

  rsvp_page = Refinery::Page.create!({:title => I18n.t('rsvp.title'),
              :layout_template => "bootstrap",
              :deletable => false,
              :slug => :rsvp,
              :show_in_menu => true,
              :menu_match => "^/rsvp$"})
  rsvp_page.parts.create({
                :title => "Body",
                :body => "<p>" + I18n.t('rsvp.body') + "</p>",
                :position => 0
              })

  dir_page = Refinery::Page.create!({:title => I18n.t('directions.title'),
              :layout_template => "bootstrap",
              :deletable => true,
              :slug => :directions,
              :show_in_menu => true,
              :menu_match => "^/directions$"})
  dir_page.parts.create({
                :title => "Body",
                :body => "<p>" + I18n.t('directions.body') + "</p>",
                :position => 0
              })

  page_not_found_page = home_page.children.create(:title => I18n.t('not_found.title'),
              :layout_template => "bootstrap",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => "<p>" + I18n.t('not_found.body') + "</p><p><a href='/'>" + I18n.t('not_found.return_home') +"</a></p>",
                :position => 0
              })

end

