Pod::Spec.new do |s|
  s.name         = "APFlatSlideControl"
  s.version      = "0.0.3"
  s.summary      = "APFlatSlideControl is a control which gives you an opportunity to make a selection of a range of values"
  s.homepage     = "http://appus.pro"
  s.license      = { :type => "Apache", :file => 'LICENSE' }
  s.author       = { "Alexey Kubas" => "alexey.kubas@appus.me" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/alexey-kubas-appus/Flat-SlideControl.git", :tag => "0.0.3" }
  s.source_files = "APFlatSlideControl", "APFlatSlideControl/*.{h,m}"
  s.framework             = 'Foundation'
  s.requires_arc = true
end
