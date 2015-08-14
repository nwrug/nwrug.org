
Date::DATE_FORMATS[:human_short] = lambda { |d| d.strftime("%A #{d.day.ordinalize} %B") }

Time::DATE_FORMATS[:human_short] = lambda { |d| d.strftime("%A #{d.day.ordinalize} %B") }
Time::DATE_FORMATS[:human_long] = lambda { |t| t.strftime("%A #{t.day.ordinalize} %B, %l:%M%P") }
