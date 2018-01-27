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


weights = []#Array.new(10).map {|a| rand }
10.times { weights << Array.new(4,rand) }
weights = weights.transpose
initial_weights = weights.dup

biases = Array.new(10,rand)

1.times do
	test_data.each_with_index do |input,index|
		l0 = sigmoid(summation(input,weights))
		error = outputs[index].map.with_index {|o,mindex| o-l0[mindex] }
		slope = derivative(input)
		weights = weights.map {|l1| l1*error.sample }
		#weights = summation_if_not_0(weights,slope)
	end
end

puts "Initial weights: #{initial_weights}" 
puts "Final weights: #{weights}"

puts "Testing neural network:"

test_data.each_with_index do |input,index|
	puts "Input: #{input}"
	puts "Expected Output:: #{outputs[index]}"
	output = sigmoid(summation(input,weights)).map {|o| (o < 0.5) ? 0 : 1 }
	puts "Output given by neural network: #{output}"
	puts output==outputs[index] ? "Pass" : "Fail"
end