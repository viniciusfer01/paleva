class SearchService
  def initialize(query)
    @query = query
  end

  def call
    {
      dishes: search_dishes,
      beverages: search_beverages
    }
  end

  private

  def search_dishes
    Dish.where('name LIKE ? OR description LIKE ?', "%#{@query}%", "%#{@query}%")
  end

  def search_beverages
    Beverage.where('name LIKE ? OR description LIKE ?', "%#{@query}%", "%#{@query}%")
  end
end