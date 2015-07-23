Gem::Specification.new do |s|
  s.name        = 'teligem'
  s.version     = '0.0.1'
  s.date        = '2015-07-22'

  s.summary     = "A gem to implement Telipass micropayment"
  s.description = "A gem to implement Telipass micropayment notifications for basic payments"

  s.authors     = ["Arpsara, CT2C"]
  s.email       = 'contact@ct2c.fr'

  s.files       = ["lib/teligem.rb", "config/secrets.yml"]

  s.add_development_dependency "rspec"

  s.homepage    = 'http://rubygems.org/gems/teligem'
  s.license       = 'MIT'
end
