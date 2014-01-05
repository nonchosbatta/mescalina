require 'bundler'
Bundler.require

desc 'Build the script to mescalina.js'
task :build do
  env = Opal::Environment.new
  env.append_path 'app'
  env.append_path 'css'
  env.append_path 'fonts'
  env.append_path 'js'

  File.open('mescalina.js', 'w+') do |out|
    out << env['application'].to_s
  end
end