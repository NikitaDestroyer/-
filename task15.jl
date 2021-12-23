include("rob_lib.jl")
# perimetr have all it markerito

function mark_frame_perimetr!(r::Robot)
    num_verticale = moves!(r, Sud)
    num_horizont = moves!(r, West)

    for i in 3:6
        putmarkers!(r, HorizonSide(i % 4)) # particular sides we want 1 0 3 2
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

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end