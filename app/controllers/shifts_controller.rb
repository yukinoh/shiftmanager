class ShiftsController < ApplicationController
  
  def new
    @shifts = Shift.new
  end
  
  def create
    @shifts = Shift.new(shift_params)
    @shifts.save
  
    if @shifts.save
      #カレンダーが戻っちゃうの
      #redirect_to calendar_index_path
      if Setting.first.gcal
        redirect_to gcal_new_event_path(id: @shifts.id)
      else
        redirect_to calendar_index_path
      end
    else
      #要エラー処理
      redirect_to calendar_index_path
    end
    
  end
  
  def delete
    s = Shift.find_by(id: params[:id])
    s.destroy
    #要エラー処理
    redirect_to calendar_index_path(i: @i)
  end
  
  def create_multiple_shifts
    t1 = Date.parse params[:start_date]["t"]
    t2 = Date.parse params[:end_date]["t"]
    while t1 <= t2 do
      if t1.wday == params[:y].to_i
        s = Shift.where(happens_on: t1, event_id: params[:event], member_id: params[:member])
        if s.empty?
          s = Shift.new(happens_on: t1, event_id: params[:event], member_id: params[:member])
          s.save
        else
          # already assigned
        end
      end
      t1 = t1 + 1.day
    end
    redirect_to settings_index_path
    #Gcalに一括登録
  end
  
  def set_time
    t1 = Date.parse params[:start_date]["t"]
    t2 = Date.parse params[:end_date]["t"]
    while t1 <= t2 do
      if t1.wday == params[:y].to_i
        # creating dummy shift to set time (nobody is assigned)
        s = Shift.new(happens_on: t1, event_id: params[:event], sp_flg: true, starts_at: convert_to_time(params[:s_hr].to_i,params[:s_min].to_i), ends_at: convert_to_time(params[:e_hr].to_i,params[:e_min].to_i))
        s.save
        
        n = Note.new(created_for: t1)
        tmp = Event.find(s.event_id).name + 'の時間：' + get_time(s.starts_at) + "〜" + get_time(s.ends_at)
        n.content = tmp
        n.save
      end
      t1 = t1 + 1.day
    end
    redirect_to settings_index_path
    #Gcalに一括登録
  end
  
  private
  
  def shift_params
    params.require(:shift).permit(:happens_on, :event_id, :member_id, :sp_flg, :starts_at, :ends_at)
  end
  
  def convert_to_time(hr,min)
    if hr == 0
      return min
    elsif min < 10
      return (hr.to_s + 0.to_s + min.to_s).to_i
    else
      return (hr.to_s + min.to_s).to_i
    end
  end
  
  def get_time(t)
    if t < 60
      time_in_s = 0.to_s + ':' + t.to_s
    elsif t < 960
      tmp = t/100
      time_in_s = tmp.to_s + ':' + (t-(tmp*100)).to_s
    else
      tmp = t/10
      time_in_s = tmp.to_s + ':' + (t-(tmp*10)).to_s
    end
    
  end
  
end
