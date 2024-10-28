class SearchesController < ApplicationController
  before_action :authenticate_user!
  def index
    @query = params[:query]
    @results = SearchService.new(@query, current_user).call
    @count = @results[:dishes].size + @results[:beverages].size
  end
end