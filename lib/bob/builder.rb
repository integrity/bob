module Bob
  # A Builder will take care of building a buildable (wow, you didn't see
  # that coming, right?).
  class Builder
    attr_reader :buildable

    # Instantiate the Builder, passing an object that understands
    # the <tt>Buildable</tt> interface.
    def initialize(buildable)
      @buildable = buildable
    end

    # This is where the magic happens:
    #
    # 1. Notify the buildable that the build is starting.
    # 2. Check out the repo to the appropriate commit.
    # 3. Run the build script on it.
    # 4. Reports the build back to the buildable.
    def build
      scm.with_commit(buildable["commit"]) { |commit|
        started(scm.info(commit))
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
