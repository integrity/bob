module Bob
  module Test
    class BuildableStub
      include Bob::Buildable

      def self.for(repo, commit)
        new(repo.scm, repo.uri, repo.branch, commit, repo.command)
      end

      attr_reader :scm, :uri, :branch, :commit, :build_script,
        :repo, :status, :output, :commit_info

      def initialize(scm, uri, branch, commit, build_script)
        @scm = scm.to_s
        @uri = uri.to_s
        @branch = branch
        @commit = commit
        @build_script = build_script

        @status = nil
        @output = ""
        @commit_info = {}
      end

      def finish_building(commit_info, status, output)
        @commit_info = commit_info
        @status = status ? :successful : :failed
        @output = output
      end
    end
  end
end
