inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

left(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

right(side::HorizonSide) = HorizonSide(mod(Int(side) - 1, 4))



function Back!(r::Robot, side::HorizonSide, num_steps::Int)
    while num_steps > 0
        move_if_possible!(r, side)
        num_steps -= 1
    end
end



function movements!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
    end 
end

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

function movements!(r::Robot, side::HorizonSide, num_steps::Int)
    for i in 1:num_steps
        move!(r, side)
    end 
end

# on particular digits of steps move to the.....
function digit_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while !isborder(r, side) 
        move!(r, side) 
        num_steps += 1    
    end
    return num_steps
end

function digit_movements!(r::Robot, side::HorizonSide,num_steps::Int)
    num_steps = 0
    while !isborder(r, side) 
        move!(r, side) 
        num_steps += 1    
    end
    return num_steps
end

function putmarkers!(r::Robot, side::HorizonSide,num::Int)
    for _ in 1:num
        putmarker!(r)
        move!(r,side)
    end
    putmarker!(r)
end







# Перемещает робота в заданном направлении, если это возможно, и возвращает true,
# если перемещение состоялось; в противном случае - false.

function move_if_possible!(r::Robot, now_side::HorizonSide)::Bool
    # в направлении now_side не встретилось перегородки
    if !isborder(r, now_side)
        move!(r, now_side)
        return true
    end

    # в направлении now_side есть перегородка => начинается ее обход
    left_side = left(now_side)
    right_side = inverse(left_side)
    num_steps = 0

    while isborder(r, now_side)
        #print(num_steps)
        if !isborder(r, left_side)
            move!(r, left_side)
            num_steps += 1
        else
            movements!(r, right_side, num_steps)
            return false # робот пришел в угол
        end
    end

    move!(r, now_side)

    while isborder(r, right_side)
        if !isborder(r, now_side)
            move!(r, now_side)
        else
            movements!(r, left_side, num_steps)
            return false # робот пришел в угол
        end
    end

    for i in 1:num_steps
        move!(r, right_side)
    end 
    
    return true
end