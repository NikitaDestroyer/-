function try_move!(robot, side)::Bool
    if isborder(robot, side) 
        false
    else
        move!(robot, side) 
        true
    end
end

left(side::HorizonSide) = HorizonSide(mod(Int(side::HorizonSide)+1, 4))
function movements2(robot,side)
    while try_move!(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
end


function main(robot,side::HorizonSide)
    west_sud(robot)
    side=Ost
    for _ in 1:3
        movements2(robot,side)
        side=left(side::HorizonSide)
    end
end
function west_sud(robot)
    while try_move(r,West) || try_move(r,Sud)
        if try_move(r,West)
            move!(robot,West)
        else
            move!(r,Sud)
        end
    end
end





function mark_frame_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #УТВ: Робот - в Юго-Западном углу

    for side in (Nord, Ost, Sud, West)
        putmarkers!(r, side)
    end 
    #УТВ: По всему периметру стоят маркеры

    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
    #УТВ: Робот - в исходном положении
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end