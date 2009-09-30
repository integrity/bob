require File.dirname(__FILE__) + "/helper"

class BobSvnTest < Test::Unit::TestCase
  include ScmTest

  def setup
    super

    @repo = SvnRepo.new(:test_repo)
    @repo.create
  end

  def path(uri)
    SCM::Svn.new(uri, "").dir_for("commit").
      sub(Bob.directory, "").to_s[1..-1]
  end

  test "converts svn repo uri into a path" do
    assert_equal "http-rubygems-rubyforge-org-svn/commit",
      path("http://rubygems.rubyforge.org/svn/")

    assert_equal "svn-rubyforge-org-var-svn-rubygems/commit",
      path("svn://rubyforge.org/var/svn/rubygems")

    assert_equal "svn-ssh-developername-rubyforge-org-var-svn-rubygems/commit",
      path("svn+ssh://developername@rubyforge.org/var/svn/rubygems")

    assert_equal "home-user-code-repo/commit",
      path("/home/user/code/repo")
  end
end
