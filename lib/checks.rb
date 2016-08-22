require "checks/version"
require 'singleton'
require 'net/http'

class Checks

  include Singleton

  class << self
    delegate :manual_checkin, :checkin, :checkin!, to: :instance
  end

  def config
    @config ||= begin
      path = Rails.root.join('config/checks.yml').to_s
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
