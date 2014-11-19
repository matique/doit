require 'my'
require 'run'
require 'import'
require 'what'

class Doit

  def self.start(options)
    @options = options
    list  if options[:list]

    script = ARGV.shift
    str = ARGV.map { |x| "\"#{x}\"" }.join(' ')
    @argv = str.empty? ? '' : "set #{str}\n"
    execute(script)  if script
  end

  def self.options
    @options || {}
  end

  def self.list
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

  def self.execute(name)
    Import.init(name)
    unless Import.script
      puts "doit: script '#{name}' not found"
      return
    end
    What.init(Import.script, Import.config)

    where_loop
  end

 private
  def self.where_loop
    What.where.each { |w|
      matrix_loop(w)
    }
  end

  def self.matrix_loop(w)
    What.matrix.each { |mm|
      prefix = mm.empty? ? '' : "#{What.to_env(mm)}\n"

      What.env.each { |en|
	prefix2 = en.empty? ? '' : "#{en}\n"

	cmds = Import.script
	cmds = @argv + prefix + prefix2 + cmds
	Run.init cmds, w
	Run.info  if options[:verbose]
	Run.run
      }
    }
  end

end
