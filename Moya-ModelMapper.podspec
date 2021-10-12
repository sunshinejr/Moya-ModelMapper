#
# Be sure to run `pod lib lint Moya-ModelMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Moya-ModelMapper"
  s.version          = "10.0.1"
  s.summary          = "ModelMapper bindings for Moya."
  s.description      = <<-EOS
  [ModelMapper](https://github.com/lyft/mapper) bindings for
  [Moya](https://github.com/Moya/Moya) for easier JSON serialization.
  Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) bindings as well.
  Instructions on how to use it are in
  [the README](https://github.com/sunshinejr/Moya-ModelMapper).
  EOS

  s.homepage         = "https://github.com/sunshinejr/Moya-ModelMapper"
  s.license          = 'MIT'
  s.author           = { "Łukasz Mróz" => "thesunshinejr@gmail.com" }
  s.source           = { :git => "https://github.com/sunshinejr/Moya-ModelMapper.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thesunshinejr'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'
  s.requires_arc = true
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/Moya-ModelMapper/*.swift"
    ss.dependency "Moya", "~> 15.0"
    ss.dependency "ModelMapper", "~> 10.0"
    ss.framework  = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/RxMoya-ModelMapper/*.swift"
    ss.dependency "Moya/RxSwift", "~> 15.0"
    ss.dependency "Moya-ModelMapper/Core"
    ss.dependency "RxSwift"
  end

  s.subspec "ReactiveSwift" do |ss|
    ss.source_files = "Sources/ReactiveMoya-ModelMapper/*.swift"
    ss.dependency "Moya/ReactiveSwift", "~> 15.0"
    ss.dependency "Moya-ModelMapper/Core"
    ss.dependency "ReactiveSwift"
  end
end
