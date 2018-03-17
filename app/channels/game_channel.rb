class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{current_user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
