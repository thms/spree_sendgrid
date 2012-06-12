Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_sendgrid'
  s.version     = '0.2.0'
  s.summary     = 'Spree Commerce Extensions for Sendgrid'

  s.author        = 'Thomas Boltze'
  s.email         = 'thomas.boltze@gmail.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
  
  # Newsletter API for sendgrid
  s.add_dependency 'gatling_gun'

  s.has_rdoc = false
end
