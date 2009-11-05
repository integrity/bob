require "helper"

class BobTestTest < Test::Unit::TestCase
  def assert_scm_repo(repo)
    repo.create

    assert_equal 1, repo.commits.size
    assert_equal "First commit", repo.commits.first["message"]

    repo.add_failing_commit
    assert_equal 2, repo.commits.size
    assert_equal "This commit will fail", repo.commits.last["message"]
    assert_equal repo.commits.last["id"], repo.head
    assert repo.short_head

    repo.add_successful_commit
    assert_equal 3, repo.commits.size
    assert_equal "This commit will work", repo.commits.last["message"]
    assert_equal repo.commits.last["id"], repo.head
  end

  def test_scm_repo
    assert_scm_repo(GitRepo.new)
    assert_scm_repo(SvnRepo.new)
  end
end
