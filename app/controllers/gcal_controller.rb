class GcalController < ApplicationController
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

APPLICATION_NAME = 'Shift Manager'

require 'fileutils'

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendar_index_path
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  # Shiftからidを受け取ってGoogle Calendarにイベントを作成する
  def new_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])
    client.expires_in = 2592000

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    begin
      @calendar_list = service.list_calendar_lists

      #begin
      #  rescue Google::Apis::AuthorizationError
      #  response = client.refresh!

      #  session[:authorization] = session[:authorization].merge(response)

      #  retry
      #end

      s = Shift.find(params[:id])
      e = Event.find(s.event_id)
      shifts = Shift.where(happens_on: s.happens_on, event_id: s.event_id)
      @name = '（'
      #@email = []
      @sp_flg = false
      shifts.each do |ss|
        if ss.member_id.present?
          m = Member.find(ss.member_id)
          @name << m.name
          @name << ', '
          #あとで考える
          #event.attendees.push({email: m.email}) if m.email.present?
        end
        @sp_flg = true if ss.sp_flg
      end

      if @sp_flg then
        start_time = DateTime.new(s.happens_on.year, s.happens_on.month, s.happens_on.day, get_hr(s.starts_at), get_min(s.starts_at), 0, "+0900")
        end_time = DateTime.new(s.happens_on.year, s.happens_on.month, s.happens_on.day, get_hr(s.ends_at), get_min(s.ends_at), 0, "+0900")
      else
        start_time = DateTime.new(s.happens_on.year, s.happens_on.month, s.happens_on.day, get_hr(e.starts_at), get_min(e.starts_at), 0, "+0900")
        end_time = DateTime.new(s.happens_on.year, s.happens_on.month, s.happens_on.day, get_hr(e.ends_at), get_min(e.ends_at), 0, "+0900")
      end

      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time),
        end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time),
        time_zone: "Asia/Tokyo",
      })

      event.summary = e.name + @name.slice!(0..@name.size-3) + '）'

      notes = Note.where(created_for: s.happens_on)
      d = ''
      notes.each do |n|
        d << n.content
        d << ' / '
      end
      event.description = d

      calendar_id = @calendar_list.items.first.id
      response = service.insert_event(calendar_id, event)

      # event idをshiftに保存
      cid = response.id
      shifts.each do |ss|
        ss.gcal_id = cid
        ss.save
      end

      calendar_page = (referer = request.env['HTTP_REFERER'].match(/index\?i=(\d+)/)) ? referer[1] : nil

      redirect_to calendar_index_path(i: calendar_page)
    rescue Google::Apis::AuthorizationError
      client = Signet::OAuth2::Client.new(client_options)
      redirect_to client.authorization_uri.to_s
    end
  end

  # shift idを受け取って内容を更新する
  def update_event
    @cid = get_cid(params[:id])

    if @cid != nil

      client = Signet::OAuth2::Client.new(client_options)
      client.update!(session[:authorization])

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      @calendar_list = service.list_calendar_lists

      calendar_id = @calendar_list.items.first.id

      event = service.get_event(calendar_id, @cid)
      event.attendees = []

      #新規作成時と同じながれ

      service.update_event(calendar_id, @cid, event)

      redirect_to calendar_index_path

    else
      #イベントが存在しない場合作成
      redirect_to gcal_new_event_path(params[:id])
    end

  end

  def cancel_event
    @cid = get_cid(params[:id])

    if @cid != nil

      client = Signet::OAuth2::Client.new(client_options)
      client.update!(session[:authorization])

      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client

      @calendar_list = service.list_calendar_lists

      calendar_id = @calendar_list.items.first.id
      service.delete_event(calendar_id, @cid)

    end

    redirect_to calendar_index_path

  end

  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

  def get_cid(sid)
    s = Shift.find[sid]
    shifts = Shift.where(happens_on: s.happens_on, event_id: s.event_id)
    shifts.each do |ss|
      return ss.gcal_id if ss.gcal_id.present?
    end
    return nil
  end

  def get_hr(itime)
    if itime.to_i > 960 then
      h = itime.to_s[0, 2]
    else
      h = itime.to_s[0, 1]
    end

    return h.to_i

  end

  def get_min(itime)
    if itime.to_i > 960 then
      m = itime.to_s[2, 2]
    else
      m = itime.to_s[1, 2]
    end

    return m.to_i

  end


end
