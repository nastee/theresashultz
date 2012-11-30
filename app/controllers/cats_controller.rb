class CatsController < ApplicationController
  respond_to :html, :js, :json, :xml
  
  def index
    @cats = Cat.paginate(page: params[:page], per_page: 10)
    respond_with(@cats)
  end
end
