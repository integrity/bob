require "test/unit"
require "contest"
require "hpricot"

begin
  require "redgreen"
  require "ruby-debug"
rescue LoadError
end

require "bob"
require "bob/test"
require "mixin/scm"

class Test::Unit::TestCase
  include Bob
  include Bob::Test

  attr_reader :repo

  def setup
    Bob.logger = Logger.new("/dev/null")
    Bob.engine = Bob::Engine::Foreground
    Bob.directory = Pathname(__FILE__).dirname.join("..", "tmp").expand_path

    Bob.directory.rmtree if Bob.directory.directory?
    Bob.directory.mkdir
  end
end
