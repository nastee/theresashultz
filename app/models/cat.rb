require 'open-uri'
require 'net/http'
require 'aws/s3'

class Cat < ActiveRecord::Base
  attr_accessible :file_name, :original_url, :url
  
  def http
    url
  end
  
  def self.build! options={}
    # Error check 
    return false if Cat.exists?(original_url: options[:url])
    return nil if options[:url].nil?
    return "class" if options[:url].class != String 
    return "invalid" if options[:url].downcase.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix)[0].nil?
    
    # Record the processing time
    start_time = Time.now
  
    # Notify the console we are creating a pin
    puts " ==> CREATING A CAT ------------------------------------------------------"
    puts " ==> URL: #{options[:url]}"

    # File extension
    extension   = options[:url].match(/([^\s]+(\.(?i)(jpg|jpeg|png|gif|bmp))$)/).try(:to_a).try(:last)
    file_name   = rand.to_s.gsub('0.', '')
    full_file   = file_name + ".#{extension}"
    local_file  = "#{Rails.root}/public/images/cats/#{full_file}"
  
    # Make the request to get the data
    result = open(options[:url]).read
    puts " ==> fetching the file..."

    # Analyze the image first so we know data about it   
    puts " ==> reading the file into temp..." 
    open(local_file, "wb") do |file|
      file.write(result)
    end

    # Store the object
    puts " ==> uploading #{full_file}..."
    data = AWS::S3::S3Object.store(
      "cats/#{full_file}",
      open(local_file),
      THERESA_SHULTZ_BUCKET,
      :access => :public_read
    )
    puts " ==> upload complete!"
    
    # Create the cat
    cat = Cat.new(original_url: options[:url], url: "http://s3.amazonaws.com/theresashultz/cats/#{full_file}", file_name: full_file)
    
    # Unlink the file
    File.unlink(local_file)
    
    # Computer the time taken
    finished = (Time.now - start_time) / 60.0
    puts " ==> completed in: #{finished} seconds"
    puts ""
    
    # Return result
    return cat.save ? true : false
  end  
end