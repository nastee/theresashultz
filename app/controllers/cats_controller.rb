class CatsController < ApplicationController
  respond_to :html, :xml, :json, :js
  
  def index
    @images = (1..(AWS::S3::Bucket.find(THERESA_SHULTZ_BUCKET).objects.count - 2)).collect { |num| "http://s3.amazonaws.com/theresashultz/cats/#{num}.gif"}.reverse
    respond_with(@images)
  end
end
