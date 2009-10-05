require File.dirname(__FILE__) + "/helper"

class BobGitTest < Test::Unit::TestCase
  include ScmTest

  def setup
    super

    @repo = GitRepo.new
    @repo.create
  end

  def path(uri, branch="master")
    SCM::Git.new(uri, branch).dir_for("commit").
      sub(Bob.directory, "").to_s[1..-1]
  end

  def test_converts_repo_uri_into_path
    assert_equal "git-github-com-integrity-bob-master/commit",
      path("git://github.com/integrity/bob")
    assert_equal "git-example-org-foo-repo-master/commit",
      path("git@example.org:~foo/repo")
    assert_equal "tmp-repo-git-master/commit", path("/tmp/repo.git")
    assert_equal "tmp-repo-git-foo/commit",    path("/tmp/repo.git", "foo")
  end
end
