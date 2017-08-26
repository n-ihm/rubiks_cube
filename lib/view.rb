
class View
  def initialize(cube)
    @name = cube
    @seiten = @name.get_cube
  end
  
  private
  #ktr 17. 07
  def disp_singl(sidenum, highl = nil)
    z1 = 1
    #zahlenblock breite 5, spacing 4
    print "          "
    while z1 <= 9
      
      
      if highl == z1 - 1
        print "\033[7m#{@seiten[sidenum][z1 - 1]}\033[0m"
        print " "
      else
        print "#{@seiten[sidenum][z1 - 1]} "
      end
      if z1%3 == 0
        puts ""
        print "          "
      else
      end
      z1 = z1 + 1
    end
    puts ""
    puts ""
  end
  
  
  private
  
  def disp_quad(a, b, c, d, sideh = nil, tileh = nil)
    #ktr 17.07
    # 5 spaces between blocks
    add_value = 0
    z2 = 1
    c_sides = 0
    c_tile = 0
    highl = false
    sides = [a, b, c, d]
    while z2 <= 36
      if sideh == sides[c_sides]
        if tileh == c_tile
          highl = true
        end
      end
      if highl == true
        print "\033[7m#{@seiten[sides[c_sides]][c_tile]}\033[0m"
        print" "
        highl = false
      else
        print "#{@seiten[sides[c_sides]][c_tile]} "
      end
      if z2%3 == 0
        if z2%12 == 0
          puts""
        else
          print "    "
        end
      end
      if z2%3 == 0
        if z2%12 == 0
          c_sides = 0
          c_tile = c_tile + 1
          add_value = add_value + 3
        else
          c_tile = add_value
          c_sides = c_sides + 1
        end
      else
        c_tile = c_tile + 1
      end
      
      z2 = z2 + 1
    end
    puts ""
    puts ""
  end
  
  public
  
  def display(sideh = nil, tileh = nil)
    @seiten = @name.get_cube
    if sideh == 2
      disp_singl(2, tileh)
    else
      disp_singl(2)
    end
    if sideh == 4 || sideh == 0 || sideh == 5 || sideh == 1
      disp_quad(4, 0, 5, 1, sideh, tileh)
    else
      disp_quad(4, 0, 5, 1)
    end
    if sideh == 3
      disp_singl(3, tileh)
    else
      disp_singl(3)
    end
  end
end
