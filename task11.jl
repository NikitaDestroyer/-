using HorizonSideRobots

function mark_cells(r)
    for side in 0:3
        digits = move_through_barrier!(r, side)
        putmarker!(r)
        back!(r, digits, side)
    end            
end


function move_through_barrier!(r, side)
    digits = []
    while (length(digits)==0 || digits[length(digits)]!=0)
        count1 = 0
        count2 = 0
        count3 = 0
        while !isborder(r, HorizonSide(side))
            move!(r, HorizonSide(side))
            count1+=1
        end
        while (isborder(r, HorizonSide(side)) && !isborder(r, HorizonSide((side+1)%4)))
            move!(r, HorizonSide((side+1)%4))
            count2 += 1
        end
        if !isborder(r, HorizonSide(side))
            move!(r, HorizonSide(side))
            count3 += 1
            while isborder(r, HorizonSide((side+3)%4))
                move!(r, HorizonSide(side))
                count3 += 1
            end
            for i in 1:count2
                move!(r, HorizonSide((side+3)%4))
            end
        else 
            for i in 1:count2
                move!(r, HorizonSide((side+3)%4))
            end
            count2 = 0
        end
        push!(digits,count1)
        push!(digits,count2)
        push!(digits,count3)
        push!(digits,count2)
    end
    return digits   
end


function movements!(r, side, count)
    for i in 0:count-1
        move!(r, HorizonSide(side))
    end
end


function back!(r, digits, side)
    digits = reverse(digits)
    for i in 1:length(digits)
        rside = side
        if i%2 == 1
            rside = (rside+i)%4
        else
            rside = (rside+2)%4
        end
        movements!(r, rside, digits[i])
    end
end

mark_cells(r)