class NeuralNetwork
	require './sigmoid'
	require './summation'
	require './derivative'
	require 'byebug'

	def initialize(input,weights,output)
		@input = input
		@weights = weights
		@output = output
	end

	def train(number_of_times = 1000)
		number_of_times.times.with_index do |i|
			puts "#{i/1000}%" if (!i.zero? && i%1000 == 0)
			l0 = sigmoid((Matrix[*@weights].transpose*Matrix[*@input].transpose).to_a)
			error = @output.zip(l0.transpose).map {|o,i| o.zip(i).map {|j,k| j-k }}
      new_weights = product_two_dimensional(derivative(l0),error.transpose)
      @weights = add_arrays_two_dimensional(@weights,product_two_dimensional(@weights.transpose,new_weights).transpose)
	  end
	end

	def matrix_multiplication(array1,array2)
	  array1.map {|a1| a1.zip(array2).map {|a,b| a*b }.sum }
	end

	def product_one_dimensional(array1,array2)
	  array2.zip(array1).map {|a1,a2| a1*a2 }
	end

	def product_two_dimensional(array1,array2)
	  array2.zip(array1).map {|a1,a2| product_one_dimensional(a1,a2) }
	end

	def cross_multiply_array(array1,array2)
		array1.zip(array2).map {|a1,a2| a1.map {|a3| a3*a2}}
	end

	def sigmoid(z)
	  if z.is_a?(Array)
	  	(z.map {|z1| sigmoid(z1)})
	  else
	  	1.to_f/(1.to_f+E**(0-z.to_f))
	  end
	end

	def derivative(x)
		if x.is_a?(Array)
			x.map {|x1| derivative(x1) }
		else
			x.to_f*(1.0-x.to_f)
		end
	end

	def product_one_dimensional(array1,array2)
	  array2.zip(array1).map {|a1,a2| a1*a2 }
	end

	def add_arrays(weights,new_weights)
	  weights.zip(new_weights).map {|w1,w2| w1+w2 }
	end

	def add_arrays_two_dimensional(weights,new_weights)
	  weights.zip(new_weights).map {|w1,w2| add_arrays(w1,w2) }
	end

	def test
		index = (0..@input.length).to_a.sample
		l0 = sigmoid((Matrix[*@weights].transpose*Matrix[*@input].transpose).to_a)
		received_output = l0.transpose[index].map {|l| (l > 0.5 ? 1 : 0)}
		puts "Expected Output: #{@output[index]}"
		puts "Received Output: #{received_output}"
		puts (@output[index]==received_output) ? "Pass" : "Fail"
	end
end


test_data = [
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,1,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,0,0,0,0,0,1,0],
[0,0,0,0,0,0,0,0,0,1]
]

outputs = [
[0,0,0,0],
[0,0,0,1],
[0,0,1,0],
[0,0,1,1],
[0,1,0,0],
[0,1,0,1],
[0,1,1,0],
[0,1,1,1],
[1,0,0,0],
[1,0,0,1]
]

weights = Array.new(10) { |i| Array.new(4) { rand } }

network = NeuralNetwork.new(test_data,weights,outputs)
network.train(1000)
test_index = (0..9).to_a.sample
o = network.test