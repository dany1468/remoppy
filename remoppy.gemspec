lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'remoppy/version'

Gem::Specification.new do |spec|
  spec.name          = 'remoppy'
  spec.version       = Remoppy::VERSION
  spec.authors       = ['dany1468']
  spec.email         = ['dany1468@gmail.com']

  spec.summary       = %q{Simple Remotty Bot Framework}
  spec.description   = %q{Simple Remotty Bot Framework}
  spec.homepage      = 'https://github.com/dany1468/remoppy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'hashie'
  spec.add_dependency 'thor'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'termcolor'
  spec.add_dependency 'chrono'
  spec.add_dependency 'socket.io-client-simple'
  spec.add_dependency 'eventmachine'
  spec.add_dependency 'flexirest'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'timecop'
end
