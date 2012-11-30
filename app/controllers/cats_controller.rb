class CatsController < ApplicationController
  respond_to :html, :xml, :json, :js
  
  def index
    # @cats = Cat.paginate(page: params[:page], per_page: 25)
    # respond_with(@cats)
  end
end
