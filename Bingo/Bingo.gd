extends GridContainer


export (int) var bingo_grid_size = 3

export (PackedScene) var bingo_element

var bingo_grid = []

signal change()

func initialize_with_preset_data(entries):
	var grid_size = int(sqrt(entries.size()))
	for entry in entries:
		print(entry)
	

func initialize(entries, grid_size):
	bingo_grid_size = grid_size
	columns = bingo_grid_size
	var index = 0
	for y in range(bingo_grid_size):
		for x in range(bingo_grid_size):
			var entry_data = entries[index]
			create_element(x, y, entry_data)
			index += 1

func create_element(x, y, entry_data):
	var element = bingo_element.instance()
	element.x = x
	element.y = y
	if bingo_grid.size() <= y:
		bingo_grid.append([])
	bingo_grid[y].append(element)	
	
	element.text = entry_data
	element.connect("pressed", self, "on_bingo_button_pressed")
	add_child(element)

func on_bingo_button_pressed():
	check_for_bingo()
	
	var entries = convert_to_entries(bingo_grid)
	emit_signal("change", entries)

func convert_to_entries(grid_entries):
	var entries = []
	for x_row in bingo_grid:
		for entry in x_row:
			entries.append(entry.to_string())
	return entries

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
