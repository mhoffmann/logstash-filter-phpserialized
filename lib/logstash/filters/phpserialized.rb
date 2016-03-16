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
        event["[#{@target}]"] = data
      rescue
        @logger.warn("phpunserialized failed to unserialize")
      end
    end

    filter_matched(event)
  end
end
