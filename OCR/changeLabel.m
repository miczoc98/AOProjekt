function m = changeLabel(m, v1, v2)
 m(m==v1) = v2; 
 for i=v1+1:max(m, [], 'all')
    m(m==i) = i-1;
 end
end