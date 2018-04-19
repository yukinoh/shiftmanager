class EventsController < ApplicationController
  
  def create
    
    @events = Event.new(event_params)
    @events.save
  
    if @events.save
      redirect_to settings_index_path
    else
      #要エラー処理
      redirect_to settings_index_path
    end
    
  end
  
  def update
    e = Event.find(params[:id])
    e.update(event_params)
    redirect_to settings_index_path
  end
  
  def activate
    e = Event.find(params[:id])
    e.flg = false
    e.save
    
    redirect_to settings_index_path
  end
  
  def deactivate
    e = Event.find(params[:id])
    e.flg = false
    e.save
    
    redirect_to settings_index_path
  end

  
  private
  
  def event_params
    params.require(:event).permit(:id, :name, :starts_at, :ends_at, :flg, :mon, :tue, :wed, :thu, :fri, :sat, :sun, :hol)
  end
end
