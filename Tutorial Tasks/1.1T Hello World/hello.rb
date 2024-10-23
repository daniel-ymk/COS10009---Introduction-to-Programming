class Groceries
    attr_accessor :id, :description, :price, :quantity
    def initialize(id,description, price, quanity)
        @id = id
        @description = description
        @price = price
        @quantity = quanity
    end
end

def read_item
    puts("Please Enter the id of the item: ")
    id = gets.chomp.to_i
    puts("Please Enter the description of the item: ")
    description = gets.chomp.to_s
    puts("Please Enter the price of the item: ")
    price = gets.chomp.to_f
    puts("Please Enter the quantity of the item: ")
    quantity = gets.chomp.to_i

    item = Groceries.new(id,description,price,quantity)
    return item
end

def display_item(item)
    puts (item.id.to_s + "\n" + item.description.to_s + "\n" + item.price.to_s + "\n" + item.quantity.to_s + "\n")
end

def main()
    single_item = read_item()
    display_item(single_item)
end

main()
