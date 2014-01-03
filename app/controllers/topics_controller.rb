class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "发帖成功"
      redirect_to topics_url
    else
      render 'new'
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :body)
    end
end
