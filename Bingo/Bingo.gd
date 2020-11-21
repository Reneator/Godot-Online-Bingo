extends GridContainer


export (int) var grid_size = 3

export (PackedScene) var bingo_element

export (bool) var disabled = false

signal change()
signal bingo()

var rows

func initialize_with_session(session : Session):
	var elements = initialize(session.bingo_entries, session.grid_size)
	if session.bingo_entries_state.size() <= 0:
		return
	for i in range(elements.size()):
		var pressed = session.bingo_entries_state[i]
		var element = elements[i]
		var is_pressed = (pressed == "True")
		element.pressed = is_pressed
	

func initialize(entries, _grid_size):
	var elements = []
	clear()
	grid_size = _grid_size
	columns = grid_size
	for entry in entries:
		var element = create_element(entry)
		elements.append(element)
	return elements

func create_element(entry_data):
	var element = bingo_element.instance()
	
	element.text = entry_data
	if disabled:
		element.mouse_filter = MOUSE_FILTER_IGNORE
	element.connect("pressed", self, "on_bingo_button_pressed")
	add_child(element)
	return element

func clear():
	for child in get_children():
		child.queue_free()

func on_bingo_button_pressed():
	if disabled:
		return
	check_for_bingo()
	
	var entries = get_current_state()
	emit_signal("change", entries)

func get_entries():
	return get_children()

func get_current_state():
	var entries = []
	var entry_elements = get_children()
	for entry in get_children():
		entries.append(entry.get_state())
	return entries
	

func check_for_bingo():
	#here i would have to reset the bingo when the admin rejects
	var is_bingo = false
	
	is_bingo = check_x_rows() or is_bingo
	is_bingo = check_y_rows() or is_bingo
	is_bingo = check_diagonal() or is_bingo
	if is_bingo:
		bingo()

func check_x_rows():
	var entries = get_children()
	var index = 0
	
	var rows = get_rows()
		
	for x_row in rows:
		var is_bingo = true
		for entry in x_row:
			is_bingo = entry.pressed and is_bingo
		if is_bingo:
			return true

func get_rows():
	if rows:
		return rows
	var entries = get_entries()
	var new_array = []
	var current_array
	for i in range(entries.size()):
		var index = i % grid_size
		if index == 0:
			current_array = []
			new_array.append(current_array)
		current_array.append(entries[i])
	return new_array

func check_y_rows():
	var rows = get_rows()
	for y in range(grid_size):
		var is_bingo = true
		for x_row in rows:
			is_bingo = x_row[y].pressed and is_bingo
		if is_bingo:
			return true

func check_diagonal():
	var rows = get_rows()
	var has_bingoed = false
	var is_bingo = true
	var x = 0
	for x_row in rows:
		is_bingo = x_row[x].pressed and is_bingo
		x+=1
	if is_bingo:
		return true

	x = grid_size-1
	is_bingo = true
	for x_row in rows:
		is_bingo = x_row[x].pressed and is_bingo
		x-=1
	if is_bingo:
		return true

func bingo():
	emit_signal("bingo")
	print("Bingo!")
