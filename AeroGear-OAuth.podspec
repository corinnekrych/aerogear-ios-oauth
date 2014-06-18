Pod::Spec.new do |s|
  s.name         = "AeroGear-OAuth"
  s.version      = "1.5.0"
  s.summary      = "Provides a lightweight set of utilities for OAuth grant access request, refresh, revoke and token storage."
  s.homepage     = "https://github.com/corinnekrych/aerogear-ios-oauth"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/corinnekrych/aerogear-ios-oauth.git' }
  s.platform     = :ios, 7.0

  s.default_subspec = 'standard'

  s.subspec 'common' do |ss|
    ss.source_files = 'AeroGear-iOS/**/*.{h,m}'
    ss.public_header_files = 'AeroGear-iOS/AeroGear-OAuth.h', 'AeroGear-iOS/Security/Authorizer/AGAuthorizer.h', 'AeroGear-iOS/Security/Authorizer/AGAuthzConfig.h', 'AeroGear-iOS/Security/Authorizer/AGAccountManager.h'
    ss.requires_arc = true
    ss.dependency 'AeroGear-Pipe'
  end

  s.subspec 'standard' do |ss|
    ss.dependency 'AeroGear-Store'
    ss.dependency 'AeroGear-OAuth/common'
  end

  s.subspec 'encrypted' do |ss|
    ss.dependency 'AeroGear-Store'
    ss.dependency 'AeroGear-OAuth/common'
  end

end
