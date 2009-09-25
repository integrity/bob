require File.dirname(__FILE__) + "/helper"

class BobSvnTest < Test::Unit::TestCase
  include ScmTest

  def setup
    super

    @repo = SvnRepo.new(:test_repo)
    @repo.create
  end

  def path(uri)
    SCM::Svn.new(uri, "").__send__(:path)
  end

  test "converts svn repo uri into a path" do
    assert_equal "http-rubygems-rubyforge-org-svn",
      path("http://rubygems.rubyforge.org/svn/")

    assert_equal "svn-rubyforge-org-var-svn-rubygems",
      path("svn://rubyforge.org/var/svn/rubygems")

    assert_equal "svn-ssh-developername-rubyforge-org-var-svn-rubygems",
      path("svn+ssh://developername@rubyforge.org/var/svn/rubygems")

    assert_equal "home-user-code-repo",
      path("/home/user/code/repo")
  end
end
