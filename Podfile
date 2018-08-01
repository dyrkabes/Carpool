source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Carpool'

def all_pods
    pod 'MBProgressHUD', '~> 1.1.0'
end

target 'Carpool' do
    project 'Carpool.xcodeproj'
    all_pods
end

target 'CPCommon' do
    project 'CPCommon/CPCommon.xcodeproj'
    all_pods
end

target 'CPCommonTests' do
    project 'CPCommon/CPCommon.xcodeproj'
    pod 'MBProgressHUD', '~> 1.1.0'
end
