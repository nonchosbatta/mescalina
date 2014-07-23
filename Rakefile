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
    f = File.read('index.it.html.haml').gsub('= javascript_include_tag "application"', '%script(src="mescalina.js")')
    out << Haml::Engine.new(f).render
  end

  File.open('en.html', 'w+') do |out|
    f = File.read('index.html.haml').gsub('= javascript_include_tag "application"', '%script(src="mescalina.js")')
    out << Haml::Engine.new(f).render
  end
end

desc 'Clean the compiled files'
task :clean do
  File.delete 'mescalina.js' if File.exists? 'mescalina.js'
  File.delete 'index.html'   if File.exists? 'index.html'
  File.delete 'en.html'      if File.exists? 'en.html'
end
