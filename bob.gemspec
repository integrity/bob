Gem::Specification.new do |s|
  s.name    = "bob"
  s.version = "0.4.0"
  s.date    = "2009-10-10"

  s.description = "Bob the Builder will build your code. Simple."
  s.summary     = "Bob builds!"
  s.homepage    = "http://integrityapp.com"

  s.authors = ["Nicolás Sanguinetti", "Simon Rozet"]
  s.email   = "info@integrityapp.com"

  s.require_paths     = ["lib"]
  s.rubyforge_project = "integrity"
  s.has_rdoc          = true
  s.rubygems_version  = "1.3.1"

  s.add_dependency "addressable"

  s.files = %w[
.gitignore
LICENSE
README.rdoc
Rakefile
bob.gemspec
deps.rip
lib/bob.rb
lib/bob/builder.rb
lib/bob/engine.rb
lib/bob/engine/threaded.rb
lib/bob/scm.rb
lib/bob/scm/abstract.rb
lib/bob/scm/git.rb
lib/bob/scm/svn.rb
lib/bob/test.rb
lib/bob/test/builder_stub.rb
lib/bob/test/repo.rb
test/bob_test.rb
test/deps.rip
test/engine/threaded_test.rb
test/git_test.rb
test/helper.rb
test/mixin/scm.rb
test/svn_test.rb
test/test_test.rb
]
end
