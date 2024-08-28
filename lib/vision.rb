require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def image_analysis(image_file)
      response = send_request(image_file)
      result = parse_response(response)
      handle_errors(result)
      safe_search_results(result)
    end

    private

    def send_request(image_file)
      uri = URI.parse(api_url)
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      request.body = build_request_body(image_file)

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.request(request)
    end

    def api_url
      "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"
    end

    def build_request_body(image_file)
      base64_image = Base64.encode64(image_file.tempfile.read)
      {
        requests: [{
          image: { content: base64_image },
          features: [{ type: 'SAFE_SEARCH_DETECTION' }]
        }]
      }.to_json
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def handle_errors(result)
      error = result.dig('responses', 0, 'error')
      raise error['message'] if error.present?
    end

    def safe_search_results(result)
      result_arr = result.dig('responses', 0, 'safeSearchAnnotation').values
      !(result_arr.include?('VERY_LIKELY') || result_arr.include?('LIKELY'))
    end
  end
end
