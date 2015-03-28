module Fit
  class File
    # A fit timestamp is a uint32_t that is seconds since UTC 00:00 Dec 31 1989.
    # Thus to convert the timestamp to be read as a UNIX timestamp we need add
    # the Epoch timestamp for UTC 00:00 Dec 31 1989.
    TIMESTAMP_CONVERSION = 631065600

    def self.read(io)
      new.read(io)
    end

    attr_reader :header, :records, :crc

    def initialize
      @records = []
    end

    def read(io)
      @header = Header.read(io)

      Record.clear_definitions!

      while io.pos < @header.end_pos
        @records << Record.read(io)
      end

      @crc = io.read(2)

      self
    end

    def all_records
      records.select{ |r| r.content.record_type != :definition }.map{ |r| r.content }
    end

    def activity_timestamps
      all_records.map { |r| DateTime.strptime((r[:raw_timestamp].to_i + TIMESTAMP_CONVERSION).to_s, '%s').to_s if r[:raw_timestamp] }.compact
    end

    def activity_total_time
      start_time = nil
      end_time = nil
      all_records.each do |r|
        start_time = r[:raw_timestamp].to_i + TIMESTAMP_CONVERSION if r[:raw_timestamp] && start_time.nil?
        end_time = r[:raw_timestamp].to_i + TIMESTAMP_CONVERSION if r[:raw_timestamp]
      end
      Time.at(end_time - start_time).utc.strftime("%H:%M:%S")
    end

    def activity_total_active_time
      start_time = nil
      end_time = nil
      times = []
      all_records.each do |r|
        puts r[:raw_timestamp]
        if r[:raw_timestamp].nil?
          if start_time && end_time
            times << end_time - start_time
            start_time = nil
            end_time = nil
          else
            start_time = nil
            end_time = nil
          end
        else
          start_time = r[:raw_timestamp].to_i + TIMESTAMP_CONVERSION if start_time.nil?
          end_time = r[:raw_timestamp].to_i + TIMESTAMP_CONVERSION
        end
      end
      Time.at(times.inject { |sum, t| sum + t }).utc.strftime("%H:%M:%S")
    end

  end
end
