class ChallengesController < ApplicationController
  def index
  end

  def mobile_send
    phone_number = params[:challenge][:phone_number]
    cookies[:phone_number] = phone_number
    redirect_to challenges_code_confirm_path
  end

  def code_confirm
    @phone_number = format_number(cookies[:phone_number])
    @code = cookies[:code]
  end

  private

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
end
