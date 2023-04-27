Run = Object.new
class << Run
  attr_reader :ssh

  def init(cmds, where)
    aster = "*" * 24
    puts "#{aster} #{where} #{aster}"
    @ssh = nil
    @cmds = cmds

    if where.include?("@")
      arr = where.split(":")
      host = arr.first
      dir = (arr.length > 1) ? arr.last : nil
    else
      host = nil
      dir = where
    end

    @cmds = "cd; cd #{dir}\n" + @cmds unless dir&.empty?
    @ssh = "ssh #{host}" if host
  end

  def info
    My.verbose("SSH", @ssh)
    My.verbose("cmds", @cmds)
  end

  def run
    here = "___EOS___"
    silent = Doit.options[:silent] ? ">/dev/null" : ""
    cmd = "cat <<'#{here}' | #{@ssh} bash -i -l #{silent} 2>&1"
    cmds = "#{cmd}\n#{@cmds}#{here}\n"

    if Doit.options[:noop]
      My.verbose("noop", cmds)
    else
      IO.popen(cmds) { |p| p.each { |f| puts f } }
    end
  end
end
