function [val, isterm, dir] = evn(t,z,p)


% val =  z(1:length(z)/2).^2 - 24; 
% isterm = ones(length(z)/2,1); 
% dir = ones(length(z)/2,1);

dim = length(z)/4;
x = z(1:dim);
y = z(dim+1: dim*2);

di = triu((x - x').^2 + (y - y').^2);
di = di(:);
di(di==0) = [];

val = [di - 0.000005; toc - 15];
isterm = [ones(size(di));1];
dir = [zeros(size(di)); 1];
end