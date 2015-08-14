
Date::DATE_FORMATS[:short_date] = lambda { |d| d.strftime("%A #{d.day.ordinalize} %B") }
Time::DATE_FORMATS[:short_date] = Date::DATE_FORMATS[:short_date]
