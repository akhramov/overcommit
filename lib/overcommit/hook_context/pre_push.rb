module Overcommit::HookContext
  # Contains helpers related to contextual information used by pre-push hooks.
  class PrePush < Base
    attr_accessor :args

    def remote_name
      @args[0]
    end

    def remote_url
      @args[1]
    end

    def pushed_commits
      input_lines.map do |line|
        PushedCommit.new(*line.split(' '))
      end
    end

    private

    def input_lines
      @input_lines ||= ARGF.read.split("\n")
    end

    PushedCommit = Struct.new(:local_ref, :local_sha1, :remote_ref, :remote_sha1) do
      def to_s
        "#{local_ref} #{local_sha1} #{remote_ref} #{remote_sha1}"
      end
    end
  end
end
