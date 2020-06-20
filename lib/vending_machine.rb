# frozen_string_literal: true

class VendingMachine
  attr_reader :revenue
  def initialize(storage)
    @storage = storage
    @revenue = 0
    @purchased_history = []
  end

  def sell(juice_name, payment_method)
    item = storaged_juices.select { |juice| juice.name == juice_name }[0]
    validate_sell item, payment_method
    payment_method.pay item.price
    @storage.reduce_stock item.name
    @revenue += item.price
    record_purchased_history(payment_method.user, item)
    payment_method
  end

  def storaged_juices
    @storage.juices
  end

  def available_sell_juices_list
    @storage.all_exist_stock
  end

  private

  def record_purchased_history(user, item)
    @purchased_history.push({ item: item.name, sex: user.sex, age: user.age, purchased_at: Time.now })
  end

  def validate_sell(item, payment_method)
    @storage.validate_stock item.stock
    payment_method.validate_pay item.price
  end
end
