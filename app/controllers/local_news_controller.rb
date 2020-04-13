class LocalNewsController < ApplicationController
  before_action :set_local_news, only: [:show, :edit, :update, :destroy]

  # GET /local_news
  # GET /local_news.json
  def index
    @local_news = LocalNews.all
  end

  # GET /local_news/1
  # GET /local_news/1.json
  def show
  end

  # GET /local_news/new
  def new
    @local_news = LocalNews.new
  end

  # GET /local_news/1/edit
  def edit
  end

  # POST /local_news
  # POST /local_news.json
  def create
    @local_news = LocalNews.new(local_news_params)

    respond_to do |format|
      if @local_news.save
        format.html { redirect_to @local_news, notice: 'Local news was successfully created.' }
        format.json { render :show, status: :created, location: @local_news }
      else
        format.html { render :new }
        format.json { render json: @local_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /local_news/1
  # PATCH/PUT /local_news/1.json
  def update
    respond_to do |format|
      if @local_news.update(local_news_params)
        format.html { redirect_to @local_news, notice: 'Local news was successfully updated.' }
        format.json { render :show, status: :ok, location: @local_news }
      else
        format.html { render :edit }
        format.json { render json: @local_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /local_news/1
  # DELETE /local_news/1.json
  def destroy
    @local_news.destroy
    respond_to do |format|
      format.html { redirect_to local_news_index_url, notice: 'Local news was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local_news
      @local_news = LocalNews.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def local_news_params
      params.require(:local_news).permit(:title, :extrait, :statut)
    end
end
