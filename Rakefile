require 'bundler'
Bundler.require

desc 'Build the script to mescalina.js and render the view'
task :build do
  env = Opal::Environment.new
  env.append_path 'app'
  env.append_path 'js'
  env.append_path 'fonts'
  env.append_path 'css'

  File.open('mescalina.js', 'w+') do |out|
    out << env['application'].to_s
  end

  File.open('index.html', 'w+') do |out|
    f = File.read('index.html.haml').gsub('= javascript_include_tag "application"', '%script(src="mescalina.js")')
    out << Haml::Engine.new(f).render
  end
end
