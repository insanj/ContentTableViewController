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
  s.version          = "1.1.2"
  s.summary          = "Super simple way to present content."
  s.description      = <<-DESC
                       Super simple way to present content. A template table view that can take several kinds of objects and present them on-the-fly with one line of code. Customization of the view controller can be done as expected, customization of the table view can be done by accessing contentController.tableView, and customization of the cells can be done through a few ContentTableViewController options.
                       DESC
  s.homepage         = "https://github.com/insanj/ContentTableViewController"
  s.screenshots      = "https://raw.githubusercontent.com/insanj/ContentTableViewController/master/example-empty.png", "https://raw.githubusercontent.com/insanj/ContentTableViewController/master/example-full.png"
  s.license          = "GNU"
  s.author           = { "insanj" => "insanjmail@gmail.com" }
  s.source           = { :git => "https://github.com/insanj/ContentTableViewController.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/insanj"
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = "Pod/Classes/**/*"
  #s.dependency "KIChameleonView"
end
