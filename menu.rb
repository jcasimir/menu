require 'pry'

class Menu
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
    @items = @items.sort.reverse
  end

  def items_for_target_price(price)
    target = (price.to_f * 100).to_i
    these_items = items.dup
    found = false
    results = nil

    while !found && !these_items.empty?
      puts "Finding a solution from #{these_items.count} items"
      results = price_match(these_items.dup, target)
      puts " Found: #{results.inspect}"
      if results
        found = true
      else
        these_items.shift
      end
    end

    return results || "No Solution!"
  end

private

  def price_match(these_items, price)
    # if these_items is empty, fail
    return nil if these_items.empty?

    item = these_items.shift
    remainder = price - item.price

    # if item price matches price, return item
    return [item] if remainder == 0

    # if item price is too big, try from the next one
    return price_match(these_items, price) if remainder < 0

    # if item price is smaller than price...
    #   1. this item is in solution, find a solution using the remaining items and remainder
    #   2. this item is not in solution, find a solution using remaining items and price
    #   3. there is no solution

    results = price_match(these_items.dup, remainder)
    if results
      return [item] + results
    else
      return price_match(these_items.dup, price)
    end
  end

end

class Item
  attr_reader :name, :price

  def initialize(data)
    @name  = data[:name]
    @price = (data[:price].to_f * 100).to_i
  end

  def <=>(other)
    price <=> other.price
  end
end
