# frozen_string_literal: true

class Suica
  MINUMUM_CHARED_MONEY = 100
  def initialize
    @charged_money_amount = 0
  end

  def charge(money)
    @charged_money_amount += money if validate_charge? money
  end

  def retrive_charged
    @charged_money_amount
  end

  private

  def validate_charge?(money)
    if money < MINUMUM_CHARED_MONEY
      puts "入金は、#{MINUMUM_CHARED_MONEY}円以上です。"
      false
    else
      true
    end
  end
end
