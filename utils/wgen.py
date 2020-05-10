#
# wgen.py: walkthrough generator for Dirk
#

from collections import defaultdict
import re
import mytools as mt

ever_table = False
table_header = False
in_table = False

bracket_replace = defaultdict(str)
doubled_dict = defaultdict(bool)

move_array = move_ary = [ 'z', 's', 'r', 'l', 'd', 'f' ]

def show_left_right(my_string, unmirrored = True):
    x = mt.no_quotes(my_string.replace("[l-r]", "left" if unmirrored else "right"))
    return x.replace("[r-l]", "right" if unmirrored else "left")

def print_and_dupe(expected_string, room_name):
    print("\n######testing for {}".format(room_name))
    for x in bracket_replace:
        expected_string = expected_string.replace(x, bracket_replace[x])
    print(show_left_right(expected_string))
    rnl = room_name.lower()
    if room_name in doubled_dict and doubled_dict[room_name]:
        print(show_left_right(expected_string, unmirrored = False))

def moves(x):
    ret_ary = []
    try:
        x = int(x)
    except:
        x = 0
    for y in range(0, len(move_ary)):
        if x % 2: ret_ary.append(move_ary[y])
        x >>= 1
    return ret_ary

this_room_string = ''
last_room = ''
failure = ''
success = ''

with open("wgen.txt") as file:
    for (line_count, line) in enumerate(file, 1):
        if line.startswith(";"): break
        if line.startswith("#"): continue
        a = line.strip().split("\t")
        bracket_replace["[" + a[0] + "]"] = a[1]

with open("story.ni") as file:
    for (line_count, line) in enumerate(file, 1):
        if 'is a room' in line and not line.startswith('\t'):
            room_name = re.sub(" +is a room.*", "", line.lower().strip())
            room_name = re.sub(".*called *", "", room_name)
            doubled_dict[room_name] = 'doubled' in line.lower()
            #print(room_name, doubled_dict[room_name])
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
            if (a[0].lower() != last_room) and last_room:
                print_and_dupe(this_room_string, last_room)
                this_room_string = ""
                if 'balls' in last_room: exit()
            last_room = a[0].lower()
            easy_moves = moves(a[5])
            hard_moves = moves(a[6])
            if not hard_moves: hard_moves = list(easy_moves)
            easy_success = hard_success = easy_failure = hard_failure = full_success = full_failure = ""
            for x in move_array:
                if x in easy_moves and x in hard_moves:
                    full_success += "\n> {}\n{}".format(x, a[9])
                else:
                    if x in easy_moves:
                        easy_success += "> {}\n{}\n> undo\n".format(x, a[9])
                        hard_failure += "> {}\n{}\n> undo\n".format(x, a[10])
                    elif x in hard_moves:
                        hard_success += "> {}\n{}\n> undo\n".format(x, a[9])
                        easy_failure += "> {}\n{}\n> undo\n".format(x, a[10])
                    else:
                        full_failure += "> {}\n{}\n> undo\n".format(x, show_left_right(a[10]))
            if easy_success or easy_failure:
                this_room_string += "\n\n@e\n{}{}\n".format(easy_success, easy_failure)
            if hard_success or hard_failure:
                this_room_string += "\n\n@h\n{}{}\n".format(hard_success, hard_failure)
            if full_failure:
                this_room_string += "\n\n@e,h\n#failure\n{}".format(full_failure)
            if full_success:
                this_room_string += "\n#success{}".format(full_success)
            #print(a[0], a[5], '=', moves(a[5]), 'moves, points:', a[7], "/", a[8], 'for reverse')

if this_room_string:
    print_and_dupe(this_room_string, last_room)

if not ever_table:print("No table.")