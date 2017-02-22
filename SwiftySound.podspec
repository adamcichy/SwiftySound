Pod::Spec.new do |s|

  s.name         = 'SwiftySound'
  s.version      = '0.1.0'
  s.summary      = 'Swifty Sound'

  s.description  = <<-DESC
                   SwiftySound is a simple AVFoundation wrapper for iOS
                   DESC

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
