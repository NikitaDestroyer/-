function mark_all(r::Robot)
    count_horizont = moves!(r, West)
    count_verticale = moves!(r, Sud)
  
    flag =  mod(count_horizpnt + count_verticale, 2)
    put_all_markers(r, flag)
  
    moves!(r, Sud)
    back(r, Ost, count_horizont)
    back(r, Nord, count_verticale)
  end
  
  function put_all_markers(r::Robot, flag::Int)
    while true
        while !isborder(r, Ost)
            if  flag== 0
                putmarker!(r)
                flag = 1
            else
                flag = 0
            end
            move!(r, Ost)
        end
  
        if !check_last_cell(r)
            move!(r, Ost)
            putmarker!(r)
        end
  
        moves!(r, West)
  
        if !isborder(r, Nord)
            move!(r, Nord)
        else
            break
        end
    end
  end
  
  # cheking last cell on existence of marker , returning true or false
  function check__last_cell(r::Robot)
    move!(r, West)
    return ismarker(r)
  end
  
  function moves!(r::Robot, side::HorizonSide)
    count = 0
    while !isborder(r, side)
        move!(r, side)
        count += 1
    end
    return count
  end
  
  # back to where i belong to
  function back(r::Robot, side::HorizonSide, steps::Int)
    for i = 1:steps
        move!(r, side)
    end
  end