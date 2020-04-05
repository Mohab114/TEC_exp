function activecheck = ACT_activecheck(h)

    active = h.GetStatusBits_Bits(0);
    activecheck = bitget(abs(active),5)||bitget(abs(active),6);
    while activecheck == 1
        pause(0.1)
        active = h.GetStatusBits_Bits(0);
        activecheck = bitget(abs(active),5)||bitget(abs(active),6);
    end
    
end
