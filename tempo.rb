module Tempo
	
	def Tempo.horario
		"#{Time.now.hour}:#{Time.now.min} #{Time.now.sec} #{cut(Time.now.nsec, 0, 4)}"
	end

	private
	def self.cut(number, first, last)
		"#{number}"[first,last]
	end

end
