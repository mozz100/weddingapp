Refinery::PagesController.class_eval do
  
  before_filter :wedding_inserts, :only => [:show]

  protected

  def wedding_inserts
    if @page.slug == "rsvp"
      @rsvp_form = true #render_to_string :partial => "guests/rsvp_form"
    elsif @page.slug == "directions"
      @map = true
      @location_name = Rails.application.config.wedding_location_name
      @location =      Rails.application.config.wedding_location
      @zoom_level =    Rails.application.config.map_zoom_level
      @map_pin_icon =  Rails.application.config.map_pin_icon
      @map_stylers =   Rails.application.config.map_stylers
    end
  end
end
