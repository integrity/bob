module Bob
  class Builder
    attr_reader :buildable

    def initialize(buildable)
      @buildable = buildable
    end

    def build
      scm.with_commit(buildable["commit"]) { |commit|
        started(scm.metadata(commit))
        completed(*run)
      }
    end

    protected
      def started(commit_info)
      end

      def completed(status, output)
      end

    private
      def run
        output = ""
        status = false

        IO.popen(script, "r") { |io| output = io.read }
        status = $?.success?

        [status, output]
      end

      def script
        "(cd #{scm.dir_for(buildable["commit"])} && #{buildable["command"]} 2>&1)"
      end

      def scm
        @scm ||= SCM.new(buildable["scm"], buildable["uri"], buildable["branch"])
      end
  end
end
