

Pod::Spec.new do |s|

  s.name         = "BlockCollectionView"
  s.version      = "1.0.0"
  s.summary      = "BlockCollectionView"

  s.homepage     = "https://github.com/ubungit/BlockCollectionView"
  s.license      = "MIT"

  s.author             = { "静静的白色外套" => "ubungit@gmail.com" }
  s.social_media_url   = "https://twitter.com/ubungit"

  s.source       = { :git => "https://github.com/ubungit/BlockCollectionView.git", :tag => "#{s.version}" }
  
  s.source_files = "Sources/**/*.{h,m}"
  

  s.default_subspec = 'Core'
  s.dependency 'Masonry'
  s.dependency 'UGCategory'
  s.dependency 'SDWebImage'

  s.subspec 'Core' do |core|
    core.source_files = "Sources/**/*.{h,m}"
    
  end

  s.subspec 'Test' do |test|
    test.source_files = "Test/**/*.{h,m}"
    
    test.dependency 'BlockCollectionView/Core'
    
    
      
    test.dependency  'DoraemonKit/Core'
    test.dependency  'DoraemonKit/WithLogger'
    test.dependency  'DoraemonKit/WithLoad'
  end


  
end
