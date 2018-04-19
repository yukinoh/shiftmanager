class CalendarController < ApplicationController
  #before_action :set_calendar, only: [:index]

    
  def index
    @shifts = Shift.where(member_id: !nil)
    @members = Member.where(flg: true)
    @events = Event.where(flg: true)
    @settings = Setting.first
    @wday_list = [@settings.sun, @settings.mon, @settings.tue, @settings.wed, @settings.thu, @settings.fri, @settings.sat]
    
    @i = 0 if @i == nil
    @i = @i + params[:i].to_i
    @calendar_starts_from = Date.today + (@i*7).day
    
  end
  
end
