using HorizonSideRobots


function mark_kross(r::Robot)
    for side1 in 0:3
        side2 = (side1+1)%4
        move_forward!(r, side1, side2)
        back!(r, inverse(side1),inverse(side2))
    end
    putmarker!(r)
end

function move_two!(r, side1, side2)
	move!(r, HorizonSide(side1))
	move!(r,  HorizonSide(side2))
end


function movements!(r, side1, side2)
    while !(isborder(r,HorizonSide(side1)) || isborder(r,HorizonSide(side2)))
        move_twice!(r, side1, side2)
        putmarker!(r)
    end
end

function back!(r, side1, side2)
    while ismarker(r)
        move_twice!(r, side1, side2)
    end
end

function inverse(side)
    return mod(side+2, 4)
end

mark_x_cross(r)