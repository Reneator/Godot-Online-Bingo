extends GridContainer


export (int) var bingo_grid_size = 3

export (PackedScene) var bingo_element

var bingo_grid = []

var bingo_list = []

func _ready():
	columns = bingo_grid_size
	for y in range(bingo_grid_size):
		for x in range(bingo_grid_size):
			create_element(x, y)

func create_element(x, y):
	var element = bingo_element.instance()
	element.x = x
	element.y = y
	if bingo_grid.size() <= y:
		bingo_grid.append([])
	bingo_grid[y].append(element)	
	
	element.text = "%d, %d" %[x, y]
	element.connect("pressed", self, "on_bingo_button_pressed")
	add_child(element)

func on_bingo_button_pressed():
	check_for_bingo()

func check_for_bingo():
	check_x_rows()
	check_y_rows()
	check_diagonal()

func check_x_rows():
	for x_row in bingo_grid:
		var is_bingo = true
		for entry in x_row:
			is_bingo = entry.pressed and is_bingo
		if is_bingo:
			bingo()
			return

func check_y_rows():
	for y in range(bingo_grid_size):
		var is_bingo = true
		for x_row in bingo_grid:
			is_bingo = x_row[y].pressed and is_bingo
		if is_bingo:
			bingo()
			return

func check_diagonal():
	var is_bingo = true
	var x = 0
	for x_row in bingo_grid:
		is_bingo = x_row[x].pressed and is_bingo
		x+=1
	if is_bingo:
		bingo()
		return

	x = bingo_grid_size-1
	is_bingo = true
	for x_row in bingo_grid:
		is_bingo = x_row[x].pressed and is_bingo
		x-=1
	if is_bingo:
		bingo()
		return

func bingo():
	print("Bingo!")
