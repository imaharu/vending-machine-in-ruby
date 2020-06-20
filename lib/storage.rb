# frozen_string_literal: true

class Storage
  Juices = Struct.new(:name, :value, :stock)
  def initialize
    @juices = [default_juices]
  end

  attr_reader :juices

  private

  def default_juices
    Juices.new('コーラ', 120, 5)
  end
end
