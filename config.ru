require 'bundler'
Bundler.require

run Opal::Server.new { |s|
  s.append_path 'app'
  s.append_path 'css'
  s.append_path 'fonts'
  s.append_path 'js'

  s.debug = true
  s.main  = 'application'
}
