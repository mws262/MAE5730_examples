function [value,isterminal,direction] = bounceEvent(t,z,p)

value = z(1); % Trigger when height gets to 0.
isterminal = true; % Stop integrating when this happens.
direction = -1; % Trigger when going negative (not positive)

end

