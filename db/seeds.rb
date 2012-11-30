# Import the intial cats
(1..(AWS::S3::Bucket.find(THERESA_SHULTZ_BUCKET).objects.count - 2)).collect { |num| 
  Cat.build!(url: "http://s3.amazonaws.com/theresashultz/cats/#{num}.gif")
}