# frozen_string_literal: true

require 'minitest/autorun'
require './lib/suica'
require './lib/vending_machine'
require './lib/storage'

class SuicaTest < Minitest::Test
  def setup
    @suica = Suica.new
  end

  def test_step_0_success_charged
    @suica.charge(100)
    assert_equal 100, @suica.retrive_charged
  end

  def test_step_0_failed_when_charge_99
    assert_raises(StandardError) do
      @suica.charge(99)
    end
  end

  def test_step_0_failed_when_charge_minus_1
    assert_raises(StandardError) do
      @suica.charge(-1)
    end
  end

  def test_step_2_decrease_suica_charge
    storage = Storage.new
    machine = VendingMachine.new(storage)
    @suica.charge 120
    machine.sell('コーラ', @suica)
    assert_equal 0, @suica.retrive_charged
  end

  def test_step_2_cannot_pay
    storage = Storage.new
    machine = VendingMachine.new(storage)
    @suica.charge 110
    assert_raises(StandardError) do
      machine.sell('コーラ', @suica)
    end
  end
end
