#app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  authorize_resource class: false

  def index
  end

  def long
  end
end
