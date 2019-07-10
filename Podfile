source 'https://github.com/CocoaPods/Specs.git'
# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'Sample'

def ui_pods
    pod 'MaterialComponents', '~> 85.4.0'
    pod 'PKHUD', '~> 5.0'
end

target 'SampleApp' do
    project 'SampleApp/SampleApp.xcodeproj'
    ui_pods
end

# post_install do |installer|
#     installer.pods_project.targets.each do |target|
#         target.build_configurations.each do |config|
#             config.build_settings['ENABLE_BITCODE'] = "YES"
#             config.attributes.delete('EMBEDDED_CONTENT_CONTAINS_SWIFT')
#         end
#     end
# end
