# frozen_string_literal: true

require 'minitest/autorun'
require './lib/suica'
require './lib/vending_machine'
require './lib/storage'
require './lib/user'

class SuicaTest < Minitest::Test
  def setup
    user = User.new(23, '男性')
    @suica = Suica.new(user)
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
  
  def test_step_4_get_user_age
    assert_equal 23, @suica.user.age
  end

  def test_step_4_get_user_sex
    assert_equal '男性', @suica.user.sex
  end
end
