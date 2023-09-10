class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(body: params[:body])
  end
end
