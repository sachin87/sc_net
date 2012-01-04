class Message < ActionMailer::Base
  default from: "from@example.com"

  def send_message(phone_number,carrier,message,options={})
    @recipient = phone_number
    @carrier = carrier
    @message = message
  end

end
