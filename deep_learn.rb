class DeepLearning
	require './neural_network'
  attr_accessor :deep_net

	def initialize(network,inputs,weights,outputs)
		@network = network
		@inputs = inputs
		@outputs = outputs
		@weights = weights
		@deep_net = []
	end

	def train(number_of_times)
		@outputs.each do |output|
		  n = @network.new(@inputs,@weights,output)
		  n.train(number_of_times)
		  @deep_net << n
		end
	end

	def test(input)
		@deep_net.map {|net| net.test(input) }.flatten
	end
end