# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'

source 'https://github.com/HrbrIO/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'BeaconSampleSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BeaconSampleSwift
  pod 'HarborBeacon', "~> 1.2.0"

end

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
