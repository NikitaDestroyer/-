# we should find sole marker on infinite field without borders and so

# count value ++ when its bigger geworden,  we move in digit horizonside
function find_marker(r::Robot)
    count = 1
    while !ismarker(r)
        for i = 0:1
            move_side(r, count, HorizonSide(i))
        end
        count += 1
        for i = 2:3
            move_side(r, count, HorizonSide(i))
        end
        count += 1;
    end
end
  
# move in side count times
function move_side(r::Robot, count::Int, side::HorizonSide)
    for i = 1:count
        if ismarker(r)
            break
        end
        move!(r, side)
    end
end