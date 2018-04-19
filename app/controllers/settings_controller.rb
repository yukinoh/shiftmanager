class SettingsController < ApplicationController
  def index
    @members = Member.all.order(:id)
    @events = Event.all.order(:id)
    @settings = Setting.first
    @wday_list = [@settings.sun, @settings.mon, @settings.tue, @settings.wed, @settings.thu, @settings.fri, @settings.sat]
    @youbi = ['日', '月', '火', '水', '木', '金', '土',]
    
  end
  
  def update
    s = Setting.first
    s.update(setting_params)
    redirect_to settings_index_path
  end
  
  private
  
  def setting_params
    params.require(:setting).permit(:id, :mon, :tue, :wed, :thu, :fri, :sat, :sun, :hol, :gcal)
  end
  
end
