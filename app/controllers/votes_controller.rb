class VotesController < ApplicationController

    before_action :authenticate_user!

    def create
        # render json: params
        answer = Answer.find(params[:answer_id])
        vote = answer.votes.build(user: current_user,up: params[:up])

        if vote.save
            flash[:success] = "Vote tallied 🙌"
        else
            flash[:danger] = " You can't vote twice!"
        end

        redirect_to question_path(answer.question)
    end

    def destroy
        vote = Vote.find(params[:id])
        vote.destroy

        flash[:success] = "Vote retracted"
        redirect_to question_path(vote.answer.question)

    end

    def update
        vote = Vote.find(params[:id])
    
        if vote.update(up: params[:up])
          flash[:success] = "Vote changed"
        else
          flash[:danger] = "Vote could not be changed"
        end
    
        redirect_to question_path(vote.answer.question)
    end

end
