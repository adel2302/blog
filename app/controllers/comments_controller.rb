class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @comments = Comment.page(params[:page]).per(5).tagged_with(params[:tag])
    else
      @comments = Comment.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to action: :index, notice: 'Comment was successfully created.' }
        format.json { render :index, status: :created, location: @comments }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :content, :author, :tag_list)
    end
end
