beginning = Time.now

count = 0
vertices = Hash.new(false)
sides = Hash.new(false)
curr_vertices = []

File.open(ARGV[0]).each_line do |line|
	if line.start_with?("vertex")
		count += 1
		line = line.split(" ")
		line_vertex = line[1..3]
		
		# vertex-counting logic
		unless vertices[line_vertex]
			vertices[line_vertex] = true
		end
		
		# side-counting logic
		curr_vertices << line_vertex
		if curr_vertices.count == 3
			curr_sides = curr_vertices.combination(2).to_a
			
			curr_sides.each do |side|
				side.sort!
				unless sides[side]
					sides[side] = true
				end
			end
			
			curr_vertices = []
		end
	end
end

if count % 3 != 0
	raise "number of vertices not divisible by 3"
end

faces = count/3
vert_num = vertices.count
side_num = sides.count

puts "faces: #{faces}, sides: #{side_num}, vertices: #{vert_num}"

puts "Time elapsed #{Time.now - beginning} seconds"