class StaticPagesController < ApplicationController
  before_action { authorize :static_page }
  
  def home    
  end
end
