# frozen_string_literal: true

require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def setup
    @suica = Suica.new
  end

  def test_step_0_success_charged
    @suica.charge(100)
    assert_equal 100, @suica.retrive_charged
  end

  def test_step_0_failed_when_charge_99
    @suica.charge(99)
    assert_equal 0, @suica.retrive_charged
  end

  def test_step_0_failed_when_charge_minus_1
    @suica.charge(-1)
    assert_equal 0, @suica.retrive_charged
  end
end
