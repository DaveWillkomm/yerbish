require 'erb'
require 'json'
require 'yaml'
require 'yerb/version'

module Yerb
  FILE_EXTENSION = '.yml.erb'

  attr_accessor :base_path

  def create_binding(base_path, local_variables = {})
    b = TOPLEVEL_BINDING.dup
    b.eval 'include Yerb'
    local_variables.each { |k,v| b.local_variable_set k, v }
    b.eval "self.base_path = '#{base_path}'"
    b
  end

  # Interprets the specified file's embedded Ruby, parsing the result as YAML and returning the resulting data
  # structure.
  def load(file_path, local_variables = {})
    yaml = render file_path, local_variables
    YAML.load yaml
  end

  # Interprets the specified file's embedded Ruby and returns the resulting (YAML) string.
  def render(file_path, local_variables = {})
    absolute_path = File.expand_path file_path, base_path
    absolute_path += FILE_EXTENSION unless absolute_path.end_with?(FILE_EXTENSION)
    directory = File.dirname absolute_path
    file_content = File.read absolute_path
    erb = ERB.new file_content
    erb.result create_binding(directory, local_variables)
  end

  # Interprets the specified file's embedded Ruby, parsing the result as YAML and returning it formatted as JSON.
  def render_json(file_path, local_variables = {})
    object = load file_path, local_variables
    JSON.pretty_generate object
  end

  module_function(
    :base_path,
    :base_path=,
    :create_binding,
    :load,
    :render,
    :render_json,
  )
end
