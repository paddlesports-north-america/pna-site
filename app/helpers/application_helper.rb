module ApplicationHelper

  def s3_url(f)
    "#{ENV['AMAZON_S3_URL']}#{f}"
  end

  def bcu_url(resource)
    "https://f58619eed67ecf47f9c5-69635130c45beb2524d5bafa9c042fe0.ssl.cf3.rackcdn.com/#{resource}"
  end

  def course_dates( course )
    dates = course.start_date.day
    unless course.end_date.nil? || course.end_date == course.start_date
      dates = "#{dates} - #{course.end_date.day}"
    end
    dates
  end
end
