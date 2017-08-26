# coding: utf-8
# coding: utf-8
#require 'pry'
# blickrichtung auf den würfel von forne(vorderseite front
def getch
  state = `stty -g`
  begin
    `stty raw -echo cbreak`
    $stdin.getc
  ensure
    `stty #{state}`
  end
end

class Wuerfel
  def initialize
    #1 = weiß
    # 2 = gruehn
    # 3 = gelb
    # 4 = rot
    # 5 = blau
    # 6 = orange
    # 0 front
    # 1 back
    # 2 top
    # 3 bottom
    # 4 left
    # 5 right
    # kreuz angelegt top mitte, 
    @front =[3, 6, 5, 4, 1, 6, 5, 2, 3]
    @back =[2, 5, 5, 1, 3, 2, 6, 1, 6]
    @top = [6, 6, 4, 5, 2, 4, 5, 1, 1]
    @bottom = [4, 6, 4, 4, 5, 5, 3, 2, 1]
    @left = [3, 1, 4, 3, 4, 3, 2, 5, 1]
    @right= [6, 2, 1, 3, 6, 4, 2, 3, 2]
    
    
    
    @seiten = [@front, @back, @top, @bottom, @left, @right]
  end
  private
  def m_side(a)
    sides_found = Array.new(9)
    s_found = 0
    count = 0
    count2 = 0
    9.times do
      while count2 < 9
        if @seiten[count][count2] == a
          sides_found[s_found] = [count, count2]
          s_found = s_found + 1
        end
        count_2 = count_2 + 1
      end
      count = count + 1
    end
    return sides_found
  end

  public
  def match_side(colour)
    case colour
    when 1
      m_sides(1)
    when 2
      m_sides(2)
    when 3
      m_sides(3)
    when 4
      m_sides(4)
    when 5
      m_sides(5)
    when 6
      m_sides(6)
    end
  end
  def find_pos(match_side_array, pos)
    # positions are side, corner
    found = Array.new
    founda = 0
    case pos
    when "side"
      count = 0
      while count < 9
        if match_side_array[count][1] == 1 || match_side_array[count][1] == 3 || match_side_array[count][1] == 5 || match_side_array[count][1] == 7
          found[founda] = [match_side_array[count][0], match_side_array[count][1]]
          founda = founda + 1
        end
        count = count + 1
      end
    when "corner"
      count = 0
      while count < 9
        if match_side_array[count][1] == 0 || match_side_array[count][1] == 2 || match_side_array[count][1] == 6 || match_side_array[count][1] == 8
          found[founda] = [match_side_array[count][0], match_side_array[count][1]]
          founda = founda + 1
        end
        count = count + 1
      end
    end
    return found
  end
          
          
 
  def get_square(side, number)
    return @seiten[side][number]
  end
  
  def get_side(side)
    return @seiten[side]
  end
  def get_cube
    return @seiten
  end
  
  def ==(other)
    z = 0
    while z < 6
      za = 0
      while za < 9
        puts "#{@seiten[z][za]}    #{other.get_square(z, za)}"
        puts "#{z}   #{za}"
        if @seiten[z][za] == other.get_square(z, za)
          
        else
          return false
        end
        za+=1
      end
      z+=1
    end
    return true
  end
  
  
  
  private
  
  
  
  def switch_spalte(side1, snum1, side2, snum2)
    # spalte von links nach rechts(in kreuzdarstellung) 0, 1, 2
    a1 = 0
    a2 = 0
    a3 = 0
    a1 = @seiten[side1][snum1]
    a2 = @seiten[side1][snum1 + 3]
    a3 = @seiten[side1][snum1 + 6]
    @seiten[side1][snum1] = @seiten[side2][snum2]
    @seiten[side1][snum1 + 3] = @seiten[side2][snum2 + 3]
    @seiten[side1][snum1 + 6] = @seiten[side2][snum2 + 6]
    @seiten[side2][snum2] = a1
    @seiten[side2][snum2 + 3] = a2
    @seiten[side2][snum2 + 6] = a3
    
  end
  private
  def switch_zeile(side1, z1, side2, z2)
    #zeilennummer vonoben nach unten (kreuzdarstellung) = 0 3 6
    b1 = 0
    b2 = 0
    b3 = 0
    b1 = @seiten[side1][z1]
    b2 = @seiten[side1][z1 + 1]
    b3 = @seiten[side1][z1 + 2]
    @seiten[side1][z1] = @seiten[side2][z2]
    @seiten[side1][z1 + 1] = @seiten[side2][z2 + 1]
    @seiten[side1][z1 + 2] = @seiten[side2][z2 + 2]
    @seiten[side2][z2] = b1
    @seiten[side2][z2 + 1] = b2
    @seiten[side2][z2 + 2] = b3
  end
  private
  def cntr_clock(p_z)
    # p_z kann die werte 0, 3, 6 annehmen und bezeichnet die zeile des würfels, die gedreht wird. Anliegende
    #Oberflächen werden nicht mitgedreht!!
    #ktr 17.7
    switch_zeile(0, p_z, 5, p_z)
    switch_zeile(0, p_z, 1, p_z)
    switch_zeile(0, p_z, 4, p_z)
  end

  
  
  private
  def swtab(twod_array)
    # when given a 2d array with cordinates(side, tile) it switches them through
    count = 0
    copy = nil
    while count < twod_array.length
      if   copy == nil
        copy =  @seiten[twod_array[count][0]][twod_array[count][1]]
      else
        # sw_t(twod_array[count][0], twod_array[count][1], copy)
        cp = @seiten[twod_array[count][0]][twod_array[count][1]]
        @seiten[twod_array[count][0]][twod_array[count][1]] = copy
        copy = cp
      end
      count = count + 1
    end
  end


  
  private

  
  def prim_down(p_s)
    #die spalten sind mit 0,1,2 von links nach rechts beschriftet. Darstellung im Schachbrett Muster
    # switch_spalte(3, p_s, 1, p_s)
    # switch_spalte(3, p_s, 2, p_s)
    # switch_spalte(3, p_s, 0, p_s)
    case p_s
    when 0
      swtab([[0, 0], [3, 0], [1, 8], [2, 0], [0, 0]])
      swtab([[0, 3], [3, 3], [1, 5], [2, 3], [0, 3]])
      swtab([[0, 6], [3, 6], [1, 2], [2, 6], [0, 6]])
    when 1
      swtab([[0, 1], [3, 1], [1, 7], [2, 1], [0, 1]])
      swtab([[0, 4], [3, 4], [1, 4], [2, 4], [0, 4]])
      swtab([[0, 7], [3, 7], [1, 1], [2, 7], [0, 7]])
    when 2
      swtab([[0, 2], [3, 2], [1, 6], [2, 2], [0, 2]])
      swtab([[0, 5], [3, 5], [1, 3], [2, 5], [0, 5]])
      swtab([[0, 8], [3, 8], [1, 0], [2, 8], [0, 8]])
    end
  end
  
  private
  def switch_sides(sid1, sid2)
    #sid1, sid2 sind die zu tauschenden seitennummern
    copy2 = @seiten[sid2].dup
    copy1 = @seiten[sid1].dup
    @seiten[sid2] = copy1
    @seiten[sid1] = copy2
  end
  
  
  private
  def rotr_surf(sidenum)
    
    # rotates surface  counter clock
    # front back top bottom left right sind die seiten. Nummerierung beginnt mit 0
    matrix = [2 ,5, 8, 1, 4, 7, 0, 3, 6]
    cpy = @seiten[sidenum].dup
    i = 0
    while i < 9
      @seiten[sidenum][i] = cpy[matrix[i]]
      i = i + 1
    end
  end
  
  
  public
  
  def rot_cube(way)
    case way
    when "up"
      3.times do
        prim_down(0)
        prim_down(1)
        prim_down(2)
      end
      rotr_surf(4)
      rotr_surf(5)
      rotr_surf(5)
      rotr_surf(5)
    when "down"
      3.times do
        3.times do
          prim_down(0)
          prim_down(1)
          prim_down(2)
        end
        rotr_surf(4)
        rotr_surf(5)
        rotr_surf(5)
        rotr_surf(5)
      end
    when "clock"
      #viewed from the top
      switch_sides(0, 4)
      switch_sides(0, 1)
      switch_sides(5, 0)
      rotr_surf(3)
      3.times do
        rotr_surf(2)
      end
    when "counter_clock"
      3.times do
        switch_sides(0, 4)
        switch_sides(0, 1)
        switch_sides(5, 0)
      end
        rotr_surf(2)
        3.times do
          rotr_surf(3)
        end
    else
      fail "Falscher parameter"
    end
  end
  
  
  
  public
  def turn_counter_clock(zle)
    case zle
    when 0
      cntr_clock(0)
      rotr_surf(2)
      
    when 1
      cntr_clock(3)
    when 2
      cntr_clock(6)
      3.times do
        rotr_surf(3)
      end
    end
  end
  
  
  public
  def turn_clock(zle)
    turn_counter_clock(zle)
    turn_counter_clock(zle)
    turn_counter_clock(zle)
  end
  
  
  public
  def turn_up(spalte)
    case spalte
    when 0
      3.times do
        prim_down(0)
      end
      rotr_surf(4)
    when 1
      3.times do
        prim_down(1)
      end
    when 2
      3.times do
        prim_down(2)
        rotr_surf(5)
      end
    end
  end
  
  
  public
  def turn_down(splte)
    turn_up(splte)
    turn_up(splte)
    turn_up(splte)
  end
  
  
end

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

class Controller
  def initialize(cube, view)
    @cube = cube
    @view = view
    @messages = 0
  end
  public
  def rotate(way)
    @cube.rot_cube(way)
  end
  def turn_counter_clock(zle)
    @cube.turn_counter_clock(zle)
  end
  def turn_clock(zle)
    @cube.turn_clock(zle)
  end
  def turn_up(spalte)
    @cube.turn_up(spalte)
  end
  def turn_down(spalte)
    @cube.turn_down(spalte)
  end
  def respond_to_user_input
    # asdw for cursor movements, jkli for changing the cube
    clear_code = %x{clear}
    tile = 4
    side = 0
    s_ch = false
    sides = ["front", "back", "top", "bottom", "left", "right"]
    puts "Cursor at side: #{sides[side]}, tile #{tile}."
    while (c = getch) != "\e" 
      
      
      case c
      when "a"
        if tile == 0 || tile == 3 || tile == 6
          s_ch = true
        end
        case tile
        when 0
          tile = 2
        when 3
          tile = 5
        when 6
          tile = 8
        else
          tile = tile - 1
        end
        if s_ch == true
          case side
          when 0
            side = 4
          when 1
            side = 5
          when 4
            side = 1
          when 5
            side = 0
          else
          end
          s_ch = false  
        end
      when "d"
        if tile == 2 || tile == 5 || tile == 8
          s_ch = true
        end
        case tile
        when 2
          tile = 0
        when 5
          tile = 3
        when 8
          tile = 6
        else
          tile = tile + 1
        end
        if s_ch == true
          case side
          when 0
            side = 5
          when 1
            side = 4
          when 4
            side = 0
          when 5
            side = 1
          else
          end
          s_ch = false
        end
      when "s"
        if tile == 6 || tile == 7 || tile == 8
          s_ch = true
        end
        case tile
        when 6
          tile = 0
        when 7
          tile = 1
        when 8
          tile = 2
        else
          tile = tile + 3
        end
        if s_ch == true
          case side
          when 0
            side = 3
          when 3
            side = 2
          when 2
            side = 0
          end
          s_ch = false
        end
        
      when "w"
        if tile == 0 || tile == 1 || tile == 2
          s_ch = true
        end
        case tile
        when 0
          tile = 6
        when 1
          tile = 7
        when 2
          tile = 8
        else
          tile = tile - 3
        end
        if s_ch == true
          case side
          when 0
            side = 2
          when 3
            side = 0
          when 2
            side = 3
          end
          s_ch = false
        end
      when "j"
        case side
        when 0, 1, 4, 5
          case tile
          when 0, 1, 2
            turn_clock(0)
          when 3, 4, 5
            turn_clock(1)
          when 6, 7, 8
            turn_clock(2)
          end
        when 2
          rotate("down")
          case tile
          when 0, 1, 2
            turn_clock(0)
          when 3, 4, 5
            turn_clock(1)
          when 6, 7, 8
            turn_clock(2)
          end
          rotate("up")
        when 3
          rotate("up")
          case tile
          when 0, 1, 2
            turn_clock(0)
          when 3, 4, 5
            turn_clock(1)
          when 5, 6, 7
            turn_clock(2)
          end
          rotate("down")
        end
      when "l"
        case side
        when 0, 1, 4, 5
          case tile
          when 0, 1, 2
            turn_counter_clock(0)
          when 3, 4, 5
            turn_counter_clock(1)
          when 6, 7, 8
            turn_counter_clock(2)
          end
        when 2
          rotate("down")
          case tile
          when 0, 1, 2
            turn_counter_clock(0)
          when 3, 4, 5
            turn_counter_clock(1)
          when 6, 7, 8
            turn_counter_clock(2)
          end
          rotate("up")
        when 3
          rotate("up")
          case tile
          when 0, 1, 2
            turn_counter_clock(0)
          when 3, 4, 5
            turn_counter_clock(1)
          when 6, 7, 8
            turn_counter_clock(2)
          end
          rotate("down")
        end
      when "i"
        case side
        when 0, 2, 3
          case tile
          when 0, 3, 6
            turn_up(0)
          when 1, 4, 7
            turn_up(1)
          when 2, 5, 8
            turn_up(2)
          end
        when 1
          2.times do
            rotate("clock")
          end
          case tile
          when 0, 3, 6
            turn_up(0)
          when 1, 4, 7
            turn_up(1)
          when 2, 5, 8
            turn_up(2)
          end
          2.times do
            rotate("counter_clock")
          end
        when 4
          rotate("counter_clock")
          case tile
          when 0, 3, 6
            turn_up(0)
          when 1, 4, 7
            turn_up(1)
          when 2, 5, 8
            turn_up(2)
          end
          rotate("clock")
        when 5
          rotate("clock")
          case tile
          when 0, 3, 6
            turn_up(0)
          when 1, 4, 7
            turn_up(1)
          when 2, 5, 8
            turn_up(2)
          end
          rotate("counter_clock")
        end
      when "k"
        case side
        when 0, 2, 3
          case tile
          when 0, 3, 6
            turn_down(0)
          when 1, 4, 7
            turn_down(1)
          when 2, 5, 8
            turn_down(2)
          end
        when 1
          2.times do
            rotate("clock")
          end
          case tile
          when 0, 3, 6
            turn_down(0)
          when 1, 4, 7
            turn_down(1)
          when 3, 5, 8
            turn_down(2)
          end
          2.times do
            rotate("clock")
          end
        when 4
          rotate("counter_clock")
          case tile
          when 0, 3, 6
            turn_down(0)
          when 1, 4, 7
            turn_down(1)
          when 2, 5, 8
            turn_down(2)
            
          end
          rotate("clock")
        when 5
          rotate("clock")
          case tile
          when 0, 3, 6
            turn_down(0)
          when 1, 4, 7
            turn_down(1)
          when 2, 5, 8
            turn_down(2)
          end
          rotate("counter_clock")
        end
      end
      print clear_code
      puts c
      puts @messages
      puts "Cursor at side: #{sides[side]}, tile #{tile}."
      @view.display(side, tile)
    end
  end
end

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


cub = Wuerfel.new
dispcube = View.new(cub)

contcube = Controller.new(cub, dispcube)
#dispcube.display(0, 4)
#dispcube.display
#contcube.rotate("up")
#dispcube.display
#contcube.rotate("down")

contcube.respond_to_user_input
