class Admin::GuestsController < ApplicationController

  before_filter :check_logged_in

  layout "bootstrap"

  def index
    @guests = Guest.order('lname')
    @custom_questions = Wedding::Application.config.custom_questions
  end

  def update
    @guest = Guest.find(params[:id])
    @guest.update_attributes(params[:guest])
    redirect_to :action => :index
  end

  protected

  def check_logged_in
    unless refinery_user?
        session[:refinery_user_return_to] = "/admin/guests"
        redirect_to refinery.new_refinery_user_session_path(:only_path=>true)
    end
  end
end
