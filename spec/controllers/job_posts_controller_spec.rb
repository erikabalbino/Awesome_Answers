require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do

    let(:current_user) { FactoryBot.create :user }
    # The `let` will create memoized method as shown below:
    # def current_user
    #   @current_user ||= FactoryBot.create :user
    # end
    # Where the first argument will be the named of the method and
    # the return value of the block will be memoized and returned.
    let(:job_post) { FactoryBot.create :job_post }
    let(:current_users_job_post) do 
      FactoryBot.create(:job_post, user: current_user)
    end
  
    describe "#new" do
      context "with no user signed in" do
        it "redirects to the sign in page" do
          get :new
  
          expect(response).to redirect_to new_session_path
        end
  
        it "sets a flash danger message" do
          get :new
  
          expect(flash[:danger]).to be
        end
      end
  
      context "with user signed in" do
        before do
          # To simulate a signed in user, create a user
          # then assign its id to session[:user_id] just
          # like in the SessionsController and the UsersController.
          # Like the flash and the response object, we get access
          # a controller's session in its tests.
          session[:user_id] = current_user.id
        end
  
        it "renders the new template" do
          # Given: defaults
          # When: Making a GET request to the new action
          get(:new)
  
          # Then: We expect that the `response` will have
          # rendered the new template
          expect(response).to render_template(:new)
        end
  
        it "sets an instance variable with a new job post" do
          get :new
  
          # `assigns(:job_post)` will return the value of
          # an instance variable named @job_post from the
          # the JobPostsController if it exists.
          # This method is added by rails-controller-testing gem.
          expect(assigns(:job_post)).to be_a_new(JobPost)
        end
      end
    end
  
    describe "#create" do
      def valid_request
        post :create, params: {
          job_post: FactoryBot.attributes_for(:job_post)
        }
      end
  
      context "with no user signed in" do
        it "redirects to the sign in page" do
          valid_request
  
          expect(response).to redirect_to new_session_path
        end
      end
  
      context "with user signed in" do
        before do
          session[:user_id] = current_user.id
        end
  
        # `context` is a similar to `describe`. In fact, it
        # works exactly the same way. But, we use to convey
        # a different meaning. It this case we're using to
        # group seperate code branches when running the
        # create action.
        context "with valid parameters" do
          it "creates a new job in the db" do
            # Given: An empty database
            count_before = JobPost.count
  
            # When: A valid post is made to create
            valid_request
  
            # Then: There is one more post in the db
            count_after = JobPost.count
            expect(count_after).to eq(count_before + 1)
          end
  
          it "redirects to the show page of that job post" do
            valid_request
  
            expect(response).to redirect_to(job_post_path(JobPost.last))
          end
  
          it "sets a flash success" do
            valid_request
  
            expect(flash[:success]).to be
            # expect(flash[:success]).to_not be
          end
  
          it "associates the job post with the signed in user" do
            valid_request
  
            expect(JobPost.last.user).to eq(current_user)
          end
        end
  
        context "with invalid parameters" do
          def invalid_request
            post :create, params: {
              job_post: FactoryBot.attributes_for(
                :job_post,
                title: nil, min_salary: 10_000
              )
            }
          end
  
          it "doesn't create a job post in the db" do
            count_before = JobPost.count
            invalid_request
            count_after = JobPost.count
  
            expect(count_after).to eq(count_before)
          end
  
          it "renders the new template" do
            invalid_request
            
            expect(response).to render_template(:new)
          end
  
          it "assigns the invalid job post to an instance var." do
            invalid_request
  
            # `be_a(<ruby-class>)` will check if the value passed to `expect`
            # is an instance of the <ruby-class>
            expect(assigns(:job_post)).to be_a(JobPost)
          end
        end
      end
    end
  
    describe "#show" do
      it "renders the show template" do
        jp = FactoryBot.create :job_post
  
        get :show, params: { id: jp.id }
  
        expect(response).to render_template(:show)
      end
  
      it "assigns a record to job post whose id is in the params" do
        jp = FactoryBot.create :job_post
  
        get :show, params: { id: jp.id }
  
        expect(assigns(:job_post)).to eq(jp)
      end
    end
  
    describe "#destroy" do
      def valid_request
        delete :destroy, params: { id: job_post.id }
      end
  
      context "with user not signed-in" do
        it "redirects user to the sign-in page" do
          valid_request
  
          expect(response).to redirect_to new_session_path
        end
      end
  
      context "with user signed-in" do
        before do
          session[:user_id] = current_user.id
        end
  
        context "as owner" do
          def valid_request
            delete :destroy, params: { id: current_users_job_post.id }
          end
  
          before do
            # To make sure that there is already a job post in
            # the database to delete, we'll call the current_users_job_post
            # ahead of time for each of these tests.
            current_users_job_post
          end
  
          it "removes a record from the db" do
            count_before = JobPost.count
            valid_request
  
            count_after = JobPost.count
            expect(count_after).to eq(count_before - 1)
          end
  
          it "redirects to the index page" do
            valid_request
  
            expect(response).to redirect_to job_posts_path
          end
  
          it "assigns a success flash" do
            valid_request
  
            expect(flash[:success]).to be
          end
        end
  
        context "as non-owner" do
          def valid_request
            delete :destroy, params: { id: job_post.id }
          end
  
          before do
            job_post
          end
  
          it "doesn't remove a record from the db" do
            count_before = JobPost.count
  
            valid_request
  
            count_after = JobPost.count
            expect(count_after).to eq(count_before)
          end
  
          it "redirects to the job post" do
            valid_request
  
            expect(response).to redirect_to job_post_path(job_post)
          end
  
          it "assigns a danger flash" do
            valid_request
  
            expect(flash[:danger]).to be
          end
        end
      end
    end
  
    describe "#update" do
      context "without signed-in user" do
        it "redirects to sign-in page" do
          job_post
          patch :update, params: {
            id: job_post.id, job_post: {
              title: "Funky Alchemist"
            }
          }
  
          expect(response).to redirect_to new_session_path
        end
      end
  
      context "with signed-in user" do
        before do
          session[:user_id] = current_user.id
        end
  
        context "as owner" do
          before do
            current_users_job_post
          end
  
          
          context "with valid params" do
            def valid_request
              patch :update, params: {
                id: current_users_job_post.id,
                job_post: {
                  title: "Funky Alchemist",
                  description: current_users_job_post.description,
                  min_salary: current_users_job_post.min_salary
                }
              }
            end
  
            it "persists changes on a job post" do
              before_title = current_users_job_post.title
  
              valid_request
  
              # When the row that an instance of a model refers
              # changes, the instance may not get updated immediately.
              # It will ONLY update, if the instance itself, is response
              # responsible for the changes on the row (i.e. it
              # used the .update method, etc.)
  
              # Use reload on a model instance to re-query the row
              # and mutate the instance with the latest changes.
              current_users_job_post.reload
              after_title = current_users_job_post.title
  
              expect(after_title).to_not eq(before_title)
            end
  
            it "redirects to the job post show page"
          end
  
          context "with invalid params" do
            it "doesn't persist changes on a job post"
            it "renders the edit template"
            it "assigns an invalid job post"
          end
        end
  
        context "as non-owner" do
          it "doesn't persist changes on a job post"
          it "redirects to the job post"
          it "assigns a danger flash"
        end
      end
    end
end
