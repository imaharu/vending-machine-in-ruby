# frozen_string_literal: true

class Storage
  Drink = Struct.new(:name, :price, :stock)
  attr_reader :drinks

  def initialize
    @drinks = default_drinks
  end

  def select_drink_by_name(name)
    @drinks.select { |j| j.name == name }.first
  end

  def store_drink(drink)
    @drinks.push drink
  end

  def reduce_stock(drink)
    @drinks.select { |j| j.name == drink.name }.first.stock -= 1
  end

  def stock_exist_drinks
    @drinks.select { |j| stock_exist? j.stock }
  end

  def validate_stock(drink)
    raise '売れ切れています' unless stock_exist? drink.stock
  end

  private

  def stock_exist?(stock)
    stock >= 1
  end

  def default_drinks
    [Drink.new('コーラ', 120, 5)]
  end
end
