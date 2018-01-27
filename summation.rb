def summation(array1,array2)
	array2.zip(array1).map {|a1,a2| a1.map {|a3| a3*a2}.sum }
end

def summation_if_not_0(array1,array2)
	product = []
  array1.length.times {|index| 
  	if array1[index].zero? || array2[index].zero?
  		if array1[index].zero?
  			product.push(array2[index]) 
  		else
  	    product.push(array1[index])
  	  end
	  else
	 	  product.push(array1[index]*array2[index])
	  end
  }
  product
end