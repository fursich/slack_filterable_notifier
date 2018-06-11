lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exception_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "exception_notifier_slack"
  spec.version       = ::ExceptionNotifier::ExceptionNotifierSlack::VERSION
  spec.authors       = ["Koji Onishi"]
  spec.email         = ["fursich0@gmail.com"]

  spec.summary       = %q{A customizable slack notifier for exception_notification.}
  spec.description   = %q{Can selectively silence, or simplify messages for specified types of exceptions, without changing 'global' execption_notification options.}
  spec.homepage      = "https://github.com/fursich/exception_notifier_slack"
  spec.license       = "MIT"

  # TODO remove when publisized
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 2.1'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mocha", ">= 0.13.0"

  spec.add_development_dependency "rails", ">= 4.0", "< 6"
  spec.add_development_dependency "pry"
  spec.add_dependency "exception_notification", ">= 4.0"
  spec.add_dependency "slack-notifier", ">= 1.0.0" # TODO consider to replace slack api wrapper to better customize message format
end
