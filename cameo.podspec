Pod::Spec.new do |s|
  s.name             = "Cameo"
  s.version          = "0.1.0"
  s.summary          = "A generic framework for ios interaction that provides a series of utilities."
  s.description      = <<-DESC
                       A generic framework for ios interaction that provides a series of utilities.
                       DESC
  s.homepage         = "http://cameo.hive.pt"
  s.license          = 'GPL'
  s.author           = { "hivesolutions" => "development@hive.pt" }
  s.source           = { :git => "https://github.com/hivesolutions/cameo.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hivesolutions'

  s.requires_arc = true

  s.source_files = 'src/classes'
  s.resources = 'src/bundles/HMBaseResources.bundle/static/**'

  s.public_header_files = 'src/classes/*.h'
end