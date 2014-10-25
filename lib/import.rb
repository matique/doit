require 'pathname'
require 'erb'

class Import

  def self.script;  @script;  end
  def self.config;  @config;  end

  def self.init(name)
    @script  = read(name)
    @config  = ERB.new(read("#{name}.yml") || '').result
    info
  end

# returns Hash { 'pull' => '/home/dk/.doit/pull', ... }
  def self.list
    @list ||= list2
  end

  def self.info
    return  unless Doit.options[:verbose]

    My.verbose "SCRIPT", @script
    My.verbose "CONFIG(yml)", @config
  end


 private
  def self.list2
    res = {}
    Pathname.pwd.descend { |dir|
      doit_dir = dir + '.doit'
      next  unless File.directory?(doit_dir)

      lst = []
      Dir.entries(doit_dir).each { |name|
	name = File.join(doit_dir, name)

	next  unless File.executable?(name)
	next  if     File.directory?(name)

	lst << name
      }
      lst.each { |itm|  res[File.basename(itm)] = itm }
    }
    res
  end

  def self.read(name)
    try_ascend(".doit/#{name}")
  end

  def self.try_ascend(filename)
    Pathname.pwd.ascend { |dir|
      str = dir + filename
      return File.read(str)  if File.exists?(str)
    }
    nil
  end

end
