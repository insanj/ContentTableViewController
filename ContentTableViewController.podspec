#
# Be sure to run `pod lib lint ContentTableViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ContentTableViewController"
  s.version          = "0.1"
  s.summary          = "Super simple table view controller."
  s.description      = <<-DESC
                       Super simple table view controller. Supply a few object types and the controller automatically creates a table around them for you.
                       DESC
  s.homepage         = "https://github.com/insanj/ContentTableViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'GNU'
  s.author           = { "insanj" => "insanj@gmail.com" }
  s.source           = { :git => "https://github.com/insanj>/ContentTableViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/insanj'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ContentTableViewController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
