function bariers_count(r::Robot)
    ans = 0
    move_while_can(r, (West, Sud)) # west sud
    dir = Ost
    ans += process_row(r, dir, Nord)
    while !isborder(r, Nord)     # идем змейкой
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

function process_row(r::Robot, side, to_check_side) # checking on the side for barriers
    count = 0
    flag = false
    while !isborder(r, side) || bypass(r, side)
        if isborder(r, to_check_side)
            if !flag
                flag = true   #меняем флаг на тру и фолс если почитали перегородку то1 , пока есть перегородка будет тру,есил что то поенятеся все обнулится и появится новая перегородка и снова каунт +1
                count += 1
            end
        else
            flag = false
        end
        if !isborder(r, side)
            move!(r, side)
        end
    end
    return count
end

function bypass(r::Robot, dir)        # проверяем можно ли пройти в ту сторну если можно то возвращаем тру в ином случае фолс, всегда вовращаемся
    bypass_dir = left(dir)
    inverse_bypass_dir = inverse(bypass_dir)
    num_steps = 0
while !isborder(r, bypass_dir) && isborder(r, dir) # while no border side of passing
    move!(r, bypass_dir)
    num_steps += 1                                # counting the steps of pass
end
if isborder(r, dir) && isborder(r,bypass_dir)
    moves!(r, inverse_bypass_dir, num_steps)     # move in inverse side of passing
    return false
end
move!(r, dir)
moves!(r, inverse_bypass_dir, num_steps)        # in any case we should come back
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