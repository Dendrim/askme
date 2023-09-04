class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(body: params[:id])
  end
end
