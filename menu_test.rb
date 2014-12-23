require 'minitest/autorun'
require 'minitest/pride'
require './menu'

class MenuTest < Minitest::Test
  def test_it_finds_the_only_item
    item = Item.new(:name => "Pork Shoulder", :price => "12.99")
    menu = Menu.new
    menu.add_item item
    results = menu.items_for_target_price("12.99")
    assert_equal [item], results
  end

  def test_it_finds_the_only_two_items
    item_1 = Item.new(:name => "Pork Shoulder", :price => "12.99")
    item_2 = Item.new(:name => "Lamb Shank", :price => "10.29")
    menu = Menu.new
    menu.add_item item_1
    menu.add_item item_2
    results = menu.items_for_target_price("23.28")
    assert_equal [item_1, item_2], results
  end

  def test_it_finds_two_of_three_items
    item_1 = Item.new(:name => "Pork Shoulder", :price => "12.99")
    item_2 = Item.new(:name => "Lamb Shank", :price => "10.29")
    item_3 = Item.new(:name => "Flank Steak", :price => "12.49")
    menu = Menu.new
    menu.add_item item_1
    menu.add_item item_2
    menu.add_item item_3
    results = menu.items_for_target_price("25.48")
    assert_equal [item_1, item_3], results
  end

  def test_it_finds_three_of_three_items
    item_1 = Item.new(:name => "Pork Shoulder", :price => "12.99")
    item_2 = Item.new(:name => "Lamb Shank", :price => "10.29")
    item_3 = Item.new(:name => "Flank Steak", :price => "12.49")
    menu = Menu.new
    menu.add_item item_1
    menu.add_item item_2
    menu.add_item item_3
    results = menu.items_for_target_price("35.77")
    assert_equal [item_1, item_2, item_3].sort, results.sort
  end

  def test_it_finds_two_of_four_items_when_the_largest_is_not_in_the_solution
    item_1 = Item.new(:name => "Pork Shoulder", :price => "12.99")
    item_2 = Item.new(:name => "Lamb Shank", :price => "10.29")
    item_3 = Item.new(:name => "Flank Steak", :price => "12.49")
    item_4 = Item.new(:name => "Ground Beef", :price => "6.22")
    menu = Menu.new
    menu.add_item item_1
    menu.add_item item_2
    menu.add_item item_3
    menu.add_item item_4
    results = menu.items_for_target_price("22.78")
    assert_equal [item_2, item_3].sort, results.sort
  end

  def test_it_finds_three_of_four_items
    item_1 = Item.new(:name => "Pork Shoulder", :price => "12.99")
    item_2 = Item.new(:name => "Lamb Shank", :price => "10.29")
    item_3 = Item.new(:name => "Flank Steak", :price => "12.49")
    item_4 = Item.new(:name => "Ground Beef", :price => "6.22")
    menu = Menu.new
    menu.add_item item_1
    menu.add_item item_2
    menu.add_item item_3
    menu.add_item item_4
    results = menu.items_for_target_price("29.50")
    assert_equal [item_1, item_2, item_4].sort, results.sort
  end

  def test_it_finds_three_of_six_items_when_the_largest_is_not_in_the_solution
    items = [
      Item.new(:name => "Pork Shoulder", :price => "12.99"),
      Item.new(:name => "Lamb Shank", :price => "10.29"),
      Item.new(:name => "Flank Steak", :price => "12.49"),
      Item.new(:name => "Ground Beef", :price => "6.22"),
      Item.new(:name => "Bacon", :price => "8.99"),
      Item.new(:name => "Chicken Breast", :price => "4.89")
    ]
    menu = Menu.new
    items.each{|i| menu.add_item(i)}

    expected = [items[1], items[3], items[5]]
    expected_sum = (expected.inject(0){|sum, item| sum + item.price} / 100.0).to_s

    results = menu.items_for_target_price(expected_sum)
    assert_equal expected.sort, results.sort
  end

  def test_it_finds_a_somewhat_complex_solution
    # item_data = (1..10).collect{ [Faker::Commerce.product_name , sprintf("%.2f", Faker::Commerce.price)] }
    #
    item_data = [["Ergonomic Steel Chair", "30.60"], ["Awesome Steel Shirt", "80.13"], ["Intelligent Concrete Computer", "96.94"], ["Rustic Plastic Hat", "86.49"], ["Practical Plastic Shoes", "41.20"], ["Rustic Rubber Shoes", "45.27"], ["Intelligent Plastic Gloves", "3.33"], ["Small Steel Hat", "65.73"], ["Intelligent Concrete Shoes", "16.47"], ["Practical Plastic Hat", "11.72"]]
    menu = Menu.new
    item_data.each do |name, price|
      menu.add_item Item.new(:name => name, :price => price)
    end

    expected = [menu.items[2], menu.items[4], menu.items[6]].sort
    expected_sum = (expected.inject(0){|sum, item| sum + item.price}).to_s.insert(-3, '.')
    results = menu.items_for_target_price(expected_sum)
    assert_equal expected.sort, results.sort
  end

  def test_it_finds_a_complex_solution
    # item_data = (1..100).collect{ [Faker::Commerce.product_name , sprintf("%.2f", Faker::Commerce.price)] }
    #
    item_data = [["Awesome Concrete Gloves", "22.74"], ["Sleek Concrete Gloves", "48.94"], ["Intelligent Plastic Hat", "99.50"], ["Rustic Granite Hat", "24.73"], ["Gorgeous Rubber Table", "3.92"], ["Ergonomic Concrete Chair", "46.62"], ["Fantastic Steel Shoes", "26.69"], ["Fantastic Granite Computer", "31.15"], ["Rustic Rubber Shirt", "49.99"], ["Intelligent Wooden Gloves", "4.55"], ["Awesome Rubber Shoes", "62.77"], ["Sleek Granite Chair", "18.57"], ["Small Cotton Pants", "83.46"], ["Awesome Wooden Car", "10.59"], ["Ergonomic Concrete Shirt", "47.66"], ["Incredible Steel Shirt", "75.65"], ["Incredible Cotton Pants", "25.75"], ["Practical Rubber Hat", "62.51"], ["Rustic Steel Shoes", "25.02"], ["Gorgeous Plastic Pants", "89.64"], ["Small Steel Computer", "80.61"], ["Intelligent Plastic Car", "62.15"], ["Gorgeous Plastic Shirt", "95.08"], ["Intelligent Concrete Pants", "29.37"], ["Gorgeous Cotton Gloves", "1.31"], ["Small Granite Car", "74.35"], ["Ergonomic Plastic Chair", "64.18"], ["Ergonomic Steel Car", "8.26"], ["Rustic Plastic Shoes", "88.13"], ["Gorgeous Cotton Gloves", "62.07"], ["Intelligent Concrete Hat", "66.16"], ["Intelligent Steel Gloves", "41.23"], ["Practical Concrete Computer", "0.11"], ["Gorgeous Steel Gloves", "5.12"], ["Practical Wooden Pants", "12.75"], ["Intelligent Rubber Car", "57.84"], ["Fantastic Granite Hat", "21.86"], ["Practical Steel Shirt", "70.74"], ["Ergonomic Concrete Chair", "31.23"], ["Practical Cotton Shirt", "95.42"], ["Ergonomic Wooden Computer", "7.00"], ["Incredible Plastic Shirt", "60.35"], ["Sleek Granite Gloves", "11.51"], ["Incredible Wooden Hat", "37.52"], ["Fantastic Plastic Chair", "21.43"], ["Incredible Wooden Shoes", "87.03"], ["Rustic Plastic Shoes", "33.46"], ["Gorgeous Concrete Hat", "15.21"], ["Incredible Cotton Gloves", "37.58"], ["Gorgeous Cotton Chair", "13.42"], ["Rustic Rubber Car", "18.54"], ["Awesome Granite Pants", "81.94"], ["Awesome Steel Pants", "26.41"], ["Sleek Wooden Chair", "7.81"], ["Ergonomic Granite Shoes", "75.66"], ["Incredible Steel Car", "61.98"], ["Gorgeous Granite Shirt", "32.61"], ["Intelligent Plastic Pants", "7.93"], ["Awesome Wooden Shirt", "96.80"], ["Practical Cotton Shirt", "51.13"], ["Small Wooden Table", "72.70"], ["Rustic Wooden Shirt", "7.68"], ["Small Wooden Shirt", "10.93"], ["Intelligent Concrete Table", "7.66"], ["Gorgeous Granite Gloves", "28.93"], ["Fantastic Rubber Shoes", "47.50"], ["Gorgeous Plastic Gloves", "13.76"], ["Awesome Cotton Shoes", "54.88"], ["Intelligent Steel Hat", "29.46"], ["Rustic Steel Pants", "29.06"], ["Intelligent Wooden Pants", "98.95"], ["Gorgeous Steel Table", "99.84"], ["Fantastic Rubber Computer", "64.22"], ["Small Rubber Hat", "68.12"], ["Small Plastic Chair", "77.04"], ["Ergonomic Rubber Table", "94.95"], ["Fantastic Concrete Shirt", "28.84"], ["Rustic Plastic Chair", "88.55"], ["Ergonomic Concrete Shirt", "33.05"], ["Sleek Concrete Car", "86.17"], ["Intelligent Plastic Hat", "18.18"], ["Gorgeous Steel Chair", "98.58"], ["Incredible Rubber Shirt", "14.92"], ["Rustic Wooden Pants", "52.53"], ["Practical Wooden Shoes", "93.87"], ["Fantastic Steel Shirt", "36.72"], ["Practical Concrete Table", "56.02"], ["Gorgeous Steel Chair", "7.30"], ["Intelligent Concrete Shoes", "76.19"], ["Sleek Cotton Table", "0.23"], ["Fantastic Wooden Table", "28.87"], ["Ergonomic Plastic Pants", "54.28"], ["Rustic Cotton Shirt", "62.91"], ["Small Plastic Shirt", "69.54"], ["Incredible Rubber Hat", "13.00"], ["Small Wooden Shirt", "3.95"], ["Fantastic Concrete Shoes", "54.99"], ["Awesome Concrete Pants", "60.96"], ["Awesome Granite Pants", "94.26"], ["Awesome Granite Shirt", "6.39"]]
    menu = Menu.new
    item_data.each do |name, price|
      menu.add_item Item.new(:name => name, :price => price)
    end

    expected = [menu.items[20], menu.items[30], menu.items[40], menu.items[50]]
    expected_sum = expected.inject(0){|sum, item| sum + item.price}.to_s
    results = menu.items_for_target_price(expected_sum)
    assert_equal expected.sort, results.sort
  end
end
