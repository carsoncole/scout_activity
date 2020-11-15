module ActivitiesHelper
  def activity_page_title(activity)
    result = activity.name + ' - ScoutActivity'
    unless activity.unit.is_example?
      result = activity.unit.name + ' - ' + result
    end
    result
  end
end
