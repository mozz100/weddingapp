Refinery::PagesController.class_eval do
  
  before_filter :cheese, :only => [:show]

  protected

  def cheese
    if @page.slug == "rsvp"
      @rsvp_form = true #render_to_string :partial => "guests/rsvp_form"
    end
  end
end
