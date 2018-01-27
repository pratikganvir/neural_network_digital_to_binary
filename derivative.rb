require 'matrix'
def derivative(x)
	if x.is_a?(Array)
		x1 = x.map {|x1| 1.0-x1.to_f }
		product = []
	  x1.length.times {|index| product.push(x1[index].to_f*x[index].to_f)}
	  product
	else
		x.to_f*(1.0-x.to_f)
	end
end