class MobileDevice < ApplicationRecord
  belongs_to :user

  enum platform: [:android, :ios]

  def send_notification(data)
    case platform
    when 'android'
      Notifications::Android.push(data)
    when 'ios'

    end
  end

  def set_answers(answers)
    update!(user_answers: answers)
  end
end
