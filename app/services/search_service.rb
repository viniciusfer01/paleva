class SearchService
  def initialize(query, user)
    @query = query
    @user = user
  end

  def call
    {
      dishes: search_dishes,
      beverages: search_beverages
    }
  end

  private

  def search_dishes
    Dish.where('(name LIKE ? OR description LIKE ?) AND store_id = ? ', "%#{@query}%", "%#{@query}%", @user.store.id)
  end

  def search_beverages
    Beverage.where('(name LIKE ? OR description LIKE ?) AND store_id = ? ', "%#{@query}%", "%#{@query}%", @user.store.id)
  end
end