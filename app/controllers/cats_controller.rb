class CatsController < ApplicationController
  def index
    bucket  = AWS::S3::Bucket.find(THERESA_SHULTZ_BUCKET)
    @images = bucket.objects.collect { |object| AWS::S3::S3Object.url_for(object.key, THERESA_SHULTZ_BUCKET, authenticated: false) }.reject { |x| x.include?('background')}
  end
end
