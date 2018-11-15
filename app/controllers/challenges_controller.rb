class ChallengesController < ApplicationController
  def mobile_send
    msg = MessageService.new(params[:challenge][:phone_number])
    msg.send_message
    cookies[:code] = msg.message
    redirect_to challenges_code_confirm_path
  rescue StandardError
    redirect_to root_path, error: 'Something went wrong'
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
  rescue StandardError
    redirect_to root_path, error: 'Something went wrong'
  end
end
