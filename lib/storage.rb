# frozen_string_literal: true

class Storage
  Juice = Struct.new(:name, :price, :stock)
  attr_reader :juices

  def initialize
    @juices = default_juices
  end

  def select_juice_by_name(name)
    @juices.select { |j| j.name == name }[0]
  end

  def store_juice(juice)
    @juices.push juice
  end

  def reduce_stock(juice)
    @juices.select { |j| j.name == juice.name }[0].stock -= 1
  end

  def stock_exist_juices
    @juices.select { |j| stock_exist?(j.stock) }
  end

  def validate_stock(juice)
    raise '売れ切れています' unless stock_exist? juice.stock
  end

  private

  def stock_exist?(stock)
    stock >= 1
  end

  def default_juices
    [Juice.new('コーラ', 120, 5)]
  end
end
