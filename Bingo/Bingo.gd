extends GridContainer
class_name Bingo

@export var grid_size = 3

@export var bingo_element : PackedScene

@export var disabled = false

signal s_change()
signal s_bingo()

var rows

func initialize_with_session(session : Session, validate = true):
	var elements = initialize(session.bingo_entries, session.grid_size)
	if session.bingo_entries_states.size() <= 0:
		return
	for i in range(elements.size()):
		var pressed = session.bingo_entries_states[i]
		var element = elements[i]
		var is_pressed = (pressed == "True")
		element.button_pressed = is_pressed
		if validate and session.bingo_entries_validation.size() > 0:
			element.creation_date = session.creation_date
			element.is_valid = session.bingo_entries_validation[i]
			element.refresh()
	

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
	var element = bingo_element.instantiate()
	add_child(element)
	element.set_text(entry_data)
	if disabled:
		element.mouse_filter = MOUSE_FILTER_IGNORE
	element.connect("s_pressed",Callable(self,"on_bingo_button_pressed"))
	return element

func clear():
	for child in get_children():
		child.queue_free()

func on_bingo_button_pressed():
	if disabled:
		return
	var entries = get_current_state()
#	var is_bingo = check_for_bingo(entries)
	emit_signal("s_change", entries)
#	if is_bingo:
#		emit_signal("s_bingo")

func get_entries():
	return get_children()

func get_current_state():
	var entries = []
	var entry_elements = get_children()
	for entry in get_children():
		entries.append(entry.get_state())
	return entries
	

static func check_for_bingo(entries):
	#here i would have to reset the bingo when the admin rejects
	var is_bingo = false
	var rows = get_rows(entries)
	is_bingo = check_x_rows(entries) or is_bingo
	is_bingo = check_y_rows(entries) or is_bingo
	is_bingo = check_diagonal(entries) or is_bingo
	return is_bingo
#	if is_bingo:
#		bingo()

static func get_rows(entries):
	var grid_size = int(sqrt(entries.size()))	
	var new_array = []
	var current_array
	for i in range(entries.size()):
		var index = i % grid_size
		if index == 0:
			current_array = []
			new_array.append(current_array)
		current_array.append(entries[i])
	return new_array

static func check_x_rows(entries):
	var index = 0
	var grid_size = int(sqrt(entries.size()))
	
	var rows = get_rows(entries)
		
	for x_row in rows:
		var is_bingo = true
		for entry in x_row:
			is_bingo = entry == "True" and is_bingo
		if is_bingo:
			return true

static func check_y_rows(entries):
	var grid_size = int(sqrt(entries.size()))	
	var rows = get_rows(entries)
	for y in range(grid_size):
		var is_bingo = true
		for x_row in rows:
			is_bingo = x_row[y] == "True" and is_bingo
		if is_bingo:
			return true

static func check_diagonal(entries):
	var grid_size = int(sqrt(entries.size()))
	var rows = get_rows(entries)
	var has_bingoed = false
	var is_bingo = true
	var x = 0
	for x_row in rows:
		is_bingo = x_row[x] == "True" and is_bingo
		x+=1
	if is_bingo:
		return true

	x = grid_size-1
	is_bingo = true
	for x_row in rows:
		is_bingo = x_row[x] == "True" and is_bingo
		x-=1
	if is_bingo:
		return true

func bingo():
	emit_signal("s_bingo")
	print("Bingo!")
