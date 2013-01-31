Refinery::PagesController.class_eval do
  
  before_filter :wedding_inserts, :only => [:show]

  protected

  def wedding_inserts
    config = Rails.application.config
    if @page.slug == "rsvp"
      @rsvp_form = true #render_to_string :partial => "guests/rsvp_form"
    elsif @page.slug == "directions"
      @map = true
      @zoom_level =    config.map_zoom_level
      @map_stylers =   config.map_stylers
      @map_pins =      config.map_pins
      if config.map_centre
        @map_centre = config.map_centre
      else
        # naively compute the arithmetic mean of lat and long for all pins
        @map_centre = [
          config.map_pins.map{|p| p[:location][0]}.reduce(:+)/config.map_pins.length,
          config.map_pins.map{|p| p[:location][1]}.reduce(:+)/config.map_pins.length,
        ]
      end
    end
  end
end
