module EventHelper

  def next_event_date
    if third_thursday_of_month.past?
      third_thursday_of_month(Date.today + 1.month)
    else
      third_thursday_of_month
    end
  end

  def third_thursday_of_month(base_date=nil)
    base_date ||= Date.today
    year  = base_date.year
    month = base_date.month
    day   = (4 - Date.new(year, month, 1).wday) % 7 + (2*7) + 1

    Date.new(year, month, day)
  end
end
