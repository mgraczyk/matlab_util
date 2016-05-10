function [str] = mat2eigen_str(arr)
  is_complex = any(reshape(imag(arr) ~= 0, 1, []));

  if isa(arr, 'single')
    if is_complex
      f = @print_complex_single;
    else
      f = @print_single;
    end
  else
    if is_complex
      f = @print_complex_double;
    else
      f = @print_double;
    end
  end

  str = serialize(arr, numel(size(arr)), f);
end

function [str] = sign_str(val)
  if sign(val) >= 0
    str = '+';
  else
    str = '-';
  end
end

function [str] = print_double(val)
  str = sprintf('%+.17f', val);
end

function [str] = print_single(val)
  str = sprintf('%+.8ff', val);
end

function [str] = print_complex_double(val)
  str = sprintf('%+.17f %s %.17fi', real(val), sign_str(imag(val)), abs(imag(val)));
end

function [str] = print_complex_single(val)
  str = sprintf('%+.8ff %s %.8fif', real(val), sign_str(imag(val)), abs(imag(val)));
end

function [str] = serialize(arr, dim_sz, print_func)
  if dim_sz == 0
    str = print_func(arr);
    return;
  elseif dim_sz == 2
    sep = '\n';
  else
    sep = ', ';
  end

  indexer = cell(1, numel(size(arr)));
  indexer(:) = {':'};

  str = '';
  for i = 1:size(arr, 1)
    indexer{1} = i;
    str = [str, serialize(...
        shiftdim(arr(indexer{:}), 1), dim_sz - 1, print_func), sep];
  end
end

