class RoomsController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_room, except: [:new, :create, :messenger_sidebar]
  before_action :set_username

  def new
    @room = Room.new
  end

  def edit
  end

  def show
    if !session[:current_user]
      cable_ready["unknown_users"].inner_html(
        html:           "Enter a screen name to continue",  # [null]   - the HTML to assign
        selector:       "#modalText",  # required - string containing a CSS selector or XPath expression
      )
    end
    @messages = @room.messages.order("created_at ASC").limit(5)
  end

  def create
    session[:current_user] = params[:room][:name]
    @room = Room.new(name: "#{session[:current_user]}#{rand(100)}")
    if @room.save
      redirect_to @room
    end
  end

  def destroy
    @room.destroy
    redirect_to root_path
  end

  def update
    @room.update(room_params)
    redirect_to signed_in_home_path
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

end
