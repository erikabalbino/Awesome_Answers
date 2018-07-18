class AnswersController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize_user!, only: [:destroy]

    def create
        # render json: params
        @question = Question.find params[:question_id]
        @answer = Answer.new answer_params
        @answer.question = @question

        @answer.user = current_user

        if @answer.save
            if @question.user.present?

                # This sends mail synchronously
                # which will block your rails process:
                # AnswerMailer
                #   .notify_question_owner(@answer)
                #   .deliver_now
        
                # This sends mail asynchronously using
                # your ActiveJob setup which will not
                # block the rails process. This is
                # best practice.
                
                AnswerMailer
                  .notify_question_owner(@answer)
                  .deliver_later
                  # .deliver_later(wait: 10.minutes)
                  # .deliver_later(run_at: 1.day.from_now)
                  # `deliver_later` accepts the same arguments
                  # as `set` for ActiveJobs.
            end

            redirect_to question_path(@question)

        else
            @answers = @question.answers.order(created_at: :desc)
            render "questions/show"
        end

    end

    def destroy
        @answer ||= Answer.find params[:id]
        @answer.destroy

        redirect_to question_path(@answer.question)
    end

    private
    def answer_params
      params.require(:answer).permit(:body)
    end

    def authorize_user!
        @answer = Answer.find params[:id]

        unless can?(:crud, @answer)
            flash[:danger] = "Access Denied!"
            redirect_to question_path(@answer.question)
        end
    end
end
