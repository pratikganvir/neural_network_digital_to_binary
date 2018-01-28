require './sigmoid'
require './summation'
require './derivative'
require 'byebug'

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

# outputs = [
# [0,0,0,0],
# [0,0,0,1],
# [0,0,1,0],
# [0,0,1,1],
# [0,1,0,0],
# [0,1,0,1],
# [0,1,1,0],
# [0,1,1,1],
# [1,0,0,0],
# [1,0,0,1]
# ]

outputs = [0,0,0,0,0,0,0,0,1,1]

weights = Array.new(10).map {|a| rand }
# 10.times { weights << Array.new(4,rand) }
# weights = weights.transpose
initial_weights = weights.dup

biases = Array.new(10,rand)
puts weights.join(', ')

100.times do |outer_index|
	#test_data.each_with_index do |input,index|
		l0 = sigmoid(matrix_multiplication(test_data,weights))
		error = outputs.map.with_index {|o,mindex| o-l0[mindex] }
		slope = derivative(l0)
		new_weights = product_one_dimensional(error,slope)
		weights = add_arrays(weights,new_weights)
		puts weights.join(', ')
	#end
end

puts "Initial weights: #{initial_weights}" 
puts "Final weights: #{weights}"

puts "Testing neural network:"

test_data.each_with_index do |input,index|
	puts "Input: #{input}"
	puts "Expected Output:: #{outputs}"
	output = sigmoid(matrix_multiplication(test_data,weights)).map {|o| (o < 0.5) ? 0 : 1 }
	puts "Output given by neural network: #{output}"
	puts output==outputs ? "Pass" : "Fail"
end