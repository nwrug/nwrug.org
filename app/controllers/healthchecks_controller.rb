class HealthchecksController < ApplicationController
  def show
    render plain: "OK"
  end
end
