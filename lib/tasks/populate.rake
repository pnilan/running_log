task populate_types: :environment do
	Type.delete_all
	types = ["", "Recovery", "Tempo", "Warm up", "Cool down", "Fartlek", "Interval", "Easy", "Endurance"]
	types.each do |type|
		Type.create(name: type)
		puts "New type added: #{type}."		
	end
end