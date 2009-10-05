module ScmTest
  include Bob::Test

  def test_successful_build
    repo.add_successful_commit

    commit_id = repo.commits.last["identifier"]

    buildable = BuilderStub.for(@repo, commit_id)
    buildable.build

    assert_equal :successful,          buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal "This commit will work", buildable.commit_info["message"]
    assert_equal commit_id,               buildable.commit_info["identifier"]
    assert buildable.commit_info["committed_at"].is_a?(Time)
  end

  def test_failed_build
    repo.add_failing_commit

    commit_id = repo.commits.last["identifier"]
    buildable = BuilderStub.for(@repo, commit_id)

    buildable.build

    assert_equal :failed,              buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal "This commit will fail", buildable.commit_info["message"]
    assert_equal commit_id,               buildable.commit_info["identifier"]
    assert buildable.commit_info["committed_at"].is_a?(Time)
  end

  def test_head
    repo.add_failing_commit
    repo.add_successful_commit

    buildable = BuilderStub.for(@repo, :head)

    buildable.build

    assert_equal :successful,          buildable.status
    assert_equal "Running tests...\n", buildable.output
    assert_equal repo.head,            buildable.commit_info["identifier"]
  end
end
