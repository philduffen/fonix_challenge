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

  def format_number(number)
  	cookies[:phone_number]
  end

end
