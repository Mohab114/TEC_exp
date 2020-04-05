function ACT_home(h)
    h.MoveHome(0,1); % Home the stage. First 0 is the channel ID (channel 1)
                 % second 1 is to prevent the function from returning
    pause(1);                  
%     active = h.GetStatusBits_Bits(0);
%     activecheck = bitget(abs(active),5)||bitget(abs(active),6);
%     pause(20)
% 
%     %this loop waits for the motor to get to home position and stay stationary
%     %however, when the motor goes to the home position, it goes -1 mm to the -ve
%     %direction and then stops (temporary) and then goes to the home (zero position). So we 
%     %need to account for this temporary stop by doing the same loop again 
%     while (activecheck == 1)
%         pause(0.5)
%         active = h.GetStatusBits_Bits(0);
%         activecheck = bitget(abs(active),5)||bitget(abs(active),6);
%     end
%     pause(2)
%     active = h.GetStatusBits_Bits(0);
%     activecheck = bitget(abs(active),5)||bitget(abs(active),6);
%     while (activecheck == 1)
%         pause(0.5)
%         active = h.GetStatusBits_Bits(0);
%         activecheck = bitget(abs(active),5)||bitget(abs(active),6);
%     end

end