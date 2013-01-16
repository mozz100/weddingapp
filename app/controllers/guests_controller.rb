class GuestsController < ApplicationController
  before_filter :find_guest
  def search
    session[:rsvp_start] = request.referer
    redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
  end

  def show
  end

  def update
     @guest.update_attributes(params[:guest])
     reset_session
     flash[:success] = "Success"
     redirect_to session[:rsvp_start] || "/"
  end

  protected
  def find_guest
    session.delete(:wrong_code)
    @guest = Guest.find_by_rsvp_code(params[:rsvp_code])
    if @guest.nil?
      flash[:error] = "Fail to match"
      session[:wrong_code] = params[:rsvp_code]
      redirect_to :back
    end
  end
end
