class NewslettersController < ApplicationController
  before_action :require_login
  before_action :check_if_carson

  def index
    @newsletters = Newsletter.all
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def new
    @newsletter = Newsletter.new
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      redirect_to newsletters_path
    else
      render :edit
    end 
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      redirect_to newsletters_path
    else
      render :new
    end 
  end

  def destroy
  end

  def newsletter_params
    params.require(:newsletter).permit(:subject, :content)
  end

  def check_if_carson
    redirect_to :root unless current_user.email = 'carson.cole@protonmail.com'
  end
end
