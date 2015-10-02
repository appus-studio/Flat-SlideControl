Pod::Spec.new do |s|
  s.name         = "Flat-SlideControl"
  s.version      = "0.0.1"
  s.summary      = "Flat-SlideControl is a control in material design, which gives you an opportunity to make a selection of a range of values"
  s.homepage     = "http://appus.pro"
  s.license      = { :type => "Apache", :file => 'LICENSE' }
  s.author       = { "Alexey Kubas" => "alexey.kubas@appus.me" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/appus-studio/Flat-SlideControl.git", :tag => "0.0.1" }
  s.source_files = "FlatSlideControl", "FlatSlideControl/*.{h,m}"
  s.framework             = 'Foundation'
  s.requires_arc = true
end
