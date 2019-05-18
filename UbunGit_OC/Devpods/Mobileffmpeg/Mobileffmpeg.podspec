

Pod::Spec.new do |s|

   s.name         = "Mobileffmpeg"
  s.version      = "0.1.0"
  s.summary      = "Mobileffmpeg."

  s.homepage     = "https://github.com/ubungit/Mobileffmpeg"
  s.license      = "MIT"

  s.author             = { "静静的白色外套" => "ubungit@gmail.com" }
  s.social_media_url   = "https://twitter.com/ubungit"

  s.source       = { :git => "https://github.com/ubungit/Mobileffmpeg.git", :tag => "#{s.version}" }



  s.source_files  = "Mobileffmpeg", "**/*.{h,m}"
  #s.static_framework = true


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

 # s.dependency 'mobile-ffmpeg-full', '~> 4.2.1'
  s.dependency 'mobile-ffmpeg-full'
  
end
