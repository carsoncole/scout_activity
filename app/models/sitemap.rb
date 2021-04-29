class Sitemap
  def last_root_page_update
    last_root_page_update = File.new('app/views/home/index.html.haml').ctime
    last_unit_created_at = Unit.order(created_at: :desc).first&.updated_at
    last_root_page_update = last_unit_created_at if last_unit_created_at && last_unit_created_at > last_root_page_update
    last_root_page_update.strftime('%FT%TZ')
  end

  def last_troop_fundraising_ideas_update
  end

  def example_troop_unit_activities
    Unit.example&.first&.activities&.troop
  end

  def ideas_for_troops_last_updated
    example_troop_unit_activities&.order(updated_at: :desc)&.first&.updated_at&.strftime('%FT%TZ') if example_troop_unit_activities
  end

  def ideas_for_troop_covid_safe_last_updated
    example_troop_unit_activities&.covid_safe&.order(updated_at: :desc)&.first&.updated_at&.strftime('%FT%TZ') if example_troop_unit_activities
  end

  def ideas_for_fundraising_last_updated
    Unit.example&.first&.activities&.fundraising&.order(updated_at: :desc)&.first&.updated_at&.strftime('%FT%TZ')
  end

  def about_last_updated
    File.new('app/views/home/about.html.haml').ctime.strftime('%FT%TZ')
  end

  def resources_last_updated
    File.new('app/views/home/resources.html.haml').ctime.strftime('%FT%TZ')
  end

  def faqs_last_updated
    File.new('app/views/home/faqs.html.haml').ctime.strftime('%FT%TZ')
  end

  def units
    Unit.all
  end

  def activities
    Activity.votable
  end
end
