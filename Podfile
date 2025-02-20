source 'https://e.coding.net/tcmpp-work/tcmpp/tcmpp-repo.git'
source 'https://cdn.cocoapods.org/'

target 'MiniAppTester' do
  platform :ios, '16.0'
  use_frameworks!
  
  # TCMPP SDK
  pod 'TCMPPSDK'
  pod 'TCMPPExtScanCode'
  pod 'TCMPPExtMedia'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end

end
