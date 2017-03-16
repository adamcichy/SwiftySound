Pod::Spec.new do |s|

  s.name         = 'SwiftySound'
  s.version      = '0.2.0'
  s.summary      = 'Swifty Sound is a simple library that lets you play sounds with a single line of code.'

  s.homepage     = 'https://github.com/adamcichy/SwiftySound'
  s.license      = 'MIT'
  s.author       = { 'Adam Cichy' => 'adam@moonlightapps.com' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/adamcichy/SwiftySound.git', :tag => s.version }

  s.source_files = 'Classes/**/*.swift'
  s.frameworks   = 'Foundation', 'AVFoundation'
  
end
