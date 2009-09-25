require File.dirname(__FILE__) + "/../helper"

class BobGitTest < Test::Unit::TestCase
  include ScmTest

  def setup
    super

    @repo = GitRepo.new(:test_repo)
    @repo.create
  end

  def path(uri, branch="master")
    SCM::Git.new(uri, branch).__send__(:path)
  end

  def test_converts_repo_uri_into_path
    assert_equal "git-github-com-integrity-bob-master",
      path("git://github.com/integrity/bob")
    assert_equal "git-example-org-foo-repo-master",
      path("git@example.org:~foo/repo")
    assert_equal "tmp-repo-git-master", path("/tmp/repo.git")
    assert_equal "tmp-repo-git-foo",    path("/tmp/repo.git", "foo")
  end
end
