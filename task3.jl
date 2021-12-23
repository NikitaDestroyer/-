


function marker_find(r,side)
    move!(r,side)
    if ismarker(r)
        return false
    else
        return true
    end
end

left(side::HorizonSide) = HorizonSide(mod(Int(side::HorizonSide)+1, 4))

function movements!(r,side)
    while !isborder(r,side)
        putmarker!(r)
        move!(r,side)
    end
    putmarker!(r)
end

function west_sud(r)
    while !isborder(r,West) || !isborder(r,Sud)
        if !isborder(r,West)
            move!(r,West)
        else
            move!(r,Sud)
        end
    end
end

left(side::HorizonSide) = HorizonSide(mod(Int(side::HorizonSide)+1, 4))

function inverse(side::HorizonSide)
    new_side=HorizonSide(mod(Int(side)+2,4))
    return new_side
end



function invert(r,side)
    if isborder(r,West)
        side = right(side)
        move!(r,side)
        side=right(side)
        return side 
    end 
    if isborder(r,Ost)
        side = left(side)
        move!(r,side)
        side=left(side)
        return side 
    end
end



function mark_all(r)  
    west_sud(r)
    side=Ost
    movements!(r,side)
    while !isborder(r,Nord)
        side=invert(r,side)
        movements!(r,side)
    end
end   