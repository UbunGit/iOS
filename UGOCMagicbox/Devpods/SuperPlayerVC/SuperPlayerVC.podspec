

Pod::Spec.new do |s|

   s.name         = "SuperPlayerVC"
  s.version      = "0.1.0"
  s.summary      = "A beautiful photo browser with interactive dismissal animation."

  s.homepage     = "https://github.com/skx926/SuperPlayerVC"
  s.license      = "MIT"

  s.author             = { "Kyle Sun" => "skx926@gmail.com" }
  s.social_media_url   = "https://twitter.com/skx926"

  s.source       = { :git => "https://github.com/skx926/SuperPlayerVC.git", :tag => "#{s.version}" }
  s.static_framework = true


  s.source_files  = "SuperPlayerVC", "**/*.{h,m}"


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  s.dependency 'SuperPlayer'


end
