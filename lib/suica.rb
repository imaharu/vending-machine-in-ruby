# frozen_string_literal: true

class Suica
  MINUMUM_CHARED_MONEY = 100
  def initialize
    @charged_money_amount = 0
  end

  def pay(money)
    @charged_money_amount -= money
  end

  def charge(money)
    validate_charge money
    @charged_money_amount += money
  end

  def retrive_charged
    @charged_money_amount
  end

  def validate_pay(money)
    raise '支払い額が、入金額を超えています。チャージして下さい' unless can_pay?(money)
  end

  private

  def can_pay?(money)
    retrive_charged >= money
  end

  def validate_charge(money)
    raise StandardError "1回あたりチャージは、#{MINUMUM_CHARED_MONEY}円以上です。" if money < MINUMUM_CHARED_MONEY
  end
end
