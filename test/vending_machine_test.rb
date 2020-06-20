# frozen_string_literal: true

require 'minitest/autorun'
require './lib/vending_machine'
require './lib/storage'
require './lib/suica'

class VendingMachineTest < Minitest::Test
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
    suica = Suica.new
    suica.charge 120
    assert machine.sell('コーラ', suica)
  end

  def test_step_2_decrease_cola_stock
    storage = Storage.new
    machine = VendingMachine.new(storage)
    suica = Suica.new
    suica.charge 120
    machine.sell('コーラ', suica)
    assert_equal 4, machine.storaged_juices[0]['stock']
  end

  def test_step_2_revenue_recognition
    storage = Storage.new
    machine = VendingMachine.new(storage)
    suica = Suica.new
    suica.charge 120
    machine.sell('コーラ', suica)
    assert_equal 120, machine.revenue
  end
end
