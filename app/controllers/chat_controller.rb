class ChatController < ApplicationController

    def index
		@title = 'Chat'
		@room_id = params[:room]
		@receiver_id = params[:receiver]
	end

	def get_user
		render json: User.where('id != ?', current_user.id)
	end

	def get_chat
		@receiver = params[:user_id]
		@sender = current_user.id

		# List room sender receiver
		@receiver_rooms = Participant.where(user_id: @receiver)
		@sender_rooms = Participant.where(user_id: @sender)

		# Check isset rooms
		@status = 0
		@room = 0

		@receiver_rooms.each do |r|
			@sender_rooms.each do |s|
				if r.room_id == s.room_id
					@status = 1
					@room = Room.find(s.room_id)
				end
			end
		end

		# If room exist
		if @status == 0
			@room = store(Room, {:name => SecureRandom.base36, :tipe => 'Private'})
			@participant1 = store(Participant, {:user_id => @sender, :room_id => @room.id})
			@participant2 = store(Participant, {:user_id => @receiver, :room_id => @room.id})
		end

		# Get chat
		@chat = Message.joins(:sender, :receiver, :room).where('room_id', @room.id)
		
		render json: {chat: @chat, room: @room} 
	end

	def send_message
		exe = store(Message, chat_params)
		
		if exe
			ActionCable.server.broadcast("room_channel_#{chat_params[:room_id]}", chat_params)

			render json: exe, status: :created
		else
			render json: exe.errors, status: :unproccessable_entity
		end
	end

	private
	def chat_params
		params.require(:data).permit(:message, :receiver_id, :sender_id, :room_id)
	end
end
