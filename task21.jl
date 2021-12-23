using HorizonSideRobots

function count_barriers(r::Robot)
    ans = 0
    move_while_can(r, (West, Sud))
    dir = Ost
    ans += process_row(r, dir, Nord)
    while !isborder(r, Nord)
        move!(r, Nord)
        dir = inverse(dir)
        ans += process_row(r, dir, Nord)
    end
    move_while_can(r, (West, Nord))

    dir = Sud
    ans += process_row(r, dir, Ost)

    while !isborder(r, Ost)
        move!(r, Ost)
        dir = inverse(dir)
        ans += process_row(r, dir, Ost)
    end

    return ans - 2
end

function process_row(r::Robot, side, toCheckSide)
    cnt = 0
    flag = false
    while !isborder(r, side) || bypass(r, side)
        if isborder(r, toCheckSide)
            if !flag
                flag = true
                cnt += 1
            end
        else
            flag = false
        end
        if !isborder(r, side)
            move!(r, side)
        end
    end
    return cnt
end

function bypass(r::Robot, dir)
    bypass_dir = nextCounterClockwise(dir)
    inverse_bypass_dir = inverse(bypass_dir)
    num_steps = 0
    while !isborder(r, bypass_dir) && isborder(r, dir)
        move!(r, bypass_dir)
        num_steps += 1
    end
    if isborder(r, dir) && isborder(r,bypass_dir)
        moves!(r, inverse_bypass_dir, num_steps)
        return false
    end
    move!(r, dir)
    moves!(r, inverse_bypass_dir, num_steps)
    return true
    end

# move while it is possible for us
function move_while_can(r::Robot, sides)
    moving = true
    # it is possible to move
    while moving
        moving = false
        for side in sides
            if !isborder(r, side)
                move!(r, side)
                moving = true
            end
        end
    end
    end

###-------------------------------------------------------------------------
function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end
function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide) 
    while isborder(r, side) == false
        move!(r, side)  
        putmarker!(r)
    end

function move_markers!(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end

left(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))