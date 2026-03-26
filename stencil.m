function D = stencil(p,h)
% DiffStencil approximates the pth derivative at a point by taking a linear
% combination of function values expressed in terms of the relative shifts
% of those known function values. For example, to determine the first
% derivative of a function at x using the points (x-1,f(x-1)), (x,f(x)),
% and (x+1,f(x+1)), you would evaluate:
% 
% DiffStencil(1,[-1,0,1])
%
% The output of the command is a vector whose elements match the elements
% of h and provide the proper weights at which to take the linear
% combination. The output of the example is [-0.5,0,0.5], meaning that the
% linear combination that approximates the first derivative using these
% three points is:
%
% f'(0) = -0.5f(x-1)+0.5f(x+1)
%
% Which corresponds to the centered secant approximation.

n = length(h);
A = sym(zeros(n,n));
for i = 1:n
    for j = 1:n
        A(i,j) = (h(j))^(i-1)/factorial(i-1);
    end
end
deltas = zeros(n,1);
deltas(p+1,1) = 1;
A = cat(2,A,deltas);
A = rref(A);
D = double(A(:,end))';
end