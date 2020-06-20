# frozen_string_literal: true

class Storage
  Juice = Struct.new(:name, :price, :stock)
  attr_reader :juices

  def initialize
    @juices = [default_juices]
  end

  def store_juice(juice)
    @juices.push juice
  end

  def reduce_stock(name)
    @juices.select { |juice| juice.name == name }[0].stock -= 1
  end

  def exist_stocks
    @juices.select { |juice| stock_exist?(juice.stock) }
  end

  def validate_stock(stock)
    raise '売れ切れています' unless stock_exist? stock
  end

  private

  def stock_exist?(stock)
    stock >= 1
  end

  def default_juices
    Juice.new('コーラ', 120, 5)
  end
end
