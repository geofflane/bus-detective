require 'uri'

module Metro
  class Connection
    include Skylight::Helpers

    instrument_method title: 'get data'
    def self.get(url)
      uri = if url.is_a? URI
              url
            else
              URI(url)
            end

      HTTP.timeout(:global, :write => 2, :connect => 2, :read => 4)
        .get(uri).to_s
    rescue HTTP::Error, IOError, Errno::EINVAL, Errno::ECONNRESET
      raise Metro::Error.new("Failed to get data from: #{uri}")
    end
  end
end
