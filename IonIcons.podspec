Pod::Spec.new do |s|
  s.name         = "ionicons"
  s.module_name  = "ionicons"
  s.version      = "2.0.2"
  s.summary      = "ionicons-iOS allows you to easily use ionicons icons in your iOS projects."
  s.homepage     = "https://github.com/TapTemplate/ionicons-iOS"
  s.license      = { :type => 'MIT', :file => 'ionicons/LICENSE' }
  s.author       = { "David Sweetman" => "david@davidsweetman.com" }
  s.source       = { :git => "https://github.com/TapTemplate/ionicons-iOS.git", :tag => "2.0.2" }
  s.platform     = :ios, '5.0'
  s.source_files = 'ionicons/**/*.{h,m}'
  s.resources     = "ionicons/ionicons.ttf"
  s.ios.resource_bundle = { 'ionicons' => 'ionicons/ionicons.ttf' }
  s.requires_arc = true
end
