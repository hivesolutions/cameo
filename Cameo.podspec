Pod::Spec.new do |s|
  s.name             = "Cameo"
  s.version          = "0.2.20"
  s.summary          = "A generic framework for ios interaction that provides a series of utilities."
  s.description      = <<-DESC
                       A generic framework for ios interaction that provides a series of utilities.
                       Use the framrwork to avoid extra repetitive work.
                       DESC
  s.homepage         = "http://cameo.hive.pt/"
  s.license          = "Apache License, Version 2.0"
  s.author           = { "hivesolutions" => "development@hive.pt" }
  s.source           = { :git => "https://github.com/hivesolutions/cameo.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hivesolutions'

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'src/classes'
  s.resource_bundle = { 'HMBaseResources' => ['src/bundles/HMBaseResources.bundle/**'] }

  s.public_header_files = 'src/classes/*.h'
end
