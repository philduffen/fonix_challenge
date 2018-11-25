# frozen_string_literal: true

# app/services/zensend_service.rb
module ZensendService
  class << self
    def send_sms(code, number)
      client = ZenSend::Client.new(ENV['ZENSEND_API_KEY'])
      begin
        client.send_sms(
          originator: '447434984592',
          originator_type: 'msisdn',
          numbers: [number],
          body: code
        )
      rescue ZenSend::ZenSendException => e
        puts "ZenSendException: #{e.parameter} => #{e.failcode}"
      end
    end
  end
end
