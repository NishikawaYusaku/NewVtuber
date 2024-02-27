class PagesController < ApplicationController
  skip_before_action :require_login
  
  def about; end

  def terms; end

  def privacy_policy; end
  
end
