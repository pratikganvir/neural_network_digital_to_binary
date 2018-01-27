include Math
def sigmoid(z)
  if z.is_a?(Array)
  	(z.map {|z1| E**(0-z1)}).map {|z2| z2+1.to_f}.map {|z3| 1/z3}
  else
  	1.to_f/(1.to_f+E**(0-z.to_f))
  end
end