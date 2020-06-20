# frozen_string_literal: true

class User
  attr_reader :age
  attr_reader :sex
  def initialize(age, sex)
    @age = age.to_i
    @sex = sex
  end
end
