# Helper methods
module Utility
  def Utility.r_to_y r
    r*40 - 20
  end

  def Utility.c_to_x c
    c*40 - 20
  end

  def Utility.x_to_c x
    (x.to_i + 20) / 40
  end

  def Utility.y_to_r y
    (y.to_i + 20) / 40
  end

  def Utility.in_range? r, c
    r >= 1 and r <= 19 and c >= 1 and c <= 19
  end
end
