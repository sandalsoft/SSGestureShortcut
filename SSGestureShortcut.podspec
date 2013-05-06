Pod::Spec.new do |s|
  s.platform     = :ios, '5.0'
  s.name         = 'SSGestureShortcut'
  s.version      = '0.1.3'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/sandalsoft/SSGestureShortcut'
  s.authors      = { 'Eric Nelson' => 'eric@sandalsoft' }
  s.summary      = 'Objective-C library to read complex touch gestures and perform an action. '
  s.source       =  {
                      :git => 'https://github.com/sandalsoft/SSGestureShortcut.git', 
                      :tag=> s.version.to_s
					}  
  s.source_files = 'SSGestureShortcut/*.{h,m,xib}'
  s.resources = 'SSGestureShortcut/*.xib'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
end
