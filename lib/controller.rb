
class Controller
  def initialize(cube, view)
    @cube = cube
    @view = view
    @messages = 0
  end
  def getch
    state = `stty -g`
    begin
      `stty raw -echo cbreak`
    $stdin.getc
    ensure
      `stty #{state}`
    end
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

