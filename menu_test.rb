require 'minitest/autorun'
require 'minitest/pride'
require './menu'

class MenuTest < Minitest::Test
  def test_it_finds_the_only_item
    item = Item.new(:name => "Pork Shoulder", :price => "12.99")
    menu = Menu.new
    menu.add_item item
    results = menu.items_for_target_price("12.99")
    assert results.include?([item])
  end
end
