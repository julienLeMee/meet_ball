class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.last
    @message = Message.new
  end
end
