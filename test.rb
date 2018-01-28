require './neural_network'
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

outputs = [0,0,0,0,0,0,0,0,1,1]

weights = Array.new(10).map {|a| rand }

network = NeuralNetwork.new(test_data,weights,outputs)
network.train(500)
test_index = (0..9).to_a.sample
o = network.test([test_data[test_index]])

puts o[0] == outputs[test_index] ? "Pass" : "Fail"