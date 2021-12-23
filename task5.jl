

function corner_marker(r::Robot)
  mass = []
  go_to_nord_ost(r, mass) # Занять угол
  mark_corners!(r) # Покрасить углы
  back(r, mass) # Вернуться в начальное положение
end



function go_to_nord_ost(r::Robot, mass::Array)
  while isborder(r, Nord) == false || isborder(r, Ost) == false
    move_if_Possible!(r, mass, Nord)
    move_if_Possible!(r, mass, Ost)
  end
  # Nord Ost ist lage(DE)
end

function moves!(r::Robot, side::HorizonSide)
  while !isborder(r, side)
    move!(r, side)
  end  
end

function mark_corners!(r::Robot) 
  for side in (Sud, West, Nord, Ost)
    moves!(r, side)
    putmarker!(r)
  end
end

function inverse(side::HorizonSide)
  return HorizonSide(mod(Int(side) + 2, 4))
end

function back(r::Robot, mass::Array)
  while length(mass) > 0
    last_move = mass.pop()
    move!(r, inverse(last_move))
  end
end

function move_if_Possible!(r::Robot, mass::AbstractArray, side::HorizonSide)
  if !isborder(r, side)
      move!(r, side)
      push!(mass, side)
  end    
end