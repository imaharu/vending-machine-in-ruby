# frozen_string_literal: true

class VendingMachine
  attr_reader :revenue, :purchased_history
  def initialize(storage)
    @storage = storage
    @revenue = 0
    @purchased_history = []
  end

  def sell(drink_name, payment_method)
    drink = @storage.select_drink_by_name drink_name
    validate_sell drink, payment_method

    payment_method.pay drink.price
    @storage.reduce_stock drink
    @revenue += drink.price
    record_purchased_history payment_method.user, drink

    payment_method
  end

  def store_to_storage(drink)
    @storage.store_drink drink
  end

  def storaged_drinks
    @storage.drinks
  end

  def sellable_drinks
    @storage.stock_exist_drinks
  end

  private

  def record_purchased_history(user, drink)
    @purchased_history.push({ item: drink.name, sex: user.sex, age: user.age, purchased_at: Time.now })
  end

  def validate_sell(drink, payment_method)
    @storage.validate_stock drink
    payment_method.validate_pay drink.price
  end
end
