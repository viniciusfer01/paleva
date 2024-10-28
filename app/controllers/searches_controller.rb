class SearchesController < ApplicationController
  def index
    @query = params[:query]
    @results = SearchService.new(params[:query]).call
    @count = @results[:dishes].size + @results[:beverages].size
  end
end