class AnswerMailer < ApplicationMailer

    def hello_world

        # Inside mailer public methods, we typically end
        # the method with a call to `mail`. This will send
        # the mail written here.

        mail(
            to: "erk.balbino@gmail.com",
            subject: "Hello, World!"
        )
    end

    def notify_question_owner(answer)
        @answer = answer
        @question = answer.question
        @question_owner = @question.user

        mail(
            to: @question_owner.email,
            subject: "You got a new answer"
        )

    end
end
