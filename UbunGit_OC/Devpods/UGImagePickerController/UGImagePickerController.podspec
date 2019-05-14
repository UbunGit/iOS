

Pod::Spec.new do |s|

   s.name         = "UGImagePickerController"
  s.version      = "0.1.0"
  s.summary      = "A beautiful photo browser with interactive dismissal animation."

  s.homepage     = "https://github.com/ubungit"
  s.license      = "MIT"

  s.author             = { "静静的白色外套" => "ubungit@gmail.com" }
  s.social_media_url   = "https://github.com/ubungit"

  s.source       = { :git => "https://github.com/ubungit/UGImagePickerController.git", :tag => "#{s.version}" }
  s.static_framework = true


  s.source_files  = "UGImagePickerController", "**/*.{h,m}"
  s.resources    = "UGImagePickerController/*.{png,xib,nib,bundle}"


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  s.dependency 'SuperPlayer'


end
