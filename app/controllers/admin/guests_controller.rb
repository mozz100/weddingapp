class Admin::GuestsController < ApplicationController

  before_filter :check_logged_in

  layout "bootstrap"

  def index
    @guests = Guest.order('UPPER(lname)')
    @custom_questions = Wedding::Application.config.custom_questions
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update_attributes(params[:guest])
      redirect_to :action => :index
    else
      flash.now[:error] = I18n.t("admin.error")
      render :action => :edit
    end
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    flash[:success] = I18n.t('admin.deleted')
    redirect_to :action => :index
  end

  def create
    begin
      names = params[:names_list].split("\n")
      @new_guests = []
      names.each do |line|
        unless line.strip.blank?
          fname, lname = Guest.name_from_line(line)
          new_guest = Guest.new :fname => fname, :lname => lname
          if new_guest.valid?
            @new_guests << new_guest 
          else
            raise I18n.t("admin.add_guests_fail")
          end
        end
      end
      @new_guests.each{|g| g.save}
      flash[:success] = I18n.t("admin.added_guests", :n => @new_guests.length)
      session.delete(:names_list)
    rescue
      flash[:error] = $!.to_s
      session[:names_list] = params[:names_list]
    end

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
