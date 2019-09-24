#
# Be sure to run `pod lib lint Mextension.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  s.name             = 'Mextension'
  s.version          = '0.4.3'
  s.summary          = 'Some extensions classes to help code'
  s.description      = <<-DESC
                    Some powerful extensions to help your code and do not copy code from stack overflow
                       DESC

  s.homepage         = 'https://github.com/vitormesquita/mexetesion'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vitor Mesquita' => 'vitor.mesquita09@gmail.com' }
  s.source           = { :git => 'https://github.com/vitormesquita/mexetesion.git', :tag => s.version.to_s }
  s.swift_versions   = [5.0]

  s.ios.deployment_target = '10.0'
  s.default_subspec = "All"

  s.subspec "All" do |ss|
    ss.source_files  = "Source/**/*"
    ss.framework = "UIKit"
    ss.framework  = "Foundation"
  end

  s.subspec "UIKit" do |ss|
    ss.source_files  = "Source/UIKit+Extensions/*.swift"
    ss.framework = "UIKit"
  end

  s.subspec "Foundation" do |ss|
    ss.source_files  = "Source/Foundation+Extensions/*.swift"
    ss.framework = "Foundation"
  end
end
