class ChallengesController < ApplicationController
  def index
  end

  def mobile_send
    phone_number = params[:challenge][:phone_number]
    (redirect_to root_path and return) unless valid_number?(phone_number)
    phone_number = format_number(phone_number)
    cookies[:phone_number] = phone_number
    code = generate_code
    cookies[:code] = code
    send_sms(code, phone_number)
    redirect_to challenges_code_confirm_path
  end

  def code_confirm
    @phone_number = format_number(cookies[:phone_number])
    @code = cookies[:code]
  end

  def code_check
    code = params[:challenge][:code]
    if code == cookies[:code]
      flash[:notice] = 'Want another go?'
      render(
        html: "Congratulations!<script>alert('Success!')</script>".html_safe,
        application: true
      )
    else
      flash[:notice] = "Try again! #{cookies[:code]}" 
      redirect_to root_path
    end
      cookies.delete :code
      cookies.delete :phone_number
  end

  private

  def generate_code
    # rand.to_s[2..5]
    '1234'
  end

  def valid_number?(phone_number)
    !!(phone_number =~ /^(?:0|44)(\d+)$/)
  end

  def format_number(phone_number)
    if phone_number[0] == '0'
      phone_number.slice!(0)
      phone_number.prepend('44')
    end
    phone_number
  end

  def send_sms(code, number)
    client = ZenSend::Client.new(ENV['ZENSEND_API_KEY'])
    begin
      result = client.send_sms(
        originator: '447434984592',
        originator_type: 'msisdn',
        numbers: [number],
        body: code
      )
      puts result.inspect
    rescue ZenSend::ZenSendException => e
      flash[:warning] = "ZenSendException: #{e.parameter} => #{e.failcode}"
    end
  end

end
