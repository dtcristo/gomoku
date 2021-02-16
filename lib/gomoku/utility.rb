module Gomoku
  module Utility
    module_function

    def r_to_y(r)
      r * 40 - 20
    end

    def c_to_x(c)
      c * 40 - 20
    end

    def x_to_c(x)
      (x.to_i + 20) / 40
    end

    def y_to_r(y)
      (y.to_i + 20) / 40
    end

    def in_range?(r, c)
      r >= 1 && r <= 19 && c >= 1 && c <= 19
    end

    def toggle_color(color)
      if color == :black
        :white
      else
        :black
      end
    end

    def asset_path(asset)
      File.expand_path("../../../assets/#{asset}", __FILE__)
    end
  end
end
