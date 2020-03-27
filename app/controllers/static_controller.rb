# frozen_string_literal: true

class StaticController < ApplicationController
  skip_before_action :ensure_beta_user, only: %i[beta validate_beta_user]
  def index; end

  def beta
    redirect_to home_path if session[:is_beta_user]
  end

  def validate_beta_user
    if InviteCode.find_by_code(params[:beta_code])
      session[:is_beta_user] = true
      flash[:success] = 'Welcome! Thanks for helping beta test Jam Roulette!'
      redirect_back fallback_location: home_path
    else
      session[:is_beta_user] = false
      flash[:danger] = 'Invalid invite code.'
      redirect_to root_path
    end
  end
end
