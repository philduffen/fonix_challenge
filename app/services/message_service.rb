class MessageService
  attr_accessor :phone_number, :message

  def initialize(phone_number, message=nil)
    @phone_number = phone_number
    @message = message || generate_code
  end

  def send_message
    ZensendService.send_sms(@message, prepare_for_sending)
  end

  private

  def valid_number?
    !!(@phone_number =~ /^(?:0|44)(\d+)$/)
  end

  def format_number
    if @phone_number[0] == '0'
      @phone_number.slice!(0)
      @phone_number.prepend('44')
    end
    @phone_number
  end

  def generate_code
    rand.to_s[2..5]
  end

  def prepare_for_sending
    return unless valid_number?
    format_number
  end
end


# phone_number = params[:challenge][:phone_number]
# (redirect_to root_path and return) unless valid_number?(phone_number)
# phone_number = format_number(phone_number)
# code = generate_code
# store_values(phone_number, code)
# ZensendService.send_sms(code, phone_number)