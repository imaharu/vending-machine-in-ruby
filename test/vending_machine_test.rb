require 'minitest/autorun'
require './lib/vending_machine'
require './lib/storage'

class VendingMachineTest < Minitest::Test
  def test_step_1_storage_default_juices
    storage = Storage.new
    machine = VendingMachine.new(storage)
    assert_equal 'コーラ', machine.storaged_juices[0]['name']
    assert_equal 120, machine.storaged_juices[0]['value']
    assert_equal 5, machine.storaged_juices[0]['stock']
  end
end
