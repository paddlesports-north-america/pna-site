module ApplicationHelper

  def s3_url(f)
    "#{ENV['AMAZON_S3_URL']}#{f}"
  end

end
