class StaticpagesController < ApplicationController
  skip_before_action :require_login, only: %i[top policy term]
  def top; end
  def policy; end
  def term; end
end
