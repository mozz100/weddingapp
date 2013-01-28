class Admin::GuestsController < ApplicationController

  before_filter :check_logged_in, :except => :export
  before_filter :load_lists, :only => [:index, :export]

  layout "bootstrap"

  def index
    # compile stats
    @coming     = @guests.where('status > 0')
    @not_coming = @guests.where('status < 0')
    @no_rsvp    = @guests.where(:status => [0,nil])

    @custom_questions.each do |q|
      q[:options].each do |opt|
        opt[:number_guests] = @coming.select{|guest| guest.data[q[:key]] == opt[:key]}.length
      end
    end
  end

  def export
    if not params[:key] == Wedding::Application.config.secret_key
      render :text => "Access denied", :status => 403
      return
    end
    respond_to do |format|
      format.tsv {
        headers['Content-Disposition'] = "attachment; filename=\"guests.xls\""
        @options = {:col_sep => "\t"}
        render :template => "admin/guests/export.xsv.erb"
      }
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"guests.csv\""
        @options = {:col_sep => ","}
        render :template => "admin/guests/export.xsv.erb"
      }
      format.text {
        @options = {:col_sep => "\t"}
        render :template => "admin/guests/export.xsv.erb"
      }

    end

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

  def load_lists
    @guests = Guest.order('UPPER(lname)')
    @custom_questions = Wedding::Application.config.custom_questions
  end

  def check_logged_in
    unless refinery_user?
        session[:refinery_user_return_to] = "/admin/guests"
        redirect_to refinery.new_refinery_user_session_path(:only_path=>true)
    end
  end
end
