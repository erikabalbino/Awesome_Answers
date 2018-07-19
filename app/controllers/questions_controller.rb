class QuestionsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @question = Question.new
    end

    def create
        # The `params` object available in controllers
        # is composed of the query string, url params and the
        # body of a form (e.g. req.query + req.params + req.body)

        # A good trick to see if your routes work and you're getting
        # data that you want is rendering the params as JSON. This
        # is like doing res.send(req.body) in Express.

        # render json: params

        @question = Question.new questions_params

        @question.user = current_user

        if @question.save
            # redirect_to home_path
            redirect_to question_path(@question.id)
        else
            # render json: question.errors
            render :new
        end

    end

    def show
        # render json: params

        # @question = Question.find params[:id]

        # render json: @question
        @question.view_count += 1
        @question.save

        @answer = Answer.new
        @answers = @question.answers.order(created_at: :desc)

        # render: show

        @like = @question.likes.find_by(user: current_user)
    end

    def index
        # render json: @questions
        @questions = Question.all.order(created_at: :desc)

        # respond_to do |format|
        #     format.html { render }
        #     format.json { render json: @questions }
        # end

    end

    def edit
        # @question = Question.find params[:id]
    end

    def update
        # @question = Question.find params[:id]
    
        if @question.update(questions_params)
          redirect_to question_path(@question.id)
        else
          render :edit
        end
    end

    def destroy
        # render json: params
        # @question = Question.find params[:id]
        
        @question.destroy
        redirect_to questions_path
    end

    def liked
        @questions = current_user
        .liked_questions
        .order("likes.created_at DESC")
    end

    private
    def find_question
        @question = Question.find params[:id]
    end

    def questions_params
        # Whenever your params contain an array, all the values
        # from the must be permitted as well. To do this,
        # use a key-value argument where the key is the name
        # of the input and the value is an empty array.

        params.require(:question).permit(:title, :body, tag_ids: [])
    end

    def authorize_user!
        
        unless can?(:crud, @question)
            flash[:danger] = "Access Denied"
            redirect_to question_path(@question)
        end
    end

end
