class CookbookController < ApplicationController

  before_action :set_user

  def return_user()
    # redirect_to "http://localhost:4200/" if current_user.nil?
    puts @user.nil?
    render json: @user
  end

  private

  def set_user
    @user = current_user

  end


end
