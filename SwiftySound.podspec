Pod::Spec.new do |s|

  s.name         = 'SwiftySound'
  s.version      = '1.2.0'
  s.summary      = 'SwiftySound lets you play sounds with a single line of code.'

  s.homepage     = 'https://github.com/adamcichy/SwiftySound'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Adam Cichy' => 'adam@moonlightapps.com' }
  s.social_media_url   = 'https://www.facebook.com/Moonlight-Apps-146257068893019/'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/adamcichy/SwiftySound.git', :tag => s.version }

  s.source_files = 'Sources/**/*.swift'
  s.frameworks   = 'Foundation', 'AVFoundation'

  s.swift_version = '5.1'

end
