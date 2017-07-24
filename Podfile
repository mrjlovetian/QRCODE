
platform :ios, '8.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'git@codehub.tops001.com:yuhongjiang642/podPush.git'

def pods
    
pod 'WechatOpenSDK'
pod 'Tencent_SDK', '~> 3.1.3'
pod 'Weibo', '~> 2.4.2'
pod 'YHJQRCode', '~> 0.2.0.9'
pod 'INTULocationManager' #定位管理
pod 'OC-Category', '~> 0.1.3.8'#类目管理
pod 'BaiduMap-iOS-SDK', '~> 3.0'        #百度地图集成



end

def selfPods
    pod 'podPush'
end


target 'QRCode' do
  pods
#  selfPods
end
xcodeproj 'QRCode.xcodeproj'
