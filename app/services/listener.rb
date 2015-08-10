class Listener
  class << self
    def connection
      @connection ||= Bunny.new.tap do |c|
        c.start
      end
    end

    def channel
      @channel ||= connection.create_channel
    end

    def exchange
      @exchange ||= channel.fanout("user.changed")
    end

    def queue
      @queue ||= channel.queue("users", durable: true)
    end

    def listen
      puts "Listening..."
      begin
        queue.bind(exchange).subscribe(block: true, manual_ack: true) do |delivery_info, properties, body|
          puts "Received #{body}!"
          result = process_message(body)
          channel.ack(delivery_info.delivery_tag) if result.is_a? TrueClass
        end
      rescue Interrupt => _
        channel.close
        connection.close
      end
    end

    def process_message(uid)
      User.create_or_update(uid)
    end
  end
end

