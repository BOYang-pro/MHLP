function x_g = gradient(x,flag)
%1 水平 2 45度 3 垂直 4 135度

if flag == 1
    a = repmat(x,[1,2]);
    a = a(:,2:(end/2+1),:);
    x_g = a - x;
end

if flag == 2
    a = repmat(x,[2,2]);
    a = a(2:(end/2+1),2:(end/2+1),:);
    x_g = x - a;
end
    
if flag == 3
    a = repmat(x,[2,1]);
    a = a(2:(end/2+1),:,:);
    x_g = a - x;
end
    
if flag == 4
    a = repmat(x,[2,2]);
    a = a(2:(end/2+1),(end/2):end-1,:);
    x_g = x-a;
    x_g = repmat(x_g,[1,2]);
    x_g = x_g(:,2:(end/2+1));
end    