# frozen_string_literal: true

require 'minitest/autorun'
require './lib/vending_machine'
require './lib/storage'
require './lib/suica'

class VendingMachineTest < Minitest::Test
  def setup
    user = User.new(23, '男性')
    @suica = Suica.new(user)
  end

  def test_step_1_storage_default_juices
    storage = Storage.new
    machine = VendingMachine.new(storage)
    assert_equal 'コーラ', machine.storaged_juices[0]['name']
    assert_equal 120, machine.storaged_juices[0]['price']
    assert_equal 5, machine.storaged_juices[0]['stock']
  end

  def test_step_2_can_sell
    storage = Storage.new
    machine = VendingMachine.new(storage)
    @suica.charge 120
    assert machine.sell('コーラ', @suica)
  end

  def test_step_2_decrease_cola_stock
    storage = Storage.new
    machine = VendingMachine.new(storage)
    @suica.charge 120
    machine.sell('コーラ', @suica)
    assert_equal 4, machine.storaged_juices[0]['stock']
  end

  def test_step_2_revenue_recognition
    storage = Storage.new
    machine = VendingMachine.new(storage)
    @suica.charge 120
    machine.sell('コーラ', @suica)
    assert_equal 120, machine.revenue
  end

  def test_step_3_store_new_juice
    storage = Storage.new
    machine = VendingMachine.new(storage)
    machine.store_to_storage(Storage::Juice.new('レッドブル', 200, 5))
    assert_equal 1, machine.storaged_juices.select { |juice| juice.name == 'レッドブル' }.count
  end

  def test_step_3_sellable_juices
    storage = Storage.new
    machine = VendingMachine.new(storage)
    machine.store_to_storage(Storage::Juice.new('レッドブル', 200, 0))
    machine.store_to_storage(Storage::Juice.new('水', 100, 5))
    assert_equal 2, machine.sellable_juices.count
  end
end
