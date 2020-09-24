class WelcomeController < ApplicationController

  def index
    #render layout: 'student'
    render file: "#{Rails.root}/public/landing.html"
  end

  def services
    render layout: 'student'
  end

  def actualites
    render layout: 'student'
  end

  def shares
      counter = 1
      cookies.permanent.signed[:browser_id_we_share]   = "Horst Meier"
      cookies[:brower_ip_we_share] = request.remote_ip
      cookies[:browser_session_count] = counter
      @documents = Document.last.file
    render layout: 'share'
  end

  def file
    current_file = params[:blob_id]
    current_ip = params[:client_ip]
    @file = Document.find(401).file.find_by_blob_id(651)
    render layout: 'share'
  end

  def confirm_user_email_ip
    if request.post?
      # merci de rentrer votre adresse email pour confirmer que vous n'etes pas un robot

      current_ip = request.remote_ip
      current_email = params[:email]
      current_file = params[:blob_id]

      # verify in db
      @current_user = Share.find_by(email: current_email)
      if @current_user
        cookies.permanent.signed[:browser_id_we_share] == "MPPP User validated"

        # update user data
        # if @current_user.update(ip: request.remote_ip, last_session: DateTime.now, token: SecureRandom.hex(12), counter: @current_user.increment!(:counter))
        #   redirect_to max_share_reached_path(token: @current_user.token, blob_id: current_file), notice: "Vous ne devez que recevoir une copie de ce manuel de jeûne. Merci de contacter l'homme de Dieu pour beneficier d'autres copies à sunsightsee@yahoo.fr (Ministè"
        #   return
        # else
        #   puts "Une erreur est survenue : #{@current_user}"
        # end
        redirect_to max_share_reached_path, notice: "Il se peut que vous avez atteint la limite d'un copie de ce document telle que défini par l'administrateur"
      else
        @share = Share.new(email: current_email, ip: request.remote_ip, last_session: DateTime.now, token: SecureRandom.hex(12), counter: 1)
        if @share.save
          redirect_to file_share_detail_path(token: @share.token, blob_id: current_file), notice: "Vous disposez de 5 minutes"
          return
        else
          puts "Une erreur est survenue : #{@current_user}"
        end

      end
    elsif request.get?

    end
    render layout: 'share'
  end

  def max_share_reached

  end

end
