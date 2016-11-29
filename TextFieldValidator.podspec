#
# Be sure to run `pod lib lint AddressGeocoder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TextFieldValidator"
  s.version          = "0.0.1"
  s.summary          = "Text field validation helper"

  s.description      = <<-DESC
Text field validation helper. Provides a structure to validate text fields, as well as helper functions using regular expressions.
                       DESC

  s.homepage         = "https://github.com/prolificinteractive/TextFieldValidator"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Thibault Klein" => "thibault@prolificinteractive.com" }
  s.source           = { :git => "https://github.com/prolificinteractive/TextFieldValidator.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*.{swift}'
end
