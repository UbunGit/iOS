

Pod::Spec.new do |s|

   s.name         = "UGBox"
  s.version      = "1.1.0"
  s.summary      = "OC常用功能"

  s.homepage     = "https://github.com/ubungit/UGBox"
  s.license      = "MIT"

  s.author             = { "ubungit" => "296019487@qq.com" }
  s.social_media_url   = "296019487@qq.com"

  s.source       = { :git => "https://github.com/ubungit/UGOCMagicbox.git", :tag => "#{s.version}" }
  s.static_framework = true


  
  
  s.default_subspec = 'base'
  
  s.subspec 'base' do |spec|
    spec.source_files  = "UGBox", "**/Category/*.{h,m}"
  end


end
