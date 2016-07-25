#
# Be sure to run `pod lib lint Moya-ModelMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Moya-ModelMapper"
  s.version          = "3.0.0"
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

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/*.swift"
    ss.dependency "Moya", "~> 7.0"
    ss.dependency "ModelMapper", "~> 2.0"
    ss.framework  = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Source/RxSwift/*.swift"
    ss.dependency "Moya/RxSwift", "~> 7.0"
    ss.dependency "Moya-ModelMapper/Core"
    ss.dependency "RxSwift", "~> 2.3"
  end

  s.subspec "ReactiveCocoa" do |ss|
    ss.source_files = "Source/ReactiveCocoa/*.swift"
    ss.dependency "Moya/ReactiveCocoa", "~> 7.0"
    ss.dependency "Moya-ModelMapper/Core"
    ss.dependency "ReactiveCocoa", "~> 4.1"
  end
end
