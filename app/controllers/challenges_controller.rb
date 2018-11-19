class ChallengesController < ApplicationController
  def mobile_send
    msg = MessageService.new(params[:challenge][:phone_number])
    msg.send_message
    session[:code] = msg.message
    redirect_to challenges_code_confirm_path
  rescue StandardError
    redirect_to root_path, error: 'Something went wrong'
  end

  def code_check
    code = params[:challenge][:code]
    if code == session[:code]
      render(
        html: "Congratulations!<script>alert('Success!')</script>".html_safe,
        application: true
      )
    else
      redirect_to root_path, notice: 'Try again!'
    end
  rescue StandardError
    redirect_to root_path, error: 'Something went wrong'
  end
end
