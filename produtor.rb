require_relative 'tempo'
class Produtor

	#construtor
	def initialize(nome, listaDeProdutos, queue)
		@nome = nome
		@lista = listaDeProdutos
		@queue = queue
		@mutex = Mutex.new
		
		srand 12345
	end

	def produzir!
		@mutex.synchronize do
			randomValue = @lista[rand(@lista.length)]
			@queue.push "#{randomValue} produzido por #{@nome} as #{Tempo.horario}"
			puts "#{@nome} produziu #{randomValue}"			
		end
	end

end
