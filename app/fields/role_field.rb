require "administrate/field/base"

class RoleField < Administrate::Field::Base
  def to_s
    data.join(" ")
  end
  def to_array
    data
  end
  def size
    data.size
  end
end
