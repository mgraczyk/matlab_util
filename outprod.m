function res = outprod(u, v)
%
% returns u⊗v
%

udims = fix_ndims(u);
res = bsxfun(@times, u, permute(v, circshift(1:(udims + fix_ndims(v)), [0, udims])));

end

function dims = fix_ndims(x)
    dims = isvector(x) + ~isvector(x) * ndims(x);
end
