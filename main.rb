#!//usr/local/bin/ruby
require 'thread'
require_relative 'produtor'
require_relative 'consumidor'

unless ARGV[1]
	puts "Informe os argumentos!"
	puts "1 -> tempo de espera dos produtores"
	puts "2 -> tempo de espera dos consumidores"
	exit
end

begin
	TempoProdutores = Integer(ARGV[0])
	TempoConsumidores = Integer(ARGV[1])

	if (TempoProdutores < 0 or TempoConsumidores < 0)
		raise ArgumentError
	end

rescue ArgumentError
	puts "Os argumentos devem ser valores numericos positivos!"
	exit
end

queue = Queue.new
lista1 = ["bola", "carro", "banana", "bicicleta", "abacaxi", "cama", "sofa"]

#produtores
produtores = []
4.times do |numero|
	produtores << Produtor.new("produtor_#{numero}", lista1, queue)
end

#consumidores
consumidores = []
6.times do |numero|
	consumidores << Consumidor.new("consumidor_#{numero}", queue)
end

#codigo a ser executado na thread dos produtores
codigoThProdutor = lambda do |produtor|
	loop do
		begin
			produtor.produzir!
			sleep(TempoProdutores)
		end
	end
end

#codigo a ser executado na thread dos consumidores
codigoThConsumidor = lambda do |consumidor|
	loop do
		begin
			consumidor.consumir!
			sleep(TempoConsumidores)
		end
	end
end

#gerando thread de produtores
puts "Inicializando produtores..."
thProdutores = []
produtores.each do |produtor|
	thProdutores << Thread.new(produtor, codigoThProdutor) do |produtor, executor|
		executor.call produtor
	end
end

#gerando thread de consumidores
puts "Inicializando consumidores..."
thConsumidores = []
consumidores.each do |consumidor|
	thConsumidores << Thread.new(consumidor, codigoThConsumidor) do |consumidor, executor|
		executor.call consumidor
	end

end

thProdutores.each(&:join)
thConsumidores.each(&:join)
















