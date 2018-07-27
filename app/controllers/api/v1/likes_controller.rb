class Api::V1::LikesController < Api::ApplicationController
    before_action :authenticate_user!
  
    def create
      question = Question.find params[:question_id]
      like = Like.new user: current_user, question: question
      like.save
  
      render json: { id: like.id, like_count: question.likes.count }
    end
  
    def destroy
      like = Like.find params[:id]
      like.destroy
  
      render json: { id: like.id, like_count: like.question.likes.count }
    end
  
end