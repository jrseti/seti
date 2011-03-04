module ApplicationHelper
  def time_since(date)
    date_string = date.getlocal.strftime(date_format_string)
    now = DateTime.now
    seconds_ago = now.utc.to_i - date.utc.to_i
    if seconds_ago > 90
      minutes_ago = seconds_ago / 60
      if minutes_ago > 90
        hours_ago = minutes_ago / 60
        if hours_ago > 36
          days_ago = hours_ago / 24
          ago_string = days_ago.to_s + " days"
        else 
          ago_string = hours_ago.to_s + " hours"
        end
      else
        ago_string = minutes_ago.to_s + " minutes"
      end
    else
      ago_string = seconds_ago.to_s + " seconds"
    end
      
    return date_string + " (" + ago_string + " ago)"
  end
  
  def date_format_string
    return "%Y-%m-%d %a %I:%M:%S %p"
  end
end
