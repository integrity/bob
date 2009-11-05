module ScmTest
  include Bob::Test

  def test_successful_build
    repo.add_successful_commit

    commit_id = repo.commits.last["id"]

    buildable = BuilderStub.for(@repo, commit_id)
    buildable.build

    assert_equal :successful,          buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal "This commit will work", buildable.commit_info["message"]
    assert_equal commit_id,               buildable.commit_info["id"]
    assert buildable.commit_info["timestamp"].is_a?(Time)
  end

  def test_failed_build
    repo.add_failing_commit

    commit_id = repo.commits.last["id"]
    buildable = BuilderStub.for(@repo, commit_id)

    buildable.build

    assert_equal :failed,              buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal "This commit will fail", buildable.commit_info["message"]
    assert_equal commit_id,               buildable.commit_info["id"]
    assert buildable.commit_info["timestamp"].is_a?(Time)
  end

  def test_head
    repo.add_failing_commit
    repo.add_successful_commit

    buildable = BuilderStub.for(@repo, "HEAD")

    buildable.build

    assert_equal :successful,          buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal repo.head,            buildable.commit_info["id"]
  end
end
