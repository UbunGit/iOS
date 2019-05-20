

Pod::Spec.new do |s|

  s.name         = "UGCategory"
  s.version      = "1.0.0"
  s.summary      = "UGCategory"

  s.homepage     = "https://github.com/ubungit/UGCategory"
  s.license      = "MIT"

  s.author             = { "静静的白色外套" => "ubungit@gmail.com" }
  s.social_media_url   = "https://twitter.com/ubungit"

  s.source       = { :git => "https://github.com/ubungit/UGCategory.git", :tag => "#{s.version}" }
  
  s.source_files = "Sources/**/*.{h,m}"
  
  s.dependency 'Masonry'
  s.dependency 'MBProgressHUD'
  s.source_files = "Sources/**/*.{h,m}"

end
