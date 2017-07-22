# coding: utf-8
# blickrichtung auf den würfel von forne(vorderseite front

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
  @front =[1, 2, 3, 5, 6, 4, 5, 2, 3]
  @back =[4, 5, 2, 3, 6, 6, 2, 1, 3]
  @top = [1, 5, 4, 6, 2, 1, 4, 2 ,6]
  @bottom = [1, 3, 6, 4, 5, 1, 2, 3, 4]
  @left = [5, 3, 4, 6, 3, 1, 2, 3, 6]
  @right= [1, 2, 4, 5, 1, 5, 5, 4, 6]


  
  @seiten = [@front, @back, @top, @bottom, @left, @right]
end
public

def get_square(side, number)
  return @seiten[side][number]
end

def get_side(side)
  return @seiten[side]
end

def ==(other)
  z = 0
  check = 0
  while z < 6
    za = 0
    while za < 9
      if @seiten[z][za] == other.return_square(z, za)

      else
        check = 1
        break
        break
      end
    end
  end
  if check == 0
    return true
  else
    return false
  end
end
      
private
#ktr 17. 07
def disp_singl(sidenum)
  z1 = 0
  #zahlenblock breite 5, spacing 4
  while z1 < 9
    puts "          #{@seiten[sidenum][z1]} #{@seiten[sidenum][z1 + 1]} #{@seiten[sidenum][z1 + 2]}"
    z1 = z1 + 3
  end
  puts ""
  puts ""
end
private

  
def disp_tripl(a, b, c)
  #ktr 17.07
  z2 = 0
  while z2 < 9 
    puts "#{@seiten[a][z2]} #{@seiten[a][z2 + 1]} #{@seiten[a][z2 + 2]}     #{@seiten[b][z2]} #{@seiten[b][z2 + 1]} #{@seiten[b][z2 + 2]}     #{@seiten[c][z2]} #{@seiten[c][z2 + 1]} #{@seiten[c][z2 + 2]}"
    z2 = z2 + 3
  end
  puts ""
  puts ""
end
public
def display
  disp_singl(1)
  disp_singl(2)
  disp_tripl(4, 0, 5)
  disp_singl(3)
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
def prim_down(p_s)
  #die spalten sind mit 0,1,2 von links nach rechts beschriftet. Darstellung im Schachbrett Muster
  switch_spalte(3, p_s, 1, p_s)
  switch_spalte(3, p_s, 2, p_s)
  switch_spalte(3, p_s, 0, p_s)
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
  # dreht eine oberfläche des Würfels im Uhrzeigersinn
  # front back top bottom left right sind die seiten. Nummerierung beginnt mit 0
  matrix = [6 ,3, 0, 7, 4, 1, 8, 5, 2]
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
    switch_sides(2, 1)
    switch_sides(2, 3)
    switch_sides(0, 2)
    rotr_surf(5)
    rotr_surf(4)
    rotr_surf(4)
    rotr_surf(4)
  when "down"
    3.times do
      switch_sides(2, 1)
      switch_sides(2, 3)
      switch_sides(0, 2)
      rotr_surf(5)
      rotr_surf(4)
      rotr_surf(4)
      rotr_surf(4)
    end
  when "clock"
    #viewed from the top
    switch_sides(0, 4)
    switch_sides(0, 1)
    switch_sides(5, 0)
    rotr_surf(2)
    3.times do
      rotr_surf(3)
    end
    rotr_surf(2)
  when "counter_clock"
    3.times do
      switch_sides(0, 4)
      switch_sides(0, 1)
      switch_sides(5, 0)
      rotr_surf(2)
      3.times do
        rotr_surf(3)
      end
    else
      fail "Falscher parameter"
    end
  end
end



public
def turn_counter_clock(zle)
  case zle
  when 0
    cntr_clock(0)
    3.times do
      rotr_surf(2)
    end
  when 1
    cntr_clock(3)
  when 2
    cntr_clock(6)
    rotr_surf(3)
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
    rotr_surf(4)
    rotr_surf(4)
  when 1
    3.times do
      prim_down(1)
    end
  when 2
    3.times do
      prim_down(2)
    end
    rotr_surf(5)
  end
end


public
def turn_down(splte)
  turn_up(splte)
  turn_up(splte)
  turn_up(splte)
end
  

end

    
a = Wuerfel.new
a.display
a.turn_clock(0)
a.display
checkcube = a.dup
a.turn_down(0)
a.turn_up(0)
a.turn_clock(1)
a.turn_counter_clock(1)
a.rot_cube("up")
a.rot_cube("down")
a.rot_cube("clock")
a.rot_cube("clock")
a.rot_cube("clock")
a.rot_cube("clock")
if checkcube==a
  puts "funktioniert"
else
  puts "nein"
end




























    
  

                                        
                                          
