module MessagesHelper
    def recipients_options(chosen_recipient = nil)
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}'>#{user.first_name}</option>"
    end
    s.html_safe
  end
end