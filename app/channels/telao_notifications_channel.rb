class TelaoNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "telao_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
