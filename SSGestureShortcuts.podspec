Pod::Spec.new do |s|
  s.platform     = :ios, '5.0'
  s.name         = 'SSGestureShortcuts'
  s.version      = '0.1.3'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/sandalsoft/SSGestureShortcuts'
  s.authors      = { 'Eric Nelson' => 'eric@sandalsoft' }
  s.summary      = 'Objective-C library to read complex touch gestures and perform an action. '
  s.source       =  {
                      :git => 'https://github.com/sandalsoft/SSGestureShortcuts.git', 
                      :tag=> s.version.to_s
					}  
  s.source_files = 'SSGestureShortcuts/*.{h,m,xib}'
  s.resources = 'SSGestureShortcuts/*.xib'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
end
