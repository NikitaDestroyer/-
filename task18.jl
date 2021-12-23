include("rob_lib.jl")
# and so this talse begins we mark all thr mark_corners
function mark_corners!(r::Robot)
    num_verticale = moves!(r, Sud)
    num_horizont = moves!(r, West)

    for i in 3:6
        putmarker!(r)
        movements!(r, HorizonSide(i % 4)) # that is out pioritat cuuse  1 0 3 2
    end

    Back!(r, Nord, num_verticale)
    Back!(r, Ost, num_horizont)
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while move_if_possible!(r, side)
        num_steps += 1
    end
    return num_steps
end