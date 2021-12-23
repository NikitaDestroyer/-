include("rob_lib.jl")

function mark_it_all(r::Robot)
    num_verticale = digit_movements!(r, Sud)
    num_horizont = digit_movements!(r, West)

    side = Nord

    # while we dont reach the corner
    while !(isborder(r, Ost) && (isborder(r, Ost) || isborder(r, Sud)))
        putmarker!(r)
        putmarkers!(r, side)
        move!(r, Ost)
        side = inverse(side)
    end

    putmarker!(r)
    putmarkers!(r, side)

    digit_movements!(r, Sud)
    digit_movements!(r, West)

    Back!(r, Nord, num_verticale)
    Back!(r, Ost, num_horizont)
end