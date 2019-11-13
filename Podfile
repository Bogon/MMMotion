# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MMMotion' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
# System/Network/Permission
  pod 'CCNetwokingKit', :git => 'https://github.com/Bogon/CCNetwokingKit.git'
  #pod 'SPPermission'
  pod 'SDWebImage'
  
# GCD && THREAD
  pod 'AsyncSwift', '~> 2.0.4'                      # Syntactic sugar in Swift for asynchronous dispatches in Grand Central Dispatch
  
# UI
  pod 'SnapKit', '~> 4.2.0'                       # Harness the power of auto layout
  pod 'RTRootNavigationController', '~> 0.7.1'    # controller has its own navigation bar
  pod 'Hue', '~> 4.0.0'                           # The all-in-one coloring utility that you'll ever need.
  #pod 'KafkaRefresh'               # Highly scalable, custom, multi-style refresh framework.
  #pod 'SPLarkController' #, '~> 1.0.9' Make settings screen for application. Can add buttons and switches. Easy customisation.
  #pod 'SPStorkController' #, '~> 1.6.5' Very similar to the controllers displayed in Apple Music, Podcasts and Mail Apple's applications.
  #pod 'PullToDismiss', '~> 2.2' # Dismiss ViewController by pulling scroll view or navigation bar in Swift.
  #pod 'PanModal', '~> 1.2.4' # PanModal is an elegant and highly customizable presentation API for constructing bottom sheet modals on iOS
  
  pod 'pop'
  pod 'TWMessageBarManager'
  
# UI KeyBoard
  #pod 'IQKeyboardManagerSwift'    #  键盘事件管理

# UI&Foundation Extention
  pod 'SwifterSwift', '~> 4.6.0' # A handy collection of more than 500 native Swift extensions to boost your productivity.

# Utils tools
  pod 'SwiftDate'  #, '~> 6.0.1' #The best way to deal with Dates & Time Zones in Swift
  #pod 'AutoInch', '~> 1.1.2'  # iPhone 等比例/全尺寸 适配工具
  #pod 'UIImageColors', '~> 2.1.0' # iTunes style color fetcher for UIImage and NSImage.

  pod 'FDFullscreenPopGesture', '~> 1.1'
  #pod 'SideMenu'

# 添加UIy调试框架
  pod 'LookinServer', :configurations => ['Debug']
 
  target 'MMMotionTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MMMotionUITests' do
    # Pods for testing
  end

end
