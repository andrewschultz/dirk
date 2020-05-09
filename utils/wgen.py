ever_table = False
table_header = False
in_table = False

move_ary = [ '!', 'S', 'R', 'L', 'D', 'F' ]

def moves(x):
	try:
		x = int(x)
	except:
		x = 0
	ret_string = ""
	for y in range(0, len(move_ary)):
		if x % 2: ret_string += move_ary[y]
		x >>= 1
	return ret_string

with open("story.ni") as file:
	for (line_count, line) in enumerate(file, 1):
		if line.startswith("table of gamemoves"):
			table_header = True
			ever_table = True
			continue
		if table_header:
			in_table = True
			table_header = False
			continue
		if in_table:
			if not line.strip(): break
			a = line.strip().split("\t")
			print(a[0], a[5], '=', moves(a[5]), 'moves, points:', a[7], "/", a[8], 'for reverse')

if not ever_table:print("No table.")