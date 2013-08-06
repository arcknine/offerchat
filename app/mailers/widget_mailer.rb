class WidgetMailer < ActionMailer::Base

  def offline_form(to, name, from, message)
    @data = {:full_name => name, :from => from, :message => message }
    mail(:to => to, :subject => "Offerchat Offline Form")
  end

  def post_chat_form(to, name, from, message)
    @data = {:full_name => name, :from => from, :message => message }
    mail(:to => to, :subject => "Offerchat Post Chat Form")
  end
end
