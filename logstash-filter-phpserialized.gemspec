Gem::Specification.new do |s|
  s.name = 'logstash-filter-phpserialized'
  s.version = '0.1.0'
  s.licenses = ['Apache License (2.0)']
  s.summary = "unserialize php serialized data"
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["mhoffmann"]
  s.email = 'info@elastic.co'
  s.homepage = "https://github.com/mhoffmann/logstash-filter-phpserialized"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*', 'spec/**/*', 'vendor/**/*', '*.gemspec', '*.md', 'CONTRIBUTORS', 'Gemfile', 'LICENSE', 'NOTICE.TXT']
  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = {"logstash_plugin" => "true", "logstash_group" => "filter"}

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 3.0.0"
  s.add_runtime_dependency 'php-serialization', '~> 0.5.3'
  s.add_development_dependency 'logstash-devutils'
end
