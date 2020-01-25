

Pod::Spec.new do |s|

  	s.name         = "LibraryTest"
	s.version      = "1.0.0"
	s.summary      = "A knob control like the UISlider, but in a circular form."
	s.description  = "The knob control is a completely customizable widget that can be used in any iOS app.It also plays a little victory fanfare."
	s.homepage     = "http://raywenderlich.com"
	s.license      = "MIT"
	s.platform     = :ios, "11.0"
	s.source       = { :path => '.'}
	s.source_files = "LibraryTest"
	s.swift_version = "4.0"
	s.author       = { "Hardik Vyas" => "hardik.vyas@eryushion.com" }
end
