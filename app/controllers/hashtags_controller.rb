class HashtagsController < ApplicationController
  def index
    @hashtag = Hashtag.where(body: params[:search].downcase).first if params[:search].present?
  end
end
