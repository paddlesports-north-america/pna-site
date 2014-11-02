module ApplicationHelper

  def s3_url(f)
    "#{ENV['AMAZON_S3_URL']}#{f}"
  end

  def course_dates( course )
    dates = course.start_date.day
    unless course.end_date.nil? || course.end_date == course.start_date
      dates = "#{dates} - #{course.end_date.day}"
    end
    dates
  end
end
