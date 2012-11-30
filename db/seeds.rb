# Import the intial cats
@s3_cats = (1..(AWS::S3::Bucket.find(THERESA_SHULTZ_BUCKET).objects.count - 2)).collect { |num| 
  "http://s3.amazonaws.com/theresashultz/cats/#{num}.gif"
}

@s3_cats.each do |cat_url|
  
end