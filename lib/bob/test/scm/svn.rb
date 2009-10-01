require File.dirname(__FILE__) + "/abstract"
require "hpricot"

module Bob::Test
  class SvnRepo < AbstractSCMRepo
    def self.server_root
      @root ||= Bob.directory.join("svn")
    end

    attr_reader :remote

    def initialize(name, base_dir=Bob.directory)
      super

      @path   = base_dir.join("svn-#{name}")
      @remote = SvnRepo.server_root.join(name.to_s)
    end

    def create
      create_remote

      `svn checkout file://#{remote} #{path}`

      add_commit("First commit") {
        `echo 'just a test repo' >> README`
        add "README"
      }
    end

    def commits
      Dir.chdir(path) do
        doc = Hpricot::XML(`svn log --xml`)

        (doc/:log/:logentry).inject([]) { |commits, commit|
          commits << { "identifier" => commit["revision"],
            "message"      => commit.at("msg").inner_html,
            "committed_at" => Time.parse(commit.at("date").inner_html) }
        }.reverse
      end
    end

    alias_method :short_head, :head

    protected
      def commit(message)
        `svn commit -m "#{message}"`
        `svn up`
      end

      def add(file)
        `svn add #{file}`
      end

    private
      def create_remote
        SvnRepo.server_root.mkdir

        `svnadmin create #{remote}`

        remote.join("conf", "svnserve.conf").open("w") { |f|
          f.puts "[general]"
          f.puts "anon-access = write"
          f.puts "auth-access = write"
        }
      end
  end
end
