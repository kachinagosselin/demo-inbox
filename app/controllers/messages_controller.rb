class MessagesController < ApplicationController
  before_action :set_user #, only: [:index, :create, :show, :edit, :update, :destroy]

	def index
		@messages = Message.where("sender_id = ? OR recipient_id = ?", @user.id, @user.id)
		recipient_ids = @messages.unscoped.where.not(:recipient_id=>@user.id).pluck('DISTINCT recipient_id')
		recipient_ids = @messages.unscoped.where.not(:recipient_id=>@user.id).pluck('DISTINCT recipient_id')
		@message_threads = []
		recipient_ids.each do |id|
			@message_threads << @messages.where(recipient_id: id).last
		end
		#@messages=@messages.select(:recipient_id).map(&:recipient_id).uniq
		@message = Message.new
	end

	def show
		@message = Message.find(params[:id])
		@recipient = User.find(@message.recipient_id)
		@messages = Message.where("sender_id = ?  OR recipient_id = ?", @user.id, @user.id).where("sender_id = ?  OR recipient_id = ?", @recipient.id, @recipient.id)
	end

	def new
	end

	def create
		@message = Message.new(message_params)
		@recipient_id = 2
		@message.update_attributes(title: "Default Title", sender_id: current_user.id, status: 'unread', recipient_id: @recipient_id)
		@message.send

		respond_to do |format|
			if @message.save
				format.html { redirect_to messages_path(), notice: 'Message was successfully created.' }
				format.json { head :no_content }
			else
				format.html { render :action => 'new', alert: 'Message was unsuccessfully created.' }
				format.json { render json: @message.errors, status: :unprocessable_entity }
			end 
		end
	end

	def edit
	end

	def update
	end

	def archive
	end

	def destroy
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content)
    end

end