require './neural_network'
require './deep_learn'
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

weights = Array.new(10).map {|a| rand }

network = DeepLearning.new(NeuralNetwork,test_data,weights,outputs.transpose)
network.train(500)
test_index = (0..9).to_a.sample
o = network.test([test_data[test_index]])
puts o == outputs[test_index] ? "Pass" : "Fail"