# rubocop: disable all

require 'yaml'
require 'doit'

What = Object.new
class << What

  attr_reader :matrix
  attr_reader :where
  attr_reader :env

  def init(config)
    @matrix = nil
    @yml   = (config && YAML.load(config)) || {}

    @where = @yml.delete('where')
    @env   = @yml.delete('env')
    @env ||= ['']
    @env   = [@env].flatten.compact

    remote = Doit.options[:remote]
    @where   = remote  if remote && remote != '---'
    @where ||= Dir.pwd   # default is current directory
    @where   = [@where].flatten.compact

    build_matrix
    @matrix ||= []
    @matrix = [@matrix]  unless @matrix.first.is_a?(Array)
    @matrix.map! { |m| m.flatten.inject({}) { |hsh, h| hsh.merge(h) } }
    info
  end

  def to_env(hsh)
    arr = hsh.collect { |key, value| "#{key.to_s.upcase}=#{value}" }
    arr.join ' '
  end

  def info
    return  unless Doit.options[:verbose]

    My.verbose 'where',  @where
    My.verbose 'matrix', @matrix
    My.verbose 'env',    @env
  end

 private
  def build_matrix
    return  if @yml.empty?

    key, value = @yml.first
    @yml.delete(key)
    add_to_matrix(key, value)
    build_matrix
  end

  def add_to_matrix(key, val)
    arr = val.is_a?(Array) ?
      val.collect { |v| [{ key => v }] } :
      [{ key => val }]
    @matrix = @matrix ? @matrix.product(arr) : arr
  end

end
