class Cat < ActiveRecord::Base
  def self.build! options={}
    # Error check 
    return "nil" if options[:url].nil?
    return "class" if options[:url].class != String 
    return "invalid" if options[:url].downcase.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix)[0].nil?
    
    # Notify the console we are creating a pin
    puts "CREATING A PIN ----------------------------------------------------------------------------------------"
    puts "URL: #{options[:url]}"

    # File extension
    extension   = options[:url].match(/([^\s]+(\.(?i)(jpg|png|gif|bmp))$)/).try(:to_a).try(:last) # .gsub('.', '')
    file_name   = rand.to_s.gsub('0.', '')
    full_file   = file_name + ".#{extension}"

    # Make the request to get the data
    result = Net::HTTP.get(URI(options[:url]))

    # Analyze the image first so we know data about it    
    open("#{Rails.root}/public/images/cats/#{full_file}", "wb") do |file|
      file.write(result)
    end
    
  end
end