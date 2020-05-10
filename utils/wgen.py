#
# wgen.py: walkthrough generator for Dirk
#

from collections import defaultdict
import re

ever_table = False
table_header = False
in_table = False

doubled_dict = defaultdict(bool)

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

current_text = ''
last_room = ''

with open("story.ni") as file:
    for (line_count, line) in enumerate(file, 1):
        if 'is a room' in line and not line.startswith('\t'):
            room_name = re.sub(" +is a room.*", "", line.lower().strip())
            room_name = re.sub(".*called *", "", room_name)
            doubled_dict[room_name] = 'doubled' in line.lower()
            print(room_name, doubled_dict[room_name])
        if line.startswith("table of gamemoves"):
            table_header = True
            ever_table = True
            continue
        if table_header:
            in_table = True
            table_header = False
            continue
        if in_table:
            if line.startswith("[") or not line.strip(): break
            a = line.strip().split("\t")
            if a[0].lower() != last_room:
                print("starting room", a[0])
                print(current_text, end='')
                current_text = ""
            last_room = a[0].lower()
            #print(a[0], a[5], '=', moves(a[5]), 'moves, points:', a[7], "/", a[8], 'for reverse')

if not ever_table:print("No table.")