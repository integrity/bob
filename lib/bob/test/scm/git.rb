require File.dirname(__FILE__) + "/abstract"

module Bob::Test
  class GitRepo < AbstractSCMRepo
    def create
      FileUtils.mkdir(path)

      Dir.chdir(path) {
        `git init`
        `git config user.name 'John Doe'`
        `git config user.email 'johndoe@example.org'`
      }

      add_commit("First commit") {
        `echo 'just a test repo' >> README`
        add "README"
      }
    end

    def commits
      Dir.chdir(path) {
        `git log --pretty=oneline`.collect { |l| l.split(" ").first }.
        inject([]) { |ary, sha1|
          format  = "---%nmessage: >-%n  %s%ntimestamp: %ci%n" +
            "identifier: %H%nauthor: %n name: %an%n email: %ae%n"
          ary << YAML.load(`git show -s --pretty=format:"#{format}" #{sha1}`)
        }.reverse
      }
    end

    def head
      Dir.chdir(path) { `git log --pretty=format:%H | head -1`.chomp }
    end

    def short_head
      head[0..6]
    end

    protected
      def add(file)
        `git add #{file}`
      end

      def commit(message)
        `git commit -m "#{message}"`
      end
  end
end
