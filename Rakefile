require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

Dir.glob('tasks/*.rake').each { |r| import r }

desc 'Open a pry session preloaded with the IMG'
task :console do
  sh %{pry -I lib -r #{File.basename(Dir.pwd)}.rb}
end

