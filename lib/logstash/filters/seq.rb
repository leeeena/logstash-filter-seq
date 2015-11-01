# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "set"
#
# This filter will adds a sequence number to a log entry
#
# The config looks like this:
#
#     filter {
#       seq {
#         field => "seq"
#       }
#     }
#
# The `field` is the field you want added to the event.
class LogStash::Filters::Seq < LogStash::Filters::Base

  config_name "seq"
  milestone 1

  config :field, :validate => :string, :required => false, :default => "seq"

  public
  def register
    # Nothing
  end # def register

  public
  def initialize(config = {})
    super

    @threadsafe = false

    # This filter needs to keep state.
    @seq=1
  end # def initialize

  public
  def filter(event)
    return unless filter?(event)
    event[@field] = @seq
    @seq = @seq + 1
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Seq