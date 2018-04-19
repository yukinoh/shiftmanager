Setting.create(:mon => true, :tue => true, :wed => true, :thu => true, :fri => true, :sat => false, :sun => false, :hol => false, :gcal => true)
Member.create(:name => 'AA', :flg => true, :gcal_flg => false)
Event.create(name: '1Event', flg: true, mon: true, tue: true, wed: true, thu: true, fri:true, sat: true, sun: true, hol: true, starts_at: 800, ends_at: 1000);
Event.create(:name => '2Event', :flg => true, :mon => true, :tue => true, :wed => true, :thu => true, :fri => true, :sat => false, :sun => false, :hol => false, :starts_at => 800, :ends_at => 900)
Event.create(:name => '3Event', :flg => true, :mon => true, :tue => true, :wed => false, :thu => true, :fri => true, :sat => false, :sun => false, :hol => false, :starts_at => 1000, :ends_at => 1400)
Event.create(:name => '4Event', :flg => true, :mon => true, :tue => false, :wed => true, :thu => true, :fri => true, :sat => true, :sun => true, :hol => true, :starts_at => 900, :ends_at => 1800)
Event.create(name: '5Event', flg: false, mon: false, tue: false, wed: true, thu: true, fri:true, sat: true, sun: true, hol: true, starts_at: 800, ends_at: 1000);

Member.create(:name => 'A', :flg => true, :gcal_flg => false)
Member.create(:name => 'B', :flg => true, :gcal_flg => false)
Member.create(:name => 'C', :flg => true, :gcal_flg => false)
Member.create(:name => 'D', :flg => true, :gcal_flg => true, :email => "yukino.jodai@gmail.com")
Member.create(:name => 'E', :flg => false, :gcal_flg => false)

t = Date.today + 3.day
Shift.create(happens_on: t, event_id: 1, member_id: 1, sp_flg: false)
Shift.create(happens_on: t, event_id: 2, member_id: 2, sp_flg: true, starts_at: 1000, ends_at: 1200)
