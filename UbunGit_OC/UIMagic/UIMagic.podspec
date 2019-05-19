

Pod::Spec.new do |s|

   s.name         = "UIMagic"
  s.version      = "1.0.0"
  s.summary      = "UIMagic"

  s.homepage     = "https://github.com/ubungit/UIMagic"
  s.license      = "MIT"

  s.author             = { "静静的白色外套" => "ubungit@gmail.com" }
  s.social_media_url   = "https://twitter.com/ubungit"

  s.source       = { :git => "https://github.com/ubungit/UIMagic.git", :tag => "#{s.version}" }

  s.source_files  = "UIMagic", "**/*.{h,m}"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  #s.dependency 'mobile-ffmpeg-full'
  
end
