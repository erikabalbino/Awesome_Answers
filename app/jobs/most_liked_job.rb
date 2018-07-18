class MostLikedJob < ApplicationJob
  queue_as :default

  # Use jobs to run code when:
  # - The run code that takes a long time
  #   execute (30s to hours to days).
  # - To run code at set time in the future or
  #   at intervals (every week, every other day, etc)

  # To generate a job use the command:
  # `rails g job <job-name>`

  # When a job is run, its `perform` will be called.

  # Create a job class for any task that you need to
  # do asynchronously.

  # You can run a job synchronously using the method
  # `perform_now` on the class. You can give it arguments
  # that will be passed to the `perform` method.
  # Example:
  # MostLikedJob.perform_now

  # To the start the work program will run jobs
  # from the `delayed_jobs` table in your database
  # run the following in a seperate terminal
  # tab or window:
  # `rails jobs:work`

  # To put a job on the `delayed_jobs` queue, use
  # `perform_later` instead of `perform_now`.
  # Example:
  # MostLikedJob.perform_later

  # The job above will only run if there's a worker
  # currently running.

  # To run a job with a delay:

  # The "wait" argument takes an interval of time
  # `MostLikedJob.set(wait: 10.minutes).perform_later`

  # The "run_at" argument takes a date.
  # `MostLikedJob.set(run_at: 1.day.from_now).perform_later`

  # To pass arguments to a job, pass them to the
  # `perform_later` or `perform_now` methods:
  # `MostLikedJob.set(wait: 1.day).perform_later([1,2,3])`
  # `MostLikedJob.perform_now("My Argument")`

  #  To read more about ActiveJob:
  #  http://guides.rubyonrails.org/active_job_basics.html

  def perform(*args)
    puts "----------------"
    puts "Running a job... ✌️ "
    puts "----------------"
  end
end
