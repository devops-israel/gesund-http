require "net/http"

module Gesund::Checks
  class HttpStatus
    include Gesund::Check
    def initialize(options)
      begin
        url = URI.parse(options[:url])
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) { |http|
          http.request req
        }
        self.success = (res.code == 200)
        self.message = "HTTP GET request to #{url} status is #{res.code}"
      rescue => e
        self.message = "#{e.class}: #{e.message}"
        self.success = false
      end
    end
  end
end
