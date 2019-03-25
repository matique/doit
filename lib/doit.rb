# rubocop: disable all

require 'my'
require 'run'
require 'import'

Doit = Object.new
class << Doit

  def start(options)
    @options = options
    list  if options[:list]

    script = ARGV.shift
    str = ARGV.map { |x| "\"#{x}\"" }.join(' ')
    @argv = str.empty? ? '' : "set #{str}\n"
    execute(script)  if script
  end

  def options
    @options ||= {}
    @options
  end

  def list
    hsh = Import.list
    hsh.sort.each { |abb, long|
      puts "#{abb}\t- #{long}"
      next  unless options[:verbose]

      lines = `grep -i 'usage\\|summary' #{long} | grep '^#'`.split("\n")
      lines.each { |line|
	next  unless line
	next  if line.empty?

	puts "\t  #{line}"
      }
    }
  end

  def execute(name)
    Import.init(name)
    unless Import.script
      puts "doit: script '#{name}' not found"
      return
    end
    What.init(Import.config)

    What.where.each { |w| puts "doit #{name} -r #{w}" } if options[:each]

    where_loop  unless options[:each]
  end

 private
  def where_loop
    What.where.each { |w|
      matrix_loop(w)
    }
  end

  def matrix_loop(where)
    What.matrix.each { |mm|
      prefix = mm.empty? ? '' : "#{What.to_env(mm)}\n"

      What.env.each { |en|
        prefix2 = en.empty? ? '' : "#{en}\n"

        cmds = Import.script
        cmds = @argv + prefix + prefix2 + cmds
        Run.init cmds, where
        Run.info  if options[:verbose]
        Run.run
      }
    }
  end

end
