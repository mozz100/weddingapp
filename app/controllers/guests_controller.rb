class GuestsController < ApplicationController
  before_filter :find_guest
  layout "bootstrap"

  def search
    session[:rsvp_start] = request.referer
    session.delete(:missing_data)
    redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
  end

  def show
    if @guest.status != 0 and not @guest.status.nil? and not session[:missing_data]
      flash.now[:notice] = I18n.t "rsvp.already_sent_html"
    end
  end

  def update
    redirect_dest = session[:rsvp_start]
    @guest.update_attributes(params[:guest])

    @guest.stored_data = params[:data] || {}
    @guest.save

    # all questions must be answered if status > 0
    session[:missing_data] = []
    if @guest.status > 0
      for q in @custom_questions
        if @guest.data[q[:key]].nil? || @guest.data[q[:key]].empty?
          session[:missing_data] << q[:key]
        end
      end
    end

    if @guest.status == 0
      flash[:error] =   I18n.t("guests.rsvp_error")
      redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
      return
    end

    if session[:missing_data].length > 0
      flash[:error] =   I18n.t("guests.missing_data_html")
      redirect_to :action => :show, :rsvp_code => @guest.rsvp_code
      return
    end

    if @guest.status > 0
      reset_session_vars
      flash[:success] =  I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.see_you_there"))
      flash[:success] += "<br/>" + I18n.t("guests.anyone_else")
      redirect_to redirect_dest || "/"
    elsif @guest.status < 0
      reset_session_vars
      flash[:success] = I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.sorry_not_coming"))
      redirect_to redirect_dest || "/"
    else
    end
  end

  protected

  def reset_session_vars
    session.delete(:wrong_code)
    session.delete(:missing_data)
    session.delete(:rsvp_start)
  end

  def find_guest
    session.delete(:wrong_code)
    @guest = Guest.find_by_rsvp_code(params[:rsvp_code].upcase)
    if @guest.nil?
      flash[:error] = I18n.t "guests.fail_match_rsvp_code"
      session[:wrong_code] = params[:rsvp_code]
      redirect_to :back
    end
    @custom_questions = Wedding::Application.config.custom_questions
  end
end
