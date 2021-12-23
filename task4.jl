function mark_pyramid(r::Robot)
    count_horizont = moves!(r, West)
    count_verticale = moves!(r, Sud)
  
    len = moves!(r, Ost)
    moves!(r, West)
  
    put_all_markers(r, len)
  
    moves!(r, Sud)
    Back(r, Ost, count_horizont)
    Back(r, Nord, count_verticale)
  end
  
function put_markers(r::Robot, len::Int)
  while true
      for i = 1:len
          putmarker!(r)
          move!(r, Ost)
      end
      putmarker!(r)
  
        moves!(r, West)
  
      if !isborder(r, Nord)
            move!(r, Nord)
      else
          break
      end
  
      len -= 1
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
  
function Back(r::Robot, side::HorizonSide, steps::Int)
  for i = 1:steps
      move!(r, side)
  end
end