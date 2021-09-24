class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    stop_stream_from "room_channel_#{params[:room_id]}"
  end

end