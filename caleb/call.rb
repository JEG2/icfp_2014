#!/usr/bin/ruby
require_relative "./Discovermap"

testmap= [ 
[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
[ 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 ],
[ 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0 ],
[ 0, 3, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 3, 0 ],
[ 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 ],
[ 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 0 ],
[ 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0 ],
[ 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0 ],
[ 0, 1, 1, 1, 0, 2, 0, 1, 1, 1, 1, 6, 1, 1, 1, 1, 0, 2, 0, 1, 1, 1, 0 ],
[ 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0 ],
[ 0, 1, 1, 1, 1, 2, 1, 1, 0, 1, 6, 6, 6, 1, 0, 1, 1, 2, 1, 1, 1, 1, 0 ],
[ 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0 ],
[ 0, 1, 1, 1, 0, 2, 0, 1, 1, 1, 1, 4, 1, 1, 1, 1, 0, 2, 0, 1, 1, 1, 0 ],
[ 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0 ],
[ 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 ],
[ 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0 ],
[ 0, 3, 2, 2, 0, 2, 2, 2, 2, 2, 2, 5, 2, 2, 2, 2, 2, 2, 0, 2, 2, 3, 0 ],
[ 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0 ],
[ 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0 ],
[ 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0 ],
[ 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0 ],
[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
]

testLambdaMan = [[0],[16,11],[0],[3][5]]
testGhosts = [ 
              [GHOST_VITALITY[:standard],[8,11],DIRECTIONS[:up]],
              [GHOST_VITALITY[:standard],[10,12],DIRECTIONS[:up]],
              [GHOST_VITALITY[:standard],[10,11],DIRECTIONS[:up]],
              [GHOST_VITALITY[:standard],[10,10],DIRECTIONS[:up]]
             ]

mymap = Discovermap.new(testmap,testLambdaMan,testGhosts)
puts mymap
p MAP.invert[mymap.get_cell_contents(16,11)]
p MAP.invert[mymap.get_cell_contents(8,11)]
p MAP.invert[mymap.get_cell_contents(10,12)]
p MAP.invert[mymap.get_cell_contents(10,11)]
p MAP.invert[mymap.get_cell_contents(10,10)]
p mymap.get_cell_contents(1,1) 
p mymap.get_available_moves(1,1) 
puts "lambdaman position"
p mymap.get_lambdaman_position()
p mymap.get_ghost_locations()
