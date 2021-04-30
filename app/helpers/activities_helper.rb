module ActivitiesHelper
  def activity_page_title(activity)
    result = "#{activity.name} - Scout Activity"
    result = "#{activity.unit.name} - #{result}" unless activity.unit.is_example?
    result
  end
end
