class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.where(user_id: current_user.id)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    begin

      opentok = OpenTok::OpenTok.new "47009224", '6f69d24bc9a24359038b2af9323f7a80cb3739ae', :timeout_length => 30
      #token = "T1==cGFydG5lcl9pZD00NzAwOTIyNCZzaWc9NmZjOGE4MzQyMDY1MzQ2ZTBjNmJlZjU0YmNhY2NmNWViYTQ1MWI1YTpzZXNzaW9uX2lkPTJfTVg0ME56QXdPVEl5Tkg1LU1UWXdOalk0T1RRMU5ETTNObjVpVlRadmFITlJaakpPVFZaeU1uRkdRakZQUmtKQmRuVi1RWDQmY3JlYXRlX3RpbWU9MTYwNjY4OTg0MSZub25jZT0wLjc1NjA3MjY0NDQyMDQ4ODImcm9sZT1tb2RlcmF0b3ImZXhwaXJlX3RpbWU9MTYwNzI5NDY0MSZpbml0aWFsX2xheW91dF9jbGFzc19saXN0PQ=="
      @token = opentok.generate_token @room.vonage_session_id, { name: user_signed_in? ? current_user.name : current_student.name } # create_session #:archive_mode => :always, :media_mode => :routed

    rescue StandardError => e

      flash[:notice] = "Une erreur est survenue : #{e.message}"

    end


    # @chats = Rails.cache.read(:chats) || []
    # @chats.shift while @chats.size > 50
    # Rails.cache.write :chats, @chats

    #@token = opentok.generate_token @session_id, { name: user_signed_in? ? current_user.name : current_student.name }
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :vonage_session_id, :user_id, :salle_de_class_id, :filiere_id)
    end
end
