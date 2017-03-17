Pod::Spec.new do |s|
  #1.
  s.name          = "FujiSDK"
  #2.
  s.version       = "1.0.0"
  #3.  
  s.summary       = "Sort description of 'FujiSDK' framework"
  #4.
  s.homepage      = "https://fujigame.net/"
  #5.
  s.license       = "MIT"
  #6.
  s.author        = "Nick D., Tuan L."
  #7.
  s.platform      = :ios, "10.0"
  #8.
  s.source        = { :git => "nami-net@nami-net.git.backlog.jp:/FJ_GAME_PF/fuji_sdk_swift.git" }
  #9.
  s.source_files  = "FujiSDK", "FujiSDK/**/*.{h,m,swift}"

  s.resource_bundles = {"FujiSDK" => ["FujiSDK/**/*.{lproj,storyboard,png,jpg,jpeg}"]}

  s.dependency 'Alamofire', '~> 4.4'
  s.dependency 'SwiftyJSON'
  s.dependency 'NVActivityIndicatorView'
  s.dependency 'Toast-Swift'
  s.dependency 'CryptoSwift'
  s.dependency 'STRegex'
  s.dependency 'DatePickerDialog'
end