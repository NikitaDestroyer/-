function inverse(side::HorizonSide)
    new_side=HorizonSide(mod(Int(side)+2,4))
    return new_side
end

function movements!(r,side,n::Int)
    for n in 1:n+1
        move!(r,side)
    end
end


function  shuttle!(r, side)
    n=0 
    side=Ost
    while isborder(r,Nord)
        n += 1
        movements!(r, side, n)
        side = inverse(side)
    end
end