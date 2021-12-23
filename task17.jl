include("rob_lib.jl")

function mark_pyramid(r::Robot)
    num_verticale = digit_movements!(r, Sud)
    num_horizont = digit_movements!(r, West)

    side = Ost
    all_steps = digit_movements!(r, Ost)
    max_steps = all_steps
    digit_movements!(r, West)
# while we arent in the corner we cant reach thr satisfaction
    while !(isborder(r, Nord) && (isborder(r, Ost) || isborder(r, West)))
        now_steps = digit_movements!(r, Ost, max_steps)
        digit_movements!(r, West)
        putmarker!(r)
        putmarkers!(r, side, now_steps)
        Back!(r, inverse(side), now_steps)
        move!(r, Nord)
        max_steps -= 1
    end

    now_steps = digit_movements!(r, Ost, max_steps)
    digit_movements!(r, West)
    putmarker!(r)
    putmarkers!(r, side, now_steps)

    digit_movements!(r, Sud)
    digit_movements!(r, West)

    Back!(r, Nord, num_verticale)
    Back!(r, Ost, num_horizont)
end