class HomeController < ApplicationController
  def index
    @candidate = Candidate.new
  end
end
