function mark_labyrinth!(r)  
    
    if isborder(r,side)

    else
        putmarker!(r)
        for side in (Nord, West, Sud, Ost)
            try_move!(r, side)
            mark_labyrinth!(r)
            move!(r, inverse(side)) 
        end
    end
end


function try_move!(r,side)
    if isborder(r,side)
        return
    else 
        move!(r,side)
    end
end