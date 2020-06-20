# frozen_string_literal: true

class VendingMachine
  def initialize(storage)
    @storage = storage
  end

  def storaged_juices
    @storage.juices
  end
end
