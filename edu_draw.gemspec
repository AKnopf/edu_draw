Gem::Specification.new do |s|
  s.name         = 'edu_draw'
  s.version      = '2.0.1'
  s.date         = '2015-02-25'
  s.summary      = "Offers a simple API to open a window and draw in it"
  s.description  = "Simple object oriented API for opening a window and drawing in it. Based on gosu. It's meant to teach beginners programming as a visualization of code can help."
  s.authors      = ["Marvin Ede"]
  s.email        = 'marvinede@gmx.net'
  s.files        = Dir["lib/**/*.rb"] +
    Dir["test/**/*.rb"] +
    Dir["examples/**/*.rb"] +
    ["LICENSE", "Rakefile", "README.md"]
  s.homepage     =
    'https://github.com/AKnopf/edu_draw'
  s.license      = 'MIT'
  s.required_ruby_version = ">= 2"
  s.rdoc_options = '--no-private'
  s.has_rdoc     = 'yard'

  s.add_runtime_dependency 'gosu', '~>0.8'
  s.add_development_dependency 'mocha', '~>1.1'
  s.add_development_dependency 'minitest-focus', '~>1.1'
end