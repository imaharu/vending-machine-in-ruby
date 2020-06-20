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

  def all_exist_stock
    @juices.select { |juice| exist_stock?(juice.stock) }
  end

  def validate_stock(stock)
    raise '売れ切れています' unless exist_stock? stock
  end

  private

  def exist_stock?(stock)
    stock >= 1
  end

  def default_juices
    Juice.new('コーラ', 120, 5)
  end
end
