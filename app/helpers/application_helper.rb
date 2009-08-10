# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def format_datetime(datetime)
    datetime.to_s(:short) if datetime
  end

end
