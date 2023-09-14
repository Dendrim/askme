class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(body: params[:body])
    @related_questions = @hashtag.questions.includes(:user, :author, :hashtags)
  end
end
