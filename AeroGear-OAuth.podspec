Pod::Spec.new do |s|
  s.name         = "AeroGear-OAuth"
  s.version      = "1.5.0"
  s.summary      = "Provides a lightweight set of utilities for OAuth grant access request, refresh, revoke and token storage."
  s.homepage     = "https://github.com/corinnekrych/aerogear-ios-oauth"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/corinnekrych/aerogear-ios-oauth.git' }
  s.platform     = :ios, 7.0
  s.source_files = 'AeroGear-iOS/**/*.{h,m}'

  s.public_header_files = 'AeroGear-iOS/AeroGear-OAuth.h', 'AeroGear-iOS/Security/Authorizer/AGAuthorizer.h', 'AeroGear-iOS/Security/Authorizer/AGAuthzConfig.h', 'AeroGear-iOS/Security/Authorizer/AGAccountManager.h'

  s.requires_arc = true
  s.dependency 'AeroGear-Pipe'. :git => 'https://github.com/corinnekrych/aerogear-ios-pipe.git'
  s.dependency 'AeroGear-Store', :git => 'https://github.com/corinnekrych/aerogear-ios-store.git'
end
