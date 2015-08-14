
Date::DATE_FORMATS[:human_short] = lambda { |d| d.strftime("%A #{d.day.ordinalize} %B") }
