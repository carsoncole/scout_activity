module ApplicationHelper
  def nice_date(date)
    date.strftime('%B %d, %Y') unless date.nil?
  end

  def nice_compact_date(date)
    date.strftime('%d-%b-%y') unless date.nil?
  end

  def nice_brief_date(date)
    date.strftime('%d-%b') unless date.nil?
  end

  def nice_datetime(date)
    date.strftime('%B %d, %Y %I:%M:%S %p %Z') unless date.nil?
  end

  def nice_datetime_concise(date)
    date.strftime('%b %d, %y %I:%M:%S %p %Z') unless date.nil?
  end

  def local_time
    in_time_zone("Pacific Time (US & Canada)")
  end

  def visit_event(troop)
    troop.update( visit_)
  end
end
