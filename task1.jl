using HorizonSideRobots

function make_cross(r::Robot)
    for side in (Sud,West,Ost,Nord)
        putmarkers!(r,side)
        move_markers(r,inverse(side))
    end
end
function putmarkers!(r::Robot,side::HorizonSide)
    while  isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function move_markers(r::Robot,side::HorizonSide)
    while ismarker(r)==true
        move!(r,side)
    end
end

function inverse(side::HorizonSide)
    new_side=HorizonSide(mod(Int(side)+2,4))
    return new_side
end