Pod::Spec.new do |s|
  s.name          = "NHCalendarActivity"
  s.version       = "0.0.1"
  s.summary       = "NHCalendarActivity is an easy to use custom UIActivity (iOS 6+) that adds events and alarms to the iOS calendar."
  s.homepage      = "https://github.com/otaviocc/NHCalendarActivity"
  
  s.author        = { "Otavio Cordeiro" => "contact@otaviocc.com" }
  s.source        = { :git => "https://github.com/otaviocc/NHCalendarActivity.git", :tag => s.version }
  s.license       = { :type => 'MIT' }
  
  s.source_files  = 'NHCalendarActivity'
  s.resource      = "NHCalendarActivity/NHCalendarActivity.bundle"
  
  s.platform      = :ios, '6.0'
  s.framework     = 'EventKit'
  s.requires_arc  = true
end