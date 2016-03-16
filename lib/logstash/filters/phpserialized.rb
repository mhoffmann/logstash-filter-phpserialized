# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "php_serialization"

class LogStash::Filters::PHPSerialized < LogStash::Filters::Base

  config_name "phpserialized"

  # Replace the message with this value.
  config :target, :validate => :string, :default => "message"
  config :source, :validate => :string, :default => "message"


  public
  def register
  end


  public
  def filter(event)

    value = event[@source]
    unless value.empty?
      begin
        data = PhpSerialization.load(value.gsub(/O:8:"stdClass"/, 'O:8:"StdClass"'))
      rescue TypeError, IndexError => err
        @logger.warn("php unserialize failed, ", :err => err, :value => value)
      rescue
        @logger.warn("something went wrong, ", :err => err, :value => value)
      end
      event["[#{@target}]"] = data
    end

    filter_matched(event)
  end
end
