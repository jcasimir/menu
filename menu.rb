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
    return nil if these_items.empty?

    item = these_items.shift
    remainder = price - item.price

    if remainder == 0
      # Found a perfect match
      return [item]
    elsif remainder > 0
      # Found a potential match
      remaining = these_items.dup
      found = nil
      until found || remaining.empty?
        results = price_match(remaining, remainder)
        if results
          found = true
          return [item] + results
        else
          remaining.shift
        end
      end

      return nil
    else
      # Top item is too large, trash it
      return price_match(these_items, remainder)
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
