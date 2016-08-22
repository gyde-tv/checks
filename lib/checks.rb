require 'checks/version'
require 'singleton'
require 'net/http'

class Checks

  include Singleton

  attr_accessor :config_path

  class << self
    def manual_checkin(*args); instance.manual_checkin(*args); end
    def checkin(*args); instance.checkin(*args); end
    def checkin!(*args); instance.checkin!(*args); end
  end

  def initialize
    self.config_path = defined?(Rails) ? Rails.root.join('config/checks.yml').to_s : 'config/checks.yml'
  end

  def config_path=(value)
    @config_path = value
    reload!
  end

  def config
    @config ||= begin
      path = config_path.to_s
      return {} unless ::File.exist?(path)
      YAML.load_file(path).fetch('checks')
    end
  end

  def reload!
    @config = nil
    config
  end

  def checkin(*check)
    path = path_for *check
    invoke "http://hchk.io/#{path}" if path
  end

  def checkin!(*check)
    path = path_for *check
    raise ArgumentError.new("unknown check #{check.join(".")}") unless path
    invoke "http://hchk.io/#{path}"
  end

  def manual_checkin(path)
    invoke "http://hchk.io/#{path}"
  end

  private

  def invoke(url)
    uri = URI.parse url
    Net::HTTP.post_form(uri, {})
  end

  def path_for(*check)
    return unless check.any?
    base = config
    check.each do |path|
      return nil unless base.is_a?(Hash)
      base = base[path.to_s]
    end
    base
  end

end
