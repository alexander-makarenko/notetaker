class StaticPagesController < ApplicationController
  before_action { authorize :static_page }
  
  def home
    redirect_to notes_path if signed_in?
  end
end
