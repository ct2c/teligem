Gem::Specification.new do |s|
  s.name        = 'teligem'
  s.version     = '0.0.1'
  s.date        = '2015-07-22'
  s.platform = Gem::Platform::RUBY
  s.summary     = "A gem to implement Telipass micropayment"
  s.description = "A gem to implement Telipass micropayment notifications for basic payments"

  s.authors     = ["Arpsara, CT2C"]
  s.email       = 'contact@ct2c.fr'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"

  s.homepage    = 'https://github.com/ct2c/teligem.git'
  s.license       = 'MIT'
end
