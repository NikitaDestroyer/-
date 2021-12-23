inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function mark_perimetr!(r::Robot)
  num_steps = fill(0, 3)

  for (i, side) in enumerate((Sud, West, Sud))
      num_steps[i] = moves!(r, side)
  end

  side = where_border!(r, Ost, Nord)

  mark_perimetr(r, side)

  moves!(r, Sud)
  moves!(r, West)

  for (i, side) in enumerate((Nord, Ost, Nord))
      moves!(r, side, num_steps[i])
  end
  
end

function where_border!(r::Robot, dir_of_border::HorizonSide, dir_of_movement::HorizonSide)
  while !isborder(r, dir_of_border) 
      if !isborder(r, dir_of_movement)
          move!(r, direction_of_movement)
      else
          move!(r, dir_to_border)
          dir_of_movement = inverse(dir_of_movement)
      end
  end
  return dir_of_movement
end

function mark_perimetr(r::Robot, side::HorizonSide)
  move!(r, inverse(side))

  if side == Sud
      for (i, now_side) in enumerate((Sud, Ost, Nord, West))
          move!(r, now_side)
          putmarkers!(r, Int(now_side))
          putmarker!(r)
      end
  else
      for (i, now_side) in enumerate((Nord, Ost, Sud, West))
          move!(r, now_side)
          putmarkers!(r, Int(now_side))
      end
  end
end

function putmarkers!(r::Robot, side::Int)
  while isborder(r, HorizonSide(mod(side + 1, 4)))
      putmarker!(r)
      move!(r, HorizonSide(side))
  end
end

function moves!(r::Robot, side::HorizonSide)
  count = 0
  while !isborder(r, side)
      move!(r, side)
      count += 1
  end
  return count
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
  for i = 1:num_steps
      move!(r, side)
  end
end

