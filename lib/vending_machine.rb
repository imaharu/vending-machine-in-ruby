# frozen_string_literal: true

class VendingMachine
  attr_reader :revenue, :purchased_history
  def initialize(storage)
    @storage = storage
    @revenue = 0
    @purchased_history = []
  end

  def sell(juice_name, payment_method)
    juice = @storage.select_juice_by_name(juice_name)
    validate_sell juice, payment_method

    payment_method.pay juice.price
    @storage.reduce_stock juice
    @revenue += juice.price
    record_purchased_history(payment_method.user, juice)

    payment_method
  end

  def store_to_storage(juice)
    @storage.store_juice juice
  end

  def storaged_juices
    @storage.juices
  end

  def sellable_juices
    @storage.stock_exist_juices
  end

  private

  def record_purchased_history(user, juice)
    @purchased_history.push({ item: juice.name, sex: user.sex, age: user.age, purchased_at: Time.now })
  end

  def validate_sell(juice, payment_method)
    @storage.validate_stock juice
    payment_method.validate_pay juice.price
  end
end
