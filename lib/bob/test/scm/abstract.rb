module Bob::Test
  class AbstractSCMRepo
    attr_reader :path, :name

    def initialize(name, base_dir=Bob.directory)
      @name = name
      @path = base_dir.join(name.to_s)
    end

    def add_commit(message)
      Dir.chdir(path) {
        yield
        commit(message)
      }
    end

    def add_failing_commit
      add_commit("This commit will fail") {
        system "echo '#{build_script(false)}' > test"
        system "chmod +x test"
        add    "test"
      }
    end

    def add_successful_commit
      add_commit("This commit will work") {
        `echo '#{build_script(true)}' > test`
        `chmod +x test`
        add "test"
      }
    end

    def commits
      raise NotImplementedError
    end

    def head
      commits.last["identifier"]
    end

    protected
      def add(file)
        raise NotImplementedError
      end

      def commit(message)
        raise NotImplementedError
      end

      def build_script(successful=true)
        <<SH
#!/bin/sh
echo "Running tests..."
exit #{successful ? 0 : 1}
SH
      end
  end
end
