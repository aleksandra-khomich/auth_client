class SendRequest

  PROTOCOL = 'http'
  HOST_NAME = 'localhost:3000'

  class << self

    def perform(args = {})
      args = options.merge args
      case args[:method]
      when 'get'
        result = HTTParty.get("#{PROTOCOL}://#{HOST_NAME}/#{args[:path]}?#{args[:query]}")
      when 'post'
        result = HTTParty.post("#{PROTOCOL}://#{HOST_NAME}/#{args[:path]}?#{args[:query]}", args[:post_params])
      end
      result
    end

    def options
      {
          method: 'get',
          path: '',
          query: '',
          post_params: {}
      }
    end
  end
end
