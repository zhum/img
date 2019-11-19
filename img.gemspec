# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require 'img/version.rb'

Gem::Specification.new do |s|
  s.name        = 'img'
  s.version     = IMG::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Sergey Zhumatiy']
  s.email       = ['serg@parallel.ru']
  s.homepage    = "https://github.com/zhum/img"
  s.summary     = %q{Make requests to different data sources}
  s.description = %q{Make requests to different data sources}

  s.rubyforge_project = 'img'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end