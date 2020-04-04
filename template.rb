require "pathname"

class ::RailsTemplate < Thor::Group
  include Thor::Actions
  include Rails::Generators::Actions
  
  attr_accessor :options

  def self.source_root
    File.join(__dir__, "templates")
  end
  
  def
    say("this should work now #{options}")
  end
end

def check_or_die!(config_name, expected, message)
  return if options[config_name] == expected
  $stderr << "\n=> ERROR: #{message}\n"
  exit 1
end

check_or_die! "database", "postgresql, "You must choose postgres as your database with this template"
check_or_die! "skip_javascript", true, "Please provide --skip-javascript (this template uses webpack to handle assets)"
check_or_die! "skip_sprockets", true, "Please provide --skip-sprockets (this template uses webpack to handle assets)"

generator = ::RailsTemplate.new
generator.shell = shell
generator.options = options.merge(app_name: app_name, rails_generator: self)
generator.destination_root = Dir.pwd
generator.invoke_all
