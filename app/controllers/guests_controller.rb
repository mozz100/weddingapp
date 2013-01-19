class GuestsController < ApplicationController
  before_filter :find_guest
  layout "bootstrap"

  def search
    session[:rsvp_start] = request.referer
    redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
  end

  def show
  end

  def update
    @guest.update_attributes(params[:guest])
    reset_session
    if @guest.status > 0
     flash[:success] = I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.see_you_there"))
     redirect_to session[:rsvp_start] || "/"
    elsif @guest.status < 0
     flash[:success] = I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.sorry_not_coming"))
     redirect_to session[:rsvp_start] || "/"
    else
     flash[:error] =   I18n.t("guests.rsvp_error")
     redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
    end
  end

  protected
  def find_guest
    session.delete(:wrong_code)
    @guest = Guest.find_by_rsvp_code(params[:rsvp_code].upcase)
    if @guest.nil?
      flash[:error] = I18n.t "guests.fail_match_rsvp_code"
      session[:wrong_code] = params[:rsvp_code]
      redirect_to :back
    end
  end
end
