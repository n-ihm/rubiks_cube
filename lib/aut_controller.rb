class Aut_controller
  def initialize(cube, view)
    @cube = cube
    @view = view
  end
  def make_bottom_cross
    b_color = @cube.get_square(3, 4)
    b_color_a = @cube.match_side(b_color)
    matching_sides = @cube.find_pos(b_color_a, "side")
  end
  def solve
    state = "unsolved"
    case state
    when "unsolved"
    end
  end
end
