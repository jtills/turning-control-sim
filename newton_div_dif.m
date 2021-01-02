function f = newtondivdif(Vt,t)
syms x f(x) difference        	%syms values
new_Vt = Vt;                  	%copies Vt for manipulation in a_matrix
k = length(t)-1;              	%initializes counter for a_matrix rows
n=k;                          	%copies counter k for for loop iterations
i = 0 ;                       	%starts counter for denominator of a values
 
for col = 1:n                 	%creates a_matrix one column/time using Vt_new
    for row = 1:k	
        num = (new_Vt(row+1)-new_Vt(row));    %numerator 
        den = (t(row+1+i)-t(row));            %denominator
        a_matrix(row,col) = num/den;	      %creates a_matrix
        new_Vt(row) = a_matrix(row,col);      %changes Vt_new to new a values 	
    end 
    i = i + 1;
    k = k - 1;
end
 
a = [Vt(1) a_matrix(1,:)];       %creates c array to be used in final formula 
f(x) = a(1);                     %initial value for f
x_difference = 1;                %initial value for x_difference
 
for col = 1:n                     
    x_difference = x_difference*(x-t(col));%compiles x_differences
    f(x) = f(x) + a(col+1)*x_difference;   %multiplies each by corresponding aval 
end
f = matlabFunction(f(x));         	   %creates and returns MATLAB function
end



