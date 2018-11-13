class ChallengesController < ApplicationController
  def index
  end

  def mobile_send
    phone_number = params[:challenge][:phone_number]
    (redirect_to root_path and return) unless valid_number?(phone_number)
    cookies[:phone_number] = phone_number
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
        html: "Contratulations!<script>alert('Success!')</script>".html_safe,
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
