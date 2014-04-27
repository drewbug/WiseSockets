# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'WiseSockets'
  app.seed_id = 'DBNMT67U85'
  app.identifier = 'ug.drewb.WiseSockets'

  app.provisioning_profile = './iOS_Team_Provisioning_Profile.mobileprovision'

  app.deployment_target = '6.1'

  app.device_family = [:iphone, :ipad]

  app.entitlements['application-identifier'] = "#{app.seed_id}.#{app.identifier}"

  app.icons = ['Icon-60', 'Icon-76', 'Icon-72']

  app.version = '1.0'

  app.frameworks << 'CoreMotion'

  app.pods { pod 'UI7Kit' }
  app.pods { pod 'CocoaAsyncSocket' }
end
