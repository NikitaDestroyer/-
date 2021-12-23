function count_markers_temp(r::Robot)
    count = 0
    sum = 0
    side = Ost
    (n_sum, n_count) = line(r, side)
    sum += n_sum
    count += n_count
    while !isborder(r, Nord)
        move!(r, Nord)
        side = inverse(side)
        (n_sum, n_count) = line(r, side)
        sum += n_sum
        count += n_count
    end
    return (sum, count)
end
  
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))


# have a stride by the line shore and have all the markers sammeln and return tuple of temp and count
function line(r::Robot, side::HorizonSide)
    count = 0
    sum = 0
    while !isborder(r, side)
        if ismarker(r)
            count += 1
            sum += temperature(r)
        end
        move!(r, side)
    end
  
    if ismarker(r)
        count += 1
        sum += temperature(r)
    end
  
    return (sum, count) # tuple of digits
end
# вычисление 
function middle(r::Robot)
    (sum, count) = count_markers_temp(r)
    if count == 0
        print(0)
    else
        print(sum / count)
    end
  end