require "bob/scm/abstract"

module Bob
  module SCM
    autoload :Git, "bob/scm/git"
    autoload :Svn, "bob/scm/svn"

    class Error < StandardError; end

    # Factory to return appropriate SCM instances (according to repository kind)
    def self.new(scm, uri, branch)
      const_get(scm.to_s.capitalize).new(uri, branch)
    end
  end
end
