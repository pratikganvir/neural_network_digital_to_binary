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
		number_of_times.times do |outer_index|
			l0 = sigmoid(matrix_multiplication(@input,@weights))
			error = @output.map.with_index {|o,mindex| o-l0[mindex] }
			slope = derivative(l0)
			new_weights = product_one_dimensional(error,slope)
			@weights = add_arrays(@weights,new_weights)
			puts @weights.join(', ')
		end
	end

	def test(input_data)
    sigmoid(matrix_multiplication(input_data,@weights)).map {|t| (t < 0.5 ? 0 : 1) }
	end
end