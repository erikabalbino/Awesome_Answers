class Api::V1::AnswersController < Api::ApplicationController
    before_action :authenticate_user!
  
    def destroy
      answer = Answer.find params[:id]
      answer.destroy
  
      render json: { status: 200 }, status: 200
    end
  end