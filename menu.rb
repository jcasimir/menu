class Menu
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def items_for_target_price(price)
    [items]
  end

end

class Item
  attr_reader :name, :price

  def initialize(data)
    @name  = data[:name]
    @price = data[:price]
  end
end
