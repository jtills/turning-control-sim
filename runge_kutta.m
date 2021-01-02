function x = RungeKatta(modelname,h,x,dV)
    k1 = h*feval(modelname,x,dV);
    k2 = h*feval(modelname,x+k1/2,dV);
    k3 = h*feval(modelname,x+k2/2,dV);
    k4 = h*feval(modelname,x+k3,dV);
    x = x +(k1+2*(k2+k3)+k4)/6;
end