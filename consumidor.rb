require_relative 'tempo'
class Consumidor
	
	#construtor
	def initialize(nome, queue)
		@nome = nome
		@queue = queue
		@mutex = Mutex.new
	end	

	def consumir!
		objConsumido = nil
		@mutex.synchronize do
			objConsumido = @queue.pop
			puts "#{@nome} as #{Tempo.horario} consumiu #{objConsumido}"
			puts "Queue size = #{@queue.length}"
		end
	end

end
