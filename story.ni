"Dirk" by Andrew Schultz

the story headline is "A twice-as-expensive, yet still free, text adventure"

use no scoring. [Ironic, isn't it? Thing is, to keep this game un-glulx, I needed a workaround for breaking 32767 points. So this was easier to code than turning the score off, etc.]

include Bitwise Operators by Bart Massey.

include Undo Output Control by Erik Temple.

include Basic Screen Effects by Emily Short.

[to navigate this document, here are some codes I put in the text.
(T)OGO = table of gameorder
(T)OGM = table of gamemoves
]

book undoing

before undoing an action:
	say "Time travel really shouldn't be A Thing on your [italic type]first[roman type] adventure, Dirk.[paragraph break]Plus allowing undos might destroy the burgeoning Laser Disc video game industry that will last for years otherwise in some far-off strange kingdom.";
	the rule fails;

check saving the game:
	say "That's not very intrepid, Dirk![paragraph break]Apropos of nothing, you suddenly see a vision of a kid much weaker than yourself tying a string to a coin and dropping it into a slot in a big, tall booth of some sort. You don't know what he's doing, but it feels wrong!" instead;

book globals and commands

to ital-say (x - indexed text): [steal this stub to generate instant footnotes.]
	say "[italic type][bracket]NOTE: [x][close bracket][roman type][line break]"

to say email:
	say "blurglecruncheon@gmail.com";

to say cmds:
	say "U/L/D/R to move Dirk, S for sword/attack, or Z to wait, which is usually a bad idea. H gives a command list, and an empty command refreshes your current situation"

does the player mean examining the player: it is very likely.

after reading a command:
	if the player's command matches the regular expression "^\p" or the player's command matches the regular expression "^<;\*>;":
		say "[if currently transcripting](Noted for transcript.)[else](Noted, though transcript is not natively on.)[end if]";
		reject the player's command;
	if the player's command matches the regular expression "\.":
		say "Planning ahead is just not realistic, Dirk! Deal with the immediate obstacle.";
		reject the player's command;
	if debug-state is true: [these are meta-commands we don't want to open to the player, because they can really mess up the game state, or they're just used for debugging in Inform in general anyway]
		if word number 1 in the player's command is "test":
			continue the action;
		if word number 1 in the player's command is "gt":
			continue the action;
		if word number 1 in the player's command is "db":
			continue the action;
		if word number 1 in the player's command is "restart":
			continue the action;
		if word number 1 in the player's command is "rules":	
			continue the action;
	let QQ be "[word number 1 in the player's command]";
	if word number 1 in the player's command is "save": [these are meta-commands we always need to check on. Also YES I KNOW CLEAN UP THIS CODE]
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "quit":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "dethmsg":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "xyzzy":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "about":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "credits":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "credit":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "transcript":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "dircheat":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "li":
		change the text of the player's command to QQ;
		continue the action;
	if word number 1 in the player's command is "x" or word number 1 in the player's command is "examine":
		say "You aren't given to reflection, much, Dirk. But you know how to react when something's not right. Also, the looks thing: in your orange tunic over what seems to be armor, and that pointy metal hat, with that backpack too. I don't know what's in there, and I won't ask, because that would be rude even if you weren't too busy running and fighting.";
		reject the player's command;
	let B be the number of words in the player's command;
	if B > 1:
		say "You can process complex sentences much better than your mean classmates gave you credit for, Dirk. But worrying about nice long beautiful [B in words]-word sentences right now may be the difference between life and death.[paragraph break]Commands: [cmds].";
		reject the player's command;
	let A be the number of characters in the player's command;
	if A > 1:
		say "Ugh! Long non-fourth-wall [A in words]-letter commands make Dirk's head hurt. Well, there are some meta-commands. But here are the main short ones.[paragraph break][cmds].";
		reject the player's command;
	if the player's command matches the regular expression "<\?>":
		try hing instead;
	if word number 1 in the player's command is "t":
		if currently transcripting:
			try switching the story transcript off;
		else:
			try switching the story transcript on;
		reject the player's command;
	if the player's command matches the regular expression "<uldrhsacz>":
		do nothing;
	else:
		say "You hear a humming buzz. (To show commands, type H.)";
		reject the player's command;
	continue the action;
		
Rule for printing a parser error when the latest parser error is the I beg your pardon error:
	if moved-in-room is false:
		try looking;
	else:
		d "Row [row-in-moves].";
		choose row row-in-moves - 1 in table of gamemoves;
		say "LAST OBSERVATION: [yay entry][paragraph break](To show commands, type H.)[paragraph break]";
	reject the player's command;
		
Outside the Castle is a room. "You walk across the moat's drawbridge, which collapses. Hanging on to the remainder, you hack at some weird purple tentacles that come up from the moat, lift yourself up, and then you rush past a gate before it slams down, then a door before it shuts.[paragraph break]Great. Hack at enemies, enter gates and doors before they shut. How hard can it be?"

debug-state is a truth state that varies.

tthouscore is a number that varies. [this is the glulx workaround. basescore is your score, mod 10000.]
basescore is a number that varies. [I think I got this idea from Ryan Veeder saying he'd have written Taco Fiction in Glulx, except for needing $50k for money. So I looked for a solution.]

inf-lives is a truth state that varies.

to say wfak:
	wait for any key;
	say "[paragraph break]";

section debug stuff - not for release

when play begins (this is the fix alignment in debug rule):
	now right alignment depth is 20;
	now debug-state is true;

book globals

to d (x - indexed text):
	if debug-state is true:
		say "DEBUG: [x][line break]";

to d-n (x - indexed text):
	if debug-state is true:
		say "(D) [x]";

lives-left is a number that varies. lives-left is usually 0.

to say life-lives:
	say "[lives-left] li[if lives-left is 1]fe[else]ves[end if]";

to say xtrazero: [A hack so 50002 doesn't become 52.]
	if basescore < 1000:
		say "0";
	if basescore < 100:
		say "0";
	if basescore < 10:
		say "0";

to first-status: (- DrawStatusLine(); -); [inform 6 to draw "unique" status line before play begins]

when play begins (this is the main start rule):
	choose row with a final response rule of immediately undo rule in the Table of Final Question Options; 
	delete the final question wording entry; [no UNDO on game end]
	now left hand status line is "Adventurers['] Guild";
	now right hand status line is "INSERT 50 CENTS";
	first-status;
	say "Well, Dirk, you got your chance. The 'progressive' institute for adventurers emphasized more than just the physical angle that came naturally to you. It emphasized mental stuff--like sines and cosines over just being able to jump a real long way. But what really hurt was how the other adventurers told you you were nice and all but would never amount to much. That you could never do anything for The Social Good. That confused you. Being mean wasn't good, so how could they be chosen for doing bigger good things?";
	wait for any key;
	say "[line break]";
	say "But man, they made fun of you for everything, even the stuff you knew: like knowing your left from your right. 'Everyone knows that! When'll that be helpful?'[paragraph break]They all got their various quests. Some got cushy teaching jobs. Some became sub-toadies for demigods. But you--you, well, there was word of Princess Daphne, held by the dragon Singe.";
	wait for any key;
	say "[line break]";
	say "Your classmates jibed she was as un-smart as you. They even said the quest was beneath them, too silly if you looked at it right. Little more than a multiple choice test. Of course they could beat Singe the dragon, but it'd be a loss if anything in Singe's castle was unfair. You had to be street-smart. Dragons were like that. Plus there was no proof such a quest would advance society.";
	wait for any key;
	say "[line break]";
	say "When you asked a retired adventurer, he mentioned it might be a bit trickier than the four-answer multiple choice tests that plagued you. There might be FIVE choices! 'But Dirk, I believe in you. Some of those questions may be loaded. You have the reflexes, the timing.'[paragraph break]'But if the questions are loaded, doesn't that mean they're extra hard?'[paragraph break]'Just use your common sense, Dirk, and don't overthink everything. Those eggheads, they'll consider how things that help [']em are physically impossible, and at least they'll feel smart when they die. They'd rather spend hours studying what they calculate is inside the castle than rely on their reflexes. That won't happen with you. Um, I mean, there--you'll keep focused on what's important. Like, you're good at being distracted by stuff that flashes. That'll help.'[paragraph break]Wow! Nobody ever put it that way before!";
	wait for any key;
	say "[line break]";
	say "You hear the sounds of two coins falling. You blink, and you're outside an eerie castle.";
	now player is in Outside the Castle;
	now left hand status line is "[location of the player]";
	now lives-left is 3;
	now right hand status line is "[if tthouscore > 0][tthouscore][xtrazero][end if][basescore] [bracket][life-lives][close bracket]";
	init-room-table;
	if debug-state is false:
		shuffle-room-table; [Yup! That's right! I can play the game in order, but my players get stuck with randomization.]
	else:
		nonshuffle-room-table;
	pick-next-room;
	prime-next-area;

to init-room-table:
	repeat through table of gameorder:
		now sol entry is false;
		now vis entry is false;
	
to nonshuffle-room-table:
	let rnum be 0;
	repeat through table of gameorder:
		increment rnum;
		now gameord entry is rnum;
		[d "[myroom entry] at [gameord entry].";]
		if there is no mirrored entry:
			now mirrored entry is false;
	choose row 1 in table of gameorder;
	d-n "[is-mirrored]";
	now is-mirrored is mirrored entry;
	d-n "[is-mirrored]";

book transcription aids

Include (-
[ CheckTranscriptStatus;
#ifdef TARGET_ZCODE;
return ((0-->8) & 1);
#ifnot;
return (gg_scriptstr ~= 0);
#endif;
];
-).

To decide whether currently transcripting: (- CheckTranscriptStatus() -)

[thanks to Zarf for the above code. It helps a tester make sure they're testing after their first comment. Feel free to borrow/steal it. I use it in conjunction with "after reading a command."]

book operations

chapter dirkmove

row-in-moves is a number that varies.

to bumpscore (pe - a number):
	increase basescore by pe;
	if basescore > 10000:
		increase tthouscore by basescore / 10000;
		now basescore is remainder after dividing basescore by 10000;

to say thedirs of (j - a number):
	if j bit-and 1 is 1:
		say " (nothing)";
	if j bit-and 2 is 2:
		say " sword";
	if j bit-and 4 is 4:
		say " [if is-mirrored is false]right[else]left[end if]";
	if j bit-and 8 is 8:
		say " [if is-mirrored is false]left[else]right[end if]";
	if j bit-and 16 is 16:
		say " down";
	if j bit-and 32 is 32:
		say " up";

to dirkmove (a - a number):
	now lastmove is a;
	choose row row-in-moves in table of gamemoves;
	let X be rightmove entry;
	if is-mirrored is true:
		if X is 4 or X is 8:
			now X is X bit-xor 12;
	[say "Comparing [rightmove entry] [X] to [a]...[if is-mirrored is true]--but mirroring[end if].";]
	if (X bit-and a) is a:
		now moved-in-room is true;
		say "[yay entry][line break]";
		if show-death-msg is true:
			ital-say "[boo entry]";
		bumpscore points entry;
		if points entry is -1:
			say "BUG implement this!";
		if there is a finished entry:
			if the finished entry is 1:
				if location of player is dragon's lair:
					say "The boys at the guild are surprised and jealous. They deconstruct your constant scrapes with death as nothing more than a simple multiple choice test, then mumble something about how you're lucky it's the middle ages and not the future, where you'd never make it as a Space Ace who can shoot laser guns, steer flying machines, and save the woman in distress.[paragraph break]You ask if women could shoot guns and steer machines in the future, too, after which you're shouted down as naive and impractical and contrary to the purposes of the adventurers['] guild.";
					if ever-deth-msg is false:
						say "[line break]";
						ital-say "if you're curious about seeing all the death messages, you can type dethmsg and then replay through. Or you can just loot the source.";
					end the story saying "GAME OVER";
					the rule succeeds;
				otherwise:
					mark-solved;
					pick-next-room;
					prime-next-area;
		otherwise:
			increment row-in-moves;
	otherwise:
		say "[boo entry][line break]";
		if dir-cheat is true:
			say "safe moves are/were[thedirs of rightmove entry].";
		if inf-lives is false:
			decrement lives-left;
		if lives-left is 0:
			say "[line break]You bounce back up, filled with rage! You cross your arms and glare at someone--anyone--who is responsible for your failure. As if you couldn't make the right move unless someone above said so! You have some [italic type]interesting[roman type] ideas, Dirk. But you never got to share them in adventuring school, where you felt DOING meant more than WRITING.[paragraph break]Sadly, just as your glare gets cooking, your flesh itself melts away, and your bones crumble to the floor, more musical than you ever got in art class.";
			ital-say "okay, I think you've paid your dues. The command LI gives you an infinite-lives cheat if you just want to play through again. Also, DIRCHEAT tells you which way you should've gone.";
			end the story saying "GAME OVER";
		otherwise:
			say "[line break]You're just skin and bones now, Dirk. Mini-skeletons swirl about you as you peer around. You're in a void...and then... POP! Back to adventuring!";
			pick-next-room;
			prime-next-area;

section last move shortcut determination

[so far only implemented for the avalanche. The idea is to give alternate death routes.]
 
lastmove is a number that varies.

to decide whether went-x:
	if lastmove is 1:
		decide yes;
	decide no;

to decide whether went-s:
	if lastmove is 2:
		decide yes;
	decide no;

to decide whether went-r:
	if lastmove is 4:
		decide yes;
	decide no;

to decide whether went-l:
	if lastmove is 8:
		decide yes;
	decide no;

to decide whether went-d:
	if lastmove is 16:
		decide yes;
	decide no;

to decide whether went-u:
	if lastmove is 32:
		decide yes;
	decide no;

book commands

chapter dethmsging

dethmsging is an action out of world.

understand the command "dethmsg" as something new.

understand "dethmsg" as dethmsging.

show-death-msg is a truth state that varies.
ever-deth-msg is a truth state that varies.

carry out dethmsging:
	now show-death-msg is whether or not show-death-msg is false;
	now ever-deth-msg is true;
	say "Showing death messages is toggled [if show-death-msg is true]on[else]off[end if].";
	the rule succeeds;

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.

understand "xyzzy" as xyzzying.

carry out xyzzying:
	say "Sheesh! Dirk's a knight, not a wizard.[paragraph break]Plus he doesn't deserve a hollow voice saying 'Fool.' Adventuring school flashbacks and all.";
	the rule succeeds;

chapter creditsing

creditsing is an action out of world.

understand the command "c/credit/credits" as something new.

understand "c" and "credit" and "credits" as creditsing.

carry out creditsing:
	say "Thanks to Alice Grove, Marco Innocenti, and Hanon Ondricek for pinch-hit testing for not the first time. Consider this my commitment to test their next cool ideas earlier. And to get my own actual real story ideas out earlier.";
	say "Thanks to Don Bluth for creating Dragon's Lair. Although the humiliation of that one time I scored 'only' 147 still burns, it was great fun.";
	say "Thanks to www.dragons-lair-project.com for having the walkthrough of 'easy mode.' And for permission to integrate it.";
	say "Thanks to the folks who created the Dragon's Lair DVD so I could solve it there. One day I'll hit up a real arcade machine.[wfak]";
	say "Thanks to DJ Tommy for his walkthrough video at https://www.youtube.com/watch?v=hdumVFgwgP8.";
	say "Thanks to Laren Ferguson for writing that 'How to Beat Dragon's Lair' book that made me very popular in school for a few days. Though I still was too awed by the graphics to follow instructions. Well, until Showbiz Pizza/Chuck E Cheese moved away from the mall across route 52. Then all I had was that book, and I studied real hard! I got a pretty high score in my final game at a Chuck E Cheese in Chicago. One day I'll beat an actual cabinet.";
	say "Last and certainly not least (trivia: people are 2nd-most likely to click on the last in a list of links,) thanks to Greg Boettcher for holding Spring Thing, and to Aaron Reed for creating the Back Garden so I felt comfortable submitting a silly game like this. Oh, and thanks to you, if you submit a transcript to [email] that helps me with any issues, big or small. Any bit helps, and I'm glad to trade testing back in return.";
	the rule succeeds;

chapter abouting

abouting is an action out of world.

understand the command "a/about" as something new.

understand "about" and "a" as abouting.

carry out abouting:
	say "Yes, this game is an 'interpretation' of Dragon's Lair.I got the idea in April 2012 after seeing the April Fool's arcade pack up at IFDB. So I read http://www.dragons-lair-project.com for the move source, and I noted that there was more than one possible right move--I wanted to allow that. It seemed too sticky.[paragraph break]";
	say "Then up popped Bart Massey's Bitwise Operators extension. However, with April Fool's 11 months away, I wrote up the Flaming Ropes rooms and put the game aside. Then I entered Spring Thing [']13, and then in [']14, I convinced myself I really should've moved beyond a silly joke like this. Plus I'd managed to procrastinate the potentially repetitive typing here with much less fun repetitive FreeCell, among other things (hint: BlockSite is a great add-on.)[wfak]";
	say "In [']15, after squeezing in updates for my [']13 Spring Thing game, I just had time to worry whether it was worth the bother for me (it was. If I'd started earlier, it would be, for sure, for you) and whip up the text and some features! I'd never have bothered if Aaron Reed hadn't opened the Back Garden for Spring Thing, because this work isn't fully serious, but maybe it will give you an idea for your own tribute. If you wonder if you should, maybe this will give you the confidence to do at least as well.[paragraph break]";
	say "A weakness of the game is that, if you go in the wrong direction, you don't get a 'special' death. For instance, if Dirk can fall into a pit or be buried by rocks, the game chooses one death at random. But that's what a post-comp release is for![paragraph break]";
	say "Incidentally, this game is based on 'easy mode.' But 'hard mode' might be a post-comp release, because I saw how to design it the day before comp entries were due.[paragraph break]Transcripts are welcome at [email]. I'm sure I missed a few jokes.[paragraph break]";
	the rule succeeds;

check waiting:
	dirkmove 1;
	the rule succeeds;

chapter uing

uing is an action applying to nothing.

understand the command "u" as something new.

understand "u" as uing.

carry out uing:
	dirkmove 32;
	the rule succeeds;

chapter ding

ding is an action applying to nothing.

understand the command "d" as something new.

understand "d" as ding.

carry out ding:
	dirkmove 16;
	the rule succeeds;

chapter ling

ling is an action applying to nothing.

understand the command "l" as something new.

understand "l" as ling.

carry out ling:
	dirkmove 8;
	the rule succeeds;

chapter oing

oing is an action applying to nothing.

understand the command "o" as something new.

understand "o" as oing.

carry out oing:
	try restarting the game instead;
	the rule succeeds;

chapter ring

ring is an action applying to nothing.

understand the command "r" as something new.

understand "r" as ring.

carry out ring:
	dirkmove 4;
	the rule succeeds;

chapter sing

sing is an action applying to nothing.

understand the command "s" as something new.

understand "s" as sing.

carry out sing:
	dirkmove 2;
	the rule succeeds;

chapter zing

zing is an action applying to nothing.

understand the command "z" as something new.

understand "z" as zing.

carry out zing:
	if debug-state is false:
		say "You're a man of action, Dirk! Well, except if nasty math story problems are involved." instead;
	let A be location of player;
	say "Jumping to next area for debug purposes.";
	mark-solved;
	pick-next-room;
	the rule succeeds;

chapter hing

hing is an action applying to nothing.

understand the command "h" as something new.

understand "h" as hing.

carry out hing:
	say "U/D/L/R moves Dirk up down left or right. S uses his sword.";
	say "(A)BOUT and (C)REDITS are also commands. You can take a (T)RANSCRIPT if you find a bug.";
	say "A blank command will let you look. If you've already moved in your current room, it will print the last thing that happened[one of]. This may be useful right now[or][stopping].";
	the rule succeeds;

book shuffle-room-table

rooms-in-seq is a number that varies. rooms-in-seq is usually 4.

current-table-slot is a number that varies. current-table-slot is usually 0.

is-mirrored is a truth state that varies. is-mirrored is usually false.

to mark-solved:
	repeat through table of gameorder:
		if myroom entry is location of player:
			if mirrored entry is is-mirrored:
				now sol entry is true;
				the rule succeeds;
	d "Oops, no recorded save for [location of player], [is-mirrored].";

fail-mention is a truth state that varies.

to pick-next-room:
	bumpscore 49;
	[if debug-state is true:
		repeat through table of gameorder:
			if sol entry is false:
				say "(D) NOT SOLVED [myroom entry].";]
	let thisrow be 0;
	repeat through table of gameorder: [pick off the first visible]
		increment thisrow;
		if vis entry is false:
			if myroom entry is not dragon's lair:
				now is-mirrored is mirrored entry;
				if location of player is outside the castle:
					move player to myroom entry, without printing a room description;
				else:
					move player to myroom entry;
					[d "to [myroom entry] [vis entry], at row [thisrow].";]
				now vis entry is true;
				mirror-check;
				the rule succeeds; [all visited except dragon's lair]
	d "All rooms visited. Let's see what's unsolved.";
	repeat through table of gameorder:
		if sol entry is false:
			if myroom entry is not dragon's lair and fail-mention is false:
				say "Up ahead. A place that defeated you. Time to get it right, this time. You block out mocking fellow students using fancy phrases like process of elimination when they meant try stuff til it works.";
				now fail-mention is false;
			else if myroom entry is dragon's lair and dragon's lair is visited:
				say "Oh. Neat. Another chance.";
			move player to myroom entry;
			now vis entry is true;
			now is-mirrored is mirrored entry;
			d "Room is [if is-mirrored is false]not [end if]mirrored.";
			the rule succeeds;
	move player to dragon's lair; [shouldn't happen but you know...]

moved-in-room is a truth state that varies.

to prime-next-area:
	let temp be 0;
	repeat through the table of gamemoves:
		increment temp;
		if myroom entry is location of player:
			now row-in-moves is temp;
			now moved-in-room is false;
			the rule succeeds;
	say "BUG NO ROOM FOUND";
	
to shuffle-room-table: [this arranges the rooms in pods of 3]
	now rooms-in-seq is number of rows in table of gameorder / 3;
	let A be a list of numbers;
	repeat with Q running from 1 to rooms-in-seq:
		add Q to A;
		add (Q + rooms-in-seq) to A;
		add (Q + (2 * rooms-in-seq)) to A;
		sort A in random order;
		repeat with Z running from 1 to 3:
			choose row (Q * 3) + Z - 3 in table of gameorder;
			now gameord entry is entry Z in A;
		remove A from A;
	choose row with myroom of Dragon's Lair in the table of gameorder;
	if gameord entry is not 39:
		let Z be gameord entry;
		choose row with gameord of 39 in table of gameorder;
		now gameord entry is Z;
		choose row with myroom of Dragon's Lair in the table of gameorder;
		now gameord entry is 39;
	sort table of gameorder in gameord order;
	
to print-out-litany: [this is for debug purposes]
	let XX be indexed text;
	repeat through table of gameorder:
		now XX is "[myroom entry] [mirrored entry] [sol entry] [vis entry] [gameord entry].";
		d "[XX]";

book check-mirror-note

mention-mirror is a truth state that varies.

to mirror-check:
	let times-through be 0;
	if location of player is outside the castle:
		continue the action;
	if mention-mirror is false:
		repeat through table of gameorder:
			[d "Looking check: [myroom entry] [mirrored entry] [gameord entry] [sol entry] [vis entry].";]
			if myroom entry is location of player and vis entry is true:
				increment times-through;
[	d "[times-through] times through.";]
	if times-through is 2:
		say "This room looks vaguely familiar. You grab reflexively for your sword, but it's on the other side as last time. Hmm.";
		now mention-mirror is true;
	continue the action;

book in-order

Flaming Pit is a room. "There're three ropes here swinging back and forth to the [r-l]. There's a ledge beyond them. The one you're on is currently retracting."

Closing Wall is a room. "A wall is rapidly closing in front of you. Yup, the ones to the left and right already WERE closed."

There is a room called Horsing Around Walls and Fire. "Oh, look! A[one of][or]nother[stopping] horse with a gem on top! You forget your mission, distracted by the wrong sort of something shiny--treasure, not a passageway. [one of][or]Maybe this time... [stopping]When you climb on, the horse takes off. Your horse swerves [l-r], almost smack into a fireplace."

Drink Me is a room. "A small room. You walk towards an icky potion ahead of you with a big DRINK ME sign. This leaves you suspicious! If it were nutritious, there'd be a picture of someone even more muscular than you. Duh.[paragraph break]There's also a door to the right. What to do?"

Crypt Creeps is a room. "Just another hallway going forward. Exits are up ahead to the side, but...first, those bouncing skeleton heads that popped out. They're too many, and too low, to fight."

Underground River is a room. "You walk obliviously to the edge of a narrow cliff and are suprised when it collapses ten feet from the edge. You fall into a purple river, and even more surprisingly, right into a barrel swept along by a current of purple water. Before you can properly appreciate the luck involved, you float past a sign saying YE BOULDERS and suddenly see there's a small flashing cave to the left--better go there, or you'll hit that rock wall ahead. Or to the sides."

Plummeting Disc is a room. "You jump through a doorway to a glowing wooden circle suspended in midair. It flashes and starts falling. You scream, but at least you keep your eyes open to see the ledge to the [l-r]!"

Avalanche is a room. "You hear a rumbling above. The ground up and to the left begins falling into a void."

a room called U and Pool Balls is a room. "A very long rainbow/ROY G BIV colored U lies below. Very large pool balls roll back and forth with perfect conservation of energy, so you can't wait forever them to die out. Oh, and a huge black bowling ball just upwards means you REALLY can't wait. First up is a red ball. Oh man! This place is all topsy turvy, and you even have to wait just right to pass the red ball below."

a room called Cage and Geyser is a room. "There's a cage all around you to the left and right.  Electricity flows from down. A door snaps open and closed, upward."

Black Knight on Horse is a room. "As you observe the thorns to the right, a streak of lightning flashes and sticks your sword in its sheath! Then a knight charges you from above!"

Twirling Boulders is a room. "You're on a narrow walkway. Two spinning boulders on sticks, in a circle, periodically block your passage up. There's no way down."

Lizard King is a room. "Oh no! A magnetic pot of gold schlurps your sword from your scabbard, ten feet away. Then it jangles off. Then there's a weird grunt from the right as a giant lizard in purple robes raises a golden scepter."

Smithee is a room. "You stick your sword in a magic fire, and immediately another glowing sword whistles and comes swooping down at you[one of]! Didn't you learn anything last time, Dirk?[or]![stopping] Oh, yeah, there's also fire on a couple sides of you."

Wind Tunnel is a room. "Against your better judgement, you open a bulging door with a big WHOOSHING behind you. Fortunately, you don't have time to think of what anachronisms are swirling around, or you'd already be killed! As it is, you're distracted by a diamond or something in a window to a bottomless pit to the left. You think there may've been a door to the right, but you're not sure."

Tentacle Room is a room. "Well, this isn't too bad, for starters. One tentacle comes down, just daring you to slice it."

Snake Room is a room. "A snake pops down from the ceiling and hisses at you!"

Goop Room is a room. "Goop bubbles from a cauldron and dries behind you and to each side. You suspect there'll be monsters to hack at soon, but not just yet. Process of elimination, Dirk, process of elimination."

The room called Slide and Pit is a room. "Aaaaaa! There's a pit ahead of you, down! There's a wall to your left, but in a fit of lost ego (or clarity?) you imagine it's to the right, for people who matter."

Giddy Goons is a room. "A tiny purple pig with a dagger comes bouncing impossibly out from the left! It's either very confident, or very backed up by friends who'll totally bumrush you if you're passive."

The room called Fire and Lightning Room is a room. "Oh no! A bolt strikes from the ceiling and sets fire to everywhere except your right."

Earthquake Room is a room. "You notice your sword on your [l-r], and the ground on every other side also seems to be crumbling."

The room called Bats and Walkway is a room. "Another scene, another narrow walkway forward."

Electric Knight is a room. "A huge electric knight appears up ahead! He's way too far to attack. For now. You reflexively feel your sword on the [l-r] and notice the electric tiles glowing: up, down and [l-r]."

Bat King is a room. "You're dive-bombed by bats. Not enough to flee, but you should ward them off. Maybe by then enough walkways will vanish, "

Electric Throne is a room. "Zzzaap! A magnetic throne siphons your scabbard away from you. To make matters worse, the circular room you're in? The rug starts rolling up. There's a lot of volts on that shiny floor to the left and behind, and now, up ahead."

Vanishing Checkerboard is a room. "Oh, man! You always hated checkers. You always wished checkerboards would disappear. But you're sort of getting your wish, here. And quickly. And the two exits--a shut cage doors up and a closed door to the left--are closed."

Mud Monsters is a room. "You're in a big mud land. What could live here? Mud monsters, that's what. They squelch toward you slowly and surround you. They don't seem to expect any resistance."

pd2 is a room. "You jump [one of][or]once again [stopping]through a door onto a disc suspended in midair. Congratulations, Dirk! Your weight broke the balance of magic that kept it there! It begins falling. But it's kind of fun, and your screams echo really neato, so you watch three ledges to the [l-r] go by, then three to the [r-l]. The ground below is coming up close, though! Only three more ledges to the [l-r]."

printed name of pd2 is "Plummeting Disc, Extra Stops"

drag-kill is a number that varies.

Dragon's Lair is a room. "This is it, Dirk! You're at your goal! [if drag-kill > 0]You've tried to hoard points, whatever they are, for whatever they may be worth--maybe you want the fun to last as long as possible. Or maybe you just weren't sure what to do. But you better make it count, now[else]There's Daphne, trapped in a glass bubble. It's going to be a long fight, but if you just stick the basics that got you here--all you, baby. All you[end if]."

table of gameorder [togo]
myroom	mirrored	gameord	sol	vis
Flaming Pit	true	1	false	false
Flaming Pit	false
Closing Wall	false
Horsing Around Walls and Fire	true
Horsing Around Walls and Fire	false
Drink Me	false
Crypt Creeps	true
Crypt Creeps	false
Underground River	false
Plummeting Disc	false
Plummeting Disc	true
Avalanche	false
U and Pool Balls	false
Cage and Geyser	false
Black Knight on Horse	false
Twirling Boulders	true
Twirling Boulders	false
Lizard King	false
Smithee	true
Smithee	false
Wind Tunnel	false
Tentacle Room	false
Snake Room	false
Goop Room	false
Slide and Pit	false
Giddy Goons	false
Fire and Lightning Room	false
Earthquake Room	true
Earthquake Room	false
Bats and Walkway	false
Electric Knight	true
Electric Knight	false
Bat King	false
Electric Throne	false
Vanishing Checkerboard	false
Mud Monsters	false
pd2	false
pd2	true	[note: check this is not randomized]
Dragon's Lair	false

to say r-l:
	if is-mirrored is true:
		say "left";
	otherwise:
		say "right";
		
to say l-r:
	if is-mirrored is true:
		say "right";
	otherwise:
		say "left";

to say u-nfair:
	say ". Being smooshed, you don't care about the details. Up being down and down being up in this room didn't help, either"

to say horse-fly:
	say "Your horse flies into the wall. You and your horse crumble to pieces. It'd be sort of funny, if it happened to someone mean"

to say splat-pur:
	say "Splat! You failed to avoid a wall and sink into the purple depths."

to say or-scen:
	say "You could not steer to the safety of the garish orange strip! At least your last moments are filled with color."

to say whirl-d:
	say "The whirlpool sucks you in! You have an acute view of green water before things go dark"

table of gamemoves [togm]
myroom	rightmove	yay	boo	points	finished	reverse
Flaming Pit	4	"You grab onto a rope. The timing's easy enough. Another swings back from the [r-l]."	"The ledge you were on retracts fully. You fall screaming to your doom."	251	--	379
Flaming Pit	4	"You grab the next rope, not thinking about it. The eggheads up on adventure theory might think a second too long and draw parabolas in their head and calculate things to three significant figures, but not you, Dirk. Ooh! Anther rope swings back from the [r-l]."	"Oblivious of the swinging rope to the [r-l], you fall into the pit."	379	--	495
Flaming Pit	4	"You grab the next rope yet again, not even worrying if you might mess this up. Oh, hey! There's a ledge to the [r-l]! You reach out your hand reflexively."	"Oblivious of the swinging rope to the [r-l], you fall into the pit."	495	--	0
Flaming Pit	4	"You jump off the rope and onto the ledge and through the door."	"At the last minute, you decide to jump [r-l], but you don't have enough momentum. Your feet wobble on the edge of the ledge you jump on. You fall into the pit. Boo, physics."	915	1	0
Closing Wall	32	"You jump through the wall and land awkwardly but safely."	"You look for a way around the wall, then try to sneak through as it shuts. You make it halfway, which isn't good enough."	379	1
Horsing Around Walls and Fire	4	"You avoid the fire to the [l-r] so well that you're now careening towards a fire on the [r-l]. Hooray, variety."	"You and your horse crash into the fire to the [r-l]. HOT HOT HOT!"	495
Horsing Around Walls and Fire	8	"You avoid the fire to the [r-l]. Now there's fire on the [l-r]. And a pillar up ahead!"	"You and your horse crash into the fire to the [l-r]. HOT HOT HOT!"	495
Horsing Around Walls and Fire	4	"You avoid the pillar and the fire. Now there's fire on the [r-l] with a pillar ahead."	"You and your horse crash into the fire to the [r-l] HOT HOT HOT!."	495
Horsing Around Walls and Fire	8	"You avoid the fire to the [r-l]. Now there's a wall ahead and to the [r-l]."	"You and your horse crash into the fire to the [r-l] HOT HOT HOT!."	495
Horsing Around Walls and Fire	8	"You avoid the wall! There's another wall ahead and to the [r-l], and no time to think about the lack of variety."	"[horse-fly]."	1326
Horsing Around Walls and Fire	8	"Your horse crashes into the ground. You brush yourself off, kicking open a door hard enough that it slams shut to deflect a random bolt of lightning. Take that, deportment classes you hated!"	"[horse-fly]."	495	1
Drink Me	4	"That bottle looks like something from alchemy class, which you hated. Good thing you turned away--a beam zaps the door to the right just after it shuts behind you."	"[if lastmove bit-and 33 > 0]You manage to reverse-reverse-reverse-psychology yourself into drinking the potion. It turns you into a powder. Strangers['] magic is worse than strangers['] sweetmeats, Dirk![else]Scared of a little potion, you can't even pass by it to the exit. A lightning bolt zaps you.[end if]"	379	1
Crypt Creeps	32	"Oh no! A big skeletal hand appears from a doorway to the [l-r]!"	"The skull heads somehow manage to pull you down. You swing your sword, but it can't reach that close and low at the same time."	915	--	2191
Crypt Creeps	2	"You slash the hand. Now tar starts oozing out ahead...but the skeletons behind are yucky, too."	"There's no running. The hand grabs you."	495
Crypt Creeps	32	"Whew. Now another big skeletal hand, this time from the [r-l]!"	"You are stuck in the tar before you can make it forward."	915	--	2191
Crypt Creeps	2	"You slash the hand again. Now tar comes pouring from the [r-l] where it was."	"There's no running. The hand grabs you."	495
Crypt Creeps	8	"You run to the [l-r] before the tar covers the hallway. You seem to be in a peaceful crypt--before robed skeletons pop out from everywhere!"	"The tar entraps you!"	495
Crypt Creeps	2	"You slash wildly, hacking several with one blow. Go, Dirk!"	"There is nowhere to run. They push you into a tomb of your own, cackling."	495	1
Underground River	8	"You navigate to the left, remembering you row your oar on the right. Now there's a passage right in the next cavern! It flashes, which might kill you, but crashing into a wall certainly will."	"[splat-pur]."	379
Underground River	4	"You navigate to the right, remembering you row your oar on the left. If there's a trick special case, you're in trouble, but the passage left in the next cavern doesn't look like one!"	"[splat-pur]."	379
Underground River	8	"You navigate to the left. Now there's a passage right in the next cavern!"	"[splat-pur]."	379
Underground River	4	"You navigate to the right. As the water changes from purple to orange, you float along, past a sign saying YE RAPIDS, where you see a passage to the right and up It's dang near a road, a lighter orange than the rest of the river!"	"[splat-pur]."	379
Underground River	36	"Now that stripe is left and up."	"[or-scen]."	495
Underground River	40	"Now that stripe is right and up."	"[or-scen]."	495
Underground River	36	"Now it's left and up."	"[or-scen]."	495
Underground River	40	"Just as you worry the next part of the rapids will be a stripe leading into a cavern wall, the water changes to green as -- ding ding -- you are by YE WHIRLPOOLS. There's one to the left."	"[or-scen]."	495
Underground River	4	"Whirlpool to the right."	"[whirl-d]."	251
Underground River	8	"You paddle towards the whirlpool, then away. That's a trick those eggheads in adventuring class would never try! You forget why it works, but doing not thinking matters now. Whirlpool to the left."	"[whirl-d]."	251
Underground River	4	"Again with the contrary paddling. Whirlpool to the right."	"[whirl-d]."	251
Underground River	8	"One more reverse-paddle, for Roman Hruska. The water picks up speed. You're thrown into the air. But there's a chain there, up and to the right. It flashes and dings."	"[whirl-d]."	251
Underground River	6	"Got it! Your momentum swings you over to a ledge, where not one but two gates close behind you as you make it to the next area."	"The chain flashed and dinged for you, but it wasn't able to snag you as you fell back into the water. Too bad, Dirk."	495	1
Plummeting Disc	8	"Not too bad a jump. Half the ledge collapses, but amazingly, your half remains perfectly horizontal. You run away from it to a door, anyway."	"You try to jump but miss. AAAAAAAA!" 	3255	1
Avalanche	20	"You stumble out of the way of the rubble. For now. A door to the right flashes."	"You fall down the huge pit. AAAAAAA!"	251
Avalanche	4	"You exit through the flashing door just as a bunch of rocks tumble down where you were."	"[if lastmove bit-and 56 is 0]Unable or unwilling to run, you are trapped under a huge avalanche![else]You avoid the avalanche by falling to your doom. Okay, the avalanche actually catches up to you after a bit, but you're in no shape to notice.[end if]"	251	1
U and Pool Balls	16	"What luck! The red ball rolls by, and as you sneak through, it rolls back to be crushed by the black ball. Just in case you needed proof the black ball was destructive and not just scary.[paragraph break]Now there's an orange ball down below."	"You get smooshed by the black ball. Or the red[u-nfair]."	251
U and Pool Balls	16	"Now it's the orange ball's turn to crash into the black ball after missing you. You remember learning to cross a street watching for chariots, and how your parents told you it was no joke. They were right! Oh, look, a yellow ball down below."	"You get smooshed by the black ball. Or the orange[u-nfair]."	379
U and Pool Balls	16	"The yellow ball is not too yellow to crash into the black ball after missing you. Beyond it is a green ball."	"You get smooshed by the black ball. Or the yellow[u-nfair]."	379
U and Pool Balls	16	"The color variety is nice, especially because you forgot Roy G Biv, and it keeps you alert. If you had time to think, you'd be rather glad you weren't going to get killed by a dingy grey ball or a horrid pastel one. Since there's only a purple ball left below."	"You get smooshed by the black ball. Or the green[u-nfair]."	379
U and Pool Balls	16	"The color variety is nice, especially because you forgot Roy G Biv, and it keeps you alert. If you had time to think, you'd be rather glad you weren't going to get killed by a dingy grey ball or a horrid pastel one. Since there's only a purple ball left below. Well, it could be indigo or violet. You went to adventuring school, not art school."	"You get smooshed by the black ball. Or the blue[u-nfair]."	379
U and Pool Balls	16	"You feel a brief disorientation. There's a small gap up ahead, instead of a final indigo or violet ball, which is nice. And it's also up ahead, not down below, which just makes more sense. Man! It'd be embarrassing to miss this jump ahead, even with nobody watching."	"You get smooshed by the black ball. Or the purple. Being smooshed, you don't care about the details. Normally, 83% would be better than usual, Dirk, but here it's as good as 0%."	379
U and Pool Balls	32	"You jump over the small gap and have a leisurely jog to the next room."	"With the black ball not chasing you, you figure there's no way you can mess up the easy jump over a small craaaaaaaa..."	379	1
Cage	32	"Well, that wasn't too bad. You jump closer to the door."	"The electricity runs through you."	915
Cage	32	"You time the door perfectly! You jump just after it shuts. There's a narrow bridge across, with a huge flume of lava to the left. It sprays every few seconds."	"Hesitating, you time the jump through the door wrong as the electrical current approaches. SNAP!"	1326
Cage	8	"Your classmates made fun of you because you couldn't count, but man, you sure have timing down. The next flume misses you as you run left."	"Perhaps you felt guilty of your impeccable timing. Or perhaps you just have a fear of crumbly bridges. Or you wonder how the bridge survived the first flume. Whichever, it does not matter now where you are."	2191	1
Black Knight on Horse	8	"You execute a nice somersault to the left. At least you didn't have to roll backwards! You never quite got the hang of that. The knight comes thundering back on his horse. You got turned around, so the thorns are on your right, now."	"Too bad, Dirk! The black knight rides off with your helmet on his sword. How it got there, you may not have figured, and you may not want to know."	1939
Black Knight on Horse	8	"You got a weak grade in gymnastics, but you've got the practical part down. Another roll to the left, and you escape the knight again. Oh, look. There's a hole to the right! No thorns!"	"Too bad, Dirk! The black knight rides off with your helmet on his sword. How it got there, you may not have figured, and you may not want to know."	1939
Black Knight on Horse	4	"You dive for the hole and make it as the sword lashes against you."	"Too bad, Dirk! The black knight rides off with your helmet on his sword. How it got there, you may not have figured, and you may not want to know."	2675	1
Twirling Boulders	32	"You ignore computing the relevant angular velocities, instead concentrating: I don't want the left boulder to hit me, or the right. You don't stop fearing both til they both pass at once. Your mad sprint succeeds![paragraph break]A ghostly apparition--well, it's more a sheet than anything--opens its folds and draws a glowing weapon. You hear thorns spring up behind you and to the sides."	"You panic, worrying too much about maybe stepping at the wrong time, then close your eyes and run blindly through. WHAM!!! You are thrown back into a wall."	4026	--	4750
Twirling Boulders	2	"Shtwack! You've beaten lots scarier ghosts than that in practice. But thorns spring up to each side. You don't have time to think why the ghost was guarding that wall up ahead, either."	"As the ghost strikes you with a glowing rod, you worry any fellow slain adventurers will snark you couldn't even get that right."	2191
Twirling Boulders	16	"You escape the thorns! But now, since backward is forwards and forwards is backwards, (or they are what they were) the exit is up ahead!"	"You fail to move back away from the thorns."	1326
Twirling Boulders	32	"You made it, Dirk, and the exit didn't even have to flash at you! Way to go!"	"The thorns strangle you from behind. If they were particularly vicious or sentient, they'd feel lucky you seized up like that."	915	1
Lizard King	40	"You run forward some more after the magnetic pot. Uh-oh, Dirk! The Lizard king has you trapped from the right. He raises his scepter again."	"[konk]."	1939
Lizard King	4	"And now he is coming at you from the left! Lucky you, the pot doesn't seem to want to double back behind the Lizard King."	"[konk]."	1326
Lizard King	4	"And the left again! You know, it's sort of good the passages aren't branching here. The metal pot with your sword barely keeps in sight."	"[konk]."	1326
Lizard King	4	"The Lizard King raises his scepter again to the left. Well, it'd be kind of worrying if he popped up from the right. He's not fast enough, really."	"[konk]."	1326
Lizard King	4	"And again! Aren't those heavy robes going to take a toll soon?"	"[konk]."	1326
Lizard King	4	"That's moot now. You finally hit a dead end--and there's your sword! The metallic pot of gold sits there, trapped."	"[konk]."	2191
Lizard King	34	"You're just too much for the exhausted Lizard King, Dirk. Even with your sword getting stuck in the wall a few times. Eventually you get in a good cut, and the Lizard king vanishes. You snicker as you take a few gold pieces from the now-dormant (and un-charged) pot."	"You were so close, Dirk."	3255	1
Smithee	2	"Well, the sword being perpendicular to your sword, that gave a greater range--ah, heck, you just swung and it clanged. Ooh! Here comes a mace!"	"The magic sword descends on you. At least you weren't beaten by someone weaker than you."	915	--	1326
Smithee	2	"The mace isn't appreciably different. Well, it's appreciably not different to deflect. But now a glowing anvil up ahead rises and swerves at you. There's fire to your [r-l]."	"The mace gets too close before you realize you should swing your sword, which shatters."	1939	--	2191
Smithee	8	"Wow! You duck, but now a spear rises from a weapons rack and spins at you. Time it wrong, and you won't smack it just SO."	"You pause, then jump the wrong way into the fire. Or get clobbered into a wall by the flying anvil."	1326
Smithee	2	"Again, you hit the spear JUST perpendicular, and the angular momentum--nah, you just didn't want it to point straight at you. You treat your sword to a bit of magic fire, and a statue wakes up and growls, raising its axe."	"Wham! The spear smacks you just so. Well, it was a pretty tough practical physics problem, Dirk."	1326
Smithee	2	"BZZZZZ! Your sword and the axe clash, and your sword wins. The statue returns to its frozen state."	"It was compassionate to let the statue win, but it can't move, so it isn't too happy with you. Not that you're in the mood to be happy after that blow. Or unhappy."	915	1
Wind Tunnel	4	"Well, that jewel is certainly shiny, but that flashing door to the right gave off even more light! You tumble through it. And none too soon."	"You reach for the jewel, screaming as you fall into nothingness. You didn't even get the jewel. Well, there was no time to spend it."	379	1
Tentacle Room	2	"A tentacle that bright green is hard to miss. So is that weapon rack flashing on the wall up a ways."	"Now wasn't the time for amateur botany, Dirk!"	49
Tentacle Room	32	"You jump ahead just in time to escape some tentacles, and to see another squeezing down from above. Oh! Hey! There's that door out of here flashing to the right!"	"[tent-die]."	379
Tentacle Room	4	"The door shuts. Thank goodness the stairs behind you are flashing now!"	"[tent-die]."	495
Tentacle Room	20	"As you go right and climb the stairs, tentacles swarm down from there. Looks like you better retreat. Hey! That bench flashing to the left!"	"[tent-die]"	915
Tentacle Room	8	"Yours not to reason why, but that door ahead is open now--and flashing!"	"Well, you gave it your best shot, but there were too many tentacles coming from the stair. At least they don't insult you as they squeeze you to death."	1326
Tentacle Room	36	"One of your fellow adventurers would've stopped you to force you to calculate the possibility something like this would happen Or he would've stopped to calculate, himself. He would be dead. You are not. Onward!"	"It couldn't have been as easy as going through the open door, could it? Surely there was another flashing furniture to jump on, or a tentacle to slaaaaaaaaaaaaaa..."	1939	1
Snake Room	2	"And another snake!"	"Bummer, Dirk! Slashing up enemies mindlessly is your specialty, and now wasn't the time to mix it up."	495
Snake Room	2	"The third snake comes down more quickly!"	"Bummer, Dirk! Slashing up enemies mindlessly is your specialty, and now wasn't the time to mix it up."	2675
Snake Room	3	"You've got a small breather. That skull on a rope up ahead flashes helpfully. It doesn't look as fun to cut down as those snakes."	"Bummer, Dirk! Slashing up enemies mindlessly is your specialty, and now wasn't the time to mix it up."	49
Snake Room	36	"You grab it, revealing a trap door up. Go, Dirk!"	"You missed your chance, Dirk. You wait around, wondering if you should've pulled the skull, then finally wondering if fellow adventurers in heaven will laugh at you for not being clever enough to at least try, as a snake wraps itself around you."	1939	1
Goop Room	32	"You escape the first wave of goop only to look into a beaker--and out pops a goop monster! Good thing you grabbed it with your off-hand, Dirk."	"There are bloodier ways to die, but few less gross ways."	2191
Goop Room	2	"Splat! Most of the goop behind you disappears as you hack the monster."	"Your compassion or dawdling gains you no brownie points."	3255
Goop Room	16	"A huge goop-ghost flies out of the cauldron nearby!"	"You just walked right into the goop, there. Dirk. You don't even have time for childhood memories when that was fun."	3255
Goop Room	2	"The ectoplasm from the monster you killed starts covering you from below, up and the left. Good thing a door's to the right."	"You didn't need to stamp out the defeated enemy any more, Dirk. In fact, that was counterproductive. The goop holds you in place before swallowing you."	2191
Goop Room	4	"That's enough of this room."	"You wait for the next wave of goop, and there's more than you thought. Ugh!"	1326	1
Slide	8	"You tumble to the left. A weird bug-eyed stalk blocks your passage right across the narrow walkway!"	"You fall down the shaft. Really, that was sort of unfair, how quick it happened, but what did you expect, from an evil intelligent dragon?"	495
Slide	2	"And now there's another one, bigger, stronger! This isn't combat practice any more, Dirk."	"The stalk grabs you as you try to walk across."	1939
Slide	9	"You walk up the stairs, and they widen. Ooh! There's a shiny chain to pull ahead! It's a little more mesmerizing than the sensible flashing exit left. But if you don't pull it, you'll never know what happens."	"This time you're not quite ready. The stalk is too big. It drags you down!"	915
Slide	8	"You crawl through the flashing exit. The chain probably wouldn't have swung you through the exit."	"As the chain pulls, water rushes at you. It sort of fills the hole, which might help the next adventurer, but not you. The stairs flatten out into a slide like the one you entered the room on. You would reflect on the symmetry of it all, but you're too busy screaming."	1326	1
Giddy Goons	2	"You've learned by now that slashing at the first enemy is always a good start. Well, you sort of knew it already. But at least you didn't forget. Several weird piggies come bouncing from the left, now! But not as fast as if you hadn't taken care of business."	"Ouch! The underdog's grit and hustle (accompanied by several other underdogs, and their grit, and their hustle) catches you off-guard. You should have been more direct, Dirk."	379
Giddy Goons	4	"You head right. Maybe they'll tire out. Being that heavy while bouncing, well...whew. And those stairs just up ahead--they won't just be tiring for you."	"You take a slice at one, but two others cover your face."	1326
Giddy Goons	34	"The goons behind you hyperventilate a bit. They're far enough behind, you think you can deal with their bigger cousin that just popped out at the top. And you do, without thinking. You're at the top of the spiral staircase. You should probably hit that door to the left before anything pops up from it."	"You thought too much, Dirk, and that let the piggies catch up. Aigh!"	3255
Giddy Goons	41	"Good thinking, Dirk. Survive and advance. For whatever reason, the piggies don't follow you through the door. Maybe bouncing up and down that stairway was too exhausting."	"The piggies swarm you, not even thanking you for letting them avenge their cousin."	0	1
Fire and Lightning Room	4	"More lightning strikes from the ceiling! It surrounds you on all sides except to the left. Well, you could probably get away with going up, too."	"Ouch, Dirk! You had one way to go, but it didn't work out."	915
Fire and Lightning Room	40	"The lightning fire continues to burn to the right and above."	"Ouch, Dirk! You had a couple ways to go, but it didn't work out. The paradox of choice!"	1326
Fire and Lightning Room	24	"Another ray blasts the door ahead, making it impossible to go forward! There's also the matter of the right and back walls being on fire, too. But the fire to the left died. Too bad an overturned bench is blocking a possible crawlspace to the left. You'd think it'd have burned up.[paragraph break]It looks too sturdy--and close to the wall--to hack up, and if it's glued there, you're in trouble. If not, hmm..."	"Ouch, Dirk! You had a couple ways to go, but it didn't work out. The paradox of choice!"	915
Fire and Lightning Room	8	"Well, what do you know. You're able to move the bench and crawl through the passage."	"Ouch, Dirk! You had one way to go, but it didn't work out."	1326	1
Earthquake Room	8	"That's natural. Run where the landslide ain't. What's not natural are the spikes coming out from the wall that blocked you to the [l-r]."	""	1326	--	1939
Earthquake Room	32	"You tumble forward, and the ground crumbles behind and ahead of you. There's that wall on the [l-r], too."	"The spikes that impale you leave you unconscious before impact with the ground below. Yay?"	1939	--	2191
Earthquake Room	4	"There's a pool ahead! The bottom hasn't fallen out yet. Maybe it has. But you do know how to swim."	"You stay next to the wall, which is more solid than the ground, but unfortunately it's less supportive."	2191	--	2675
Earthquake Room	32	"Tentacles appear from the [r-l] and ahead after you dive."	"Perhaps an ancient fear of water prevented you from jumping in. As you fall, you look up. Why didn't the pool fall as well? Adventurers are often given to such philosophy late in life."	2675	--	3255
Earthquake Room	8	"Your sword would never go fast enough. You emerge, saying hi to your friend the [l-r] wall, again. It's doing a good job keeping the ground ahead together. For now."	"The tentacles wrap you up and save you from falling to your death. Unfortunately, drowning isn't much better."	3255	--	3551
Earthquake Room	32	"Ooh! You ran into a corner. And you can't go back. A spider descends to taunt you."	"You stay by your old friend the wall, the only thing that didn't collapse here. It stays with you as you fall all the way down."	3551	--	4026
Earthquake Room	2	"It's good to have some sword action after all that running. But now, back to being chased by whatever earthquakes are after you. The way behind is blocked. But the door is [r-l]."	"Ouch! Tough to change gears, Dirk. The spider grabs your head and even keeps you from falling once the ground crumbles. But it grabbed so hard, you aren't conscious enough to appreciate it."	4026
Earthquake Room	4	"You're by the door out of here, just ahead! To your relief, the ground quits crumbling. But then you realize it's rising--and you'll get crushed by the ceiling."	"Maybe you feel bad about killing the spider, or whatever. You don't have much time to think about it, though."	5000
Earthquake Room	32	"Whew! That was pretty intimidating, with all the crumbling ground, but you managed to go where the holes ain't. You sort of wish there was someone to congratulate you, so you could be a bit humble!"	"Well, you didn't get crushed, but you did fall backwards into the void."	4750	1
Bats and Walkway	32	"The walkway behind crumbles. But there's still more to go. Good thing this isn't a maze--that'd get confusing."	"Well, there wasn't that much out there to grab a hold of, you think, seeing the narrow passage up then right. Did you really have a chance?"	915
Bats and Walkway	40	"The walkway destruction stops just in time for bats to swoop you from the other way! How to ward them off?"	"The crumbling walkway catches up to you. It confuses the bats, sort of, but you're in no position to appreciate that."	915
Bats and Walkway	2	"Normal service is resumed. Well, except for the branching walkway flashing to the right. Oh no! Part of it disappeared as it flashed! Hey, no fair! Only doors are supposed to flash and disappear! I mean, you can probably jump over, but it's the principle of the thing."	"Oh, too bad! You missed a chance to lash out at the bats and take a break from running. It isn't their fault the walkway crumbled, but all the same, it'd have been nice."	2675
Bats and Walkway	4	"Oof! There's a bit of a gap to the right. With a ladder. But it's not like you can go back."	"It's the principle of the thing. It was your only way out, to the right, but ... AAAAAAA!"	915
Bats and Walkway	4	"You're strong enough, you're quick enough, and darn it, nature likes you! You hoist yourself up the ladder and out the door."	"So close, Dirk. As you fall to your doom, you figure the ladder wouldn't have held you anyway. You're just too big and strong."	3551	1
Electric Knight	4	"Ooh! Look! The knight mashes his sword, and now there's an opening to the [l-r]."	"[woulda-quick]."	1939	--	2191
Electric Knight	8	"And now it's ahead!"	"[woulda-quick]."	1939	--	2191
Electric Knight	32	"Boy. You sure are lucky there's a way out, even though the pulses are coming faster, The [l-r] is not glowing."	"[woulda-quick]."	2191	--	2675
Electric Knight	8	"The pulses come faster! Faster! Just like Reefer Madness. Wait, that doesn't exist yet. But a little space to the [r-l] does."	"[woulda-quick]."	1939	--	2191
Electric Knight	4	"You'd think the knight would try and push you down, leaving a space open. But it's kind of smart he's not letting you go up. He's just making you jump back and forth. There's an opening to the [l-r]."	"[woulda-quick]."	1939	--	2191
Electric Knight	8	"You jump forth and back. The knight doesn't see it, but you're cheating up with each movement, even as you jump faster. One more. The [l-r] is blocked."	"[woulda-quick]."	1939	--	2191
Electric Knight	4	"Okay, he's out of charges. And boy is it convenient you're right by him! And that he's winding up for his sword-blow like a baseball batter!"	"[woulda-quick]."	4026	--	4750
Electric Knight	2	"Well, that's as close to a talking villain as you can get, since nobody's done any talking, yet. There's a gap to jump over ahead, but that's nothing compared to the board."	"It was too hard to change gears from jumping around to your sword-waving. Or maybe you hoped that if you waited, the knight would chop off his own head as he drew his sword back. It doesn't matter now."	2191	1	2675
Bat King	2	"Well, now the bats are chased, pretty much every walkway crumbled except to the left."	"The bats are not strong enough to pick you up and drop you on the other side of the gap. They're strong enough to stick to your face, though."	1326
Bat King	8	"Oop! Some stairs are out ahead. The ones just beyond flash, not like you could go back in this narrow passage. You could just make it if you jump."	"Well, falling means you won't get mobbed by the bats. That's...something."	2191
Bat King	40	"Oh, hey, how's this for variety? A giant bat that can't fly stumbles out of a doorway and raises his wings. You can't exactly go back."	"Aaaa! That's not the way to jump the gap ahead."	1326
Bat King	2	"You can probably do anything at all. Your reflexes will kick in once the walkway behind crumbles."	"You'll never know what a hug from Princess Daphne feels like. Probably better than from the Bat King, you guess."	3551
Bat King	63	"Left through the door you go. Or is it up? No time to worry about directions."	"You really shouldn't have died this way."	49	1
Electric Throne	4	"The circular rug continues to roll you up from the left. More of the circle is closing."	"Zzzzzzap! Megavolts, coming right up."	1326
Electric Throne	36	"The circle's almost closed. The throne is to the right."	"Zzzzzzap! Megavolts, coming right up."	3255
Electric Throne	4	"The throne spins you around as your scabbard snaps back in place. An electric charge comes along the wire. Yes! A door to the right!"	"Zzzzzzap! Megavolts, coming right up."	2675
Electric Throne	4	"You stumble out before the electricity gets to you."	"You always wondered what it'd be like to have a nice long seat on a fancy throne. Too bad you can't be alive for it."	1939	1
Vanishing Checkerboard	16	"Well, you're safe for now. That is, relatively. You're standing on two tiles, about to do a leg-split, farther away from the two exits up ahead than before."	"Your weight must've caused the nearby tiles to fall a bit quicker. You consider this hypothesis during the long tumble down."	1939
Vanishing Checkerboard	32	"Oh! Look! Both ways are there! Your momentum is carrying you up, but the door left is flashing. You can't quite remember what was ahead, but it wasn't a door."	"Your next jump doesn't get you anywhere nearer the exits, or to a more populated area to jump. You fall to your doom."	2675
Vanishing Checkerboard	8	"Whew! Good thing the door had a stair ledge."	"Wrong choice, Dirk! Ahead leads to a cage. You scream and rattle the bars, but no luck."	1939	1
Mud Monsters	2	"The mud monsters back up a bit, allowing passage ahead. You can't see them, but you hear their blurp bloop blurp behind and may even do so in the next room."	"[mudmon-yay]."	1326
Mud Monsters	33	"Oo! A green geyser to jump over! It just finished firing! And it flashed, too! Double bonus!"	"[mudmon-yay]."	1326
Mud Monsters	32	"You see a sneaky passage between two geysers ahead."	"[mudmon-yay]."	2191
Mud Monsters	36	"Oh, hey, there's a path ahead to the next geyser!"	"[mudmon-yay]."	2675
Mud Monsters	32	"The green geyser just ahead fires. The passage is kind of narrow, so you can't really walk around it."	"[mudmon-yay]."	1326
Mud Monsters	32	"Wow! A wide red pool of mud, and you on a plank being followed by mud men. Thank goodness it's up high, so you can jump a bit farther."	"[mudmon-yay]."	1326
Mud Monsters	32	"And one more green geyser ahead!"	"[mudmon-yay]."	1326
Mud Monsters	32	"You hear a squilching sound behind--like when you cut previous enemies open with a sword. But the mud monsters don't die--they appear in small geysers to the side. You forget how not-fair this is when you see the exit across one final green river! If you were more of a naturalist, you might be disappointed you didn't get to jump a red geyser, too, but really, it's time to move on. It was...straightforward."	"[mudmon-yay]."	1326
Mud Monsters	36	"You jump across the green river without and flume to blast you. Solid ground! A nice wide exit! That was both straightforward and exhausting. You needed all your adventurer training to get through, for sure."	"[mudmon-yay]."	1326	1
pd2	8	"There're actually three jumps, here. You decide to be all fancy and go for the lowest floor, like you get style points for it or something."	"You miss the jump, even though you've prepped for this before. As you tumble, you wonder what your peers would think."	3255	1	[note: 49-1939-3255 vs 124-2191-3255. And L-R-L for this every 3 stops...]
Dragon's Lair	8	"You're not just brawn, Dirk! You're quickness, too! You catch the pile of trinkets before it falls, and the dragon doesn't wake up enough. Well, he does, enough to send out a gout of flame. Fortunately there's a gold pile to your left!"	"It's not your fault the trinkets fall to the ground, but the dragon doesn't seem to care. You are roasted!"	1326
Dragon's Lair	8	"You duck behind the gold pile. The dragon falls asleep. You go up to Princess Daphne's bubble. She knows a lot more than the other adventurers say she did! Maybe they were scared of Singe's castle and just didn't want to admit it. She tells you about the key around the dragon's neck and the magic sword. And the dragon sleeps through it! Of course, it helps that you aren't one of those smart-alecks who would've laughed at the dragon for keeping something so lethal so near. And not even hiding it. That would've blown your cover.[wfak]But then you hear a rattling. More trinkets are jangling to the left!"	"Oh no, Dirk! The flame catches you. Your scream alerts the dragon he was right to be paranoid. But it's too late for him to thank you for making it easy."	1939
Dragon's Lair	8	"You catch the trinkets again! You wonder if the dragon is too lazy to pay anyone to clean his place up, neglecting that it's a neat extra security measure to have stuff that can fall over like this. But not for long. The dragon wakes up, sniffing around a bit more. He knows a few times is a coincidence. He sees you and chases you behind a pillar! One of his claws above grasps at it, and to the right..."	"This time, the dragon wakes up for good. He doesn't care that it was his flame that maybe upset his jewelry. You're an intruder. Well, you were."	-1326
Dragon's Lair	24	"You bolt away from the pillar! You're just quick enough to...hide behind another very similar pillar of a different color. Again the claws above and right."	"The dragon grabs you and squeezes you to death. This wasn't the ending embrace you'd hoped for."	2191
Dragon's Lair	24	"Again you flee! There aren't many pillars to hide behind, and only so many gold piles. Wait! There it is! A reflective pillar to the right! You forgot your physics, Dirk, but it's all round and the dragon can probably bounce flame off it at any angle."	"No, there wasn't any trick to this. The dragon's got you. Sorry, Dirk."	2191
Dragon's Lair	4	"One last time, you hide behind a pillar. And what do you see ahead but--the magic flaming sword! You don't need heavenly voices to tell you what it is, but you can't grab it til you approach it."	"The dragon is not just sly at hand-to-hand combat. He knows a few angles. Maybe he got some of his wealth at pool hu--oops, that's not important. What is, is, you're fried to a crisp."	3255
Dragon's Lair	36	"You jump towards the sword! But it's too un-dramatic to grab it right away. Still, with Singe bearing down on you, best grab it. He breathes out..."	"The flame from the sword has nothing on Singe's flame, as you find out."	2191
Dragon's Lair	6	"The magic sword repels the flame! You need to keep it up, though. Daphne applauds. Don't get distracted, Dirk!"	"There is no fleeing. Singe burns you up."	3551
Dragon's Lair	2	"The magic sword does not break. Singe looks a little worried. But you're too close to him--right or down--to throw the sword, and stabbing him won't do enough damage."	"So close, Dirk. You die without feeling guilty that now Singe will hide the sword somewhere really tough, so the next adventurer won't luck out, and without worrying what the other adventurers will say and think of you as a result. It's best that way."	4026
Dragon's Lair	40	"You step back, ready to throw the magic sword. Hopefully it is magic enough to stick in his neck tip first."	"You try for combat immediately, but--wrong choice."	4750
Dragon's Lair	2	"You throw the sword. Right in the neck! Singe collapses. You take the key from his neck and unlock Daphne. Mushiness ensues. Way to go, Dirk![paragraph break]Now how do you get out of here?[wfak]While you're thinking, the castle itself begins to crumble. Your adventures caused so much structural damage, the Dragon crashing to its death started off an earthquake. With debris dropping everywhere, you and Daphne can only run towards each flashing door you see. But you're all over that by now, man![wfak]"	"Oh no, Dirk! You fall at the final hurdle[if drag-kill > 1 and lives-left > 1]. Or maybe you know exactly what you're doing--as greedy for maximum points as Singe was for treasure. Daphne sobs as she looks on, uncomprehending. Are those extra points really worth it?[else if lives-left > 1]. Or maybe you're trying for a few last points, like this guy: https://stevenf.com/2014/05/21/arcade-story/?[else if lives-left is 0], and you don't have any chances left. Pathos![end if][in-drag]"	5000	1

to say in-drag:
	increment drag-kill;
	
to say mudmon-yay:
	say "With no resistance, the monsters stuff you in a mud stream. You become one of them. It's not so bad. Who knows, you might help the next adventurer to join in your zen. If you remember what an adventurer is by that time. All you need to do is live your life straightforwardly as time goes ahead and ahead. Surely running the mud monster gauntlet couldn't have been that easy...or could it?"

to say woulda-quick:
	say "Oh no! You saw the right way to go. This wasn't it"

to say tent-die:
	say "Unable to find an unblocked way, you stay and try to flail your sword as more tentacles appear, but it does no good. As they grab you, you remember being told you need to know when to flee. But then, you also remember being told it won't be anything obvious like a flashing door. This enrages you further as you realize the truth in your final moment"
	
to say konk:
	say "KONK! You pass out with a goofy smile on your face. That's...something. The lizard king drags you away"

chapter dircheating

dir-cheat is a truth state that varies.
dircheating is an action out of world.

understand the command "dircheat" as something new.

understand "dircheat" as dircheating.

carry out dircheating:
	now dir-cheat is whether or not dir-cheat is false;
	say "Direction cheating is now [if dir-cheat is true]on[else]off[end if].";
	the rule succeeds;

chapter liing

liing is an action out of world.

understand the command "li" as something new.

understand "li" as liing.

carry out liing:
	now inf-lives is whether or not inf-lives is false;
	if inf-lives is true:
		say "[one of]You have a vision of two kids in a castle with weird lights and noises. They tie a coin around a string and sticking them into some sort of booth and giggling. Man! You always wanted to learn to yo-yo.  You're gonna do that once you crack this castle. (You now have infinite lives.)[or]The vision of the giggling kids returns. [stopping][paragraph break]";
	else:
		say "You have a visions of a no fun looking adult [one of][or]once again [stopping]apprehending the two kids with the coin on the string and frog marching them away from the booth. The kids are kicked out![paragraph break]At least they weren't thrown in the castle dungeon off to the side. That's what the place with the scary singing animals must be.";
	the rule succeeds;

volume beta testing - not for release

[I usually have a volume like this so you can comment/uncomment it. My final runthrough (in theory) makes sure the text is gone. Most of my beta testing commands made it to the game proper (li and dircheat) so this is pretty blank.]

when play begins:
	say "Generic warning to set beta testing volume to not for release.";

volume testing - not for release

chapter gting

[* this kicks you to the room in row X in the table of gameorder]

gting is an action applying to one number.

understand the command "gt" as something new.

understand "gt [number]" as gting.

carry out gting:
	choose row number understood in table of gameorder;
	move player to myroom entry;
	now is-mirrored is mirrored entry; [important or else the descriptions can be reversed]
	prime-next-area;
	the rule succeeds.
	
chapter dbing

[* this edits the debug state]

dbing is an action out of world.

understand the command "db" as something new.

understand "db" as dbing.

carry out dbing:
	now debug-state is whether or not debug-state is false;
	say "Debug state = [debug-state].";
	the rule succeeds;

chapter ying

[* this lists what is remaining for you to do]

ying is an action out of world.

understand the command "y" as something new.

understand "y" as ying.

carry out ying:
	repeat through table of gameorder:
		if sol entry is false:
			say "Still need to do [myroom entry] - [mirrored entry].";
	the rule succeeds;

chapter tests

[* room tests from 1 to 39]

test r1 with "l/l/l/l";
test r2 with "r/r/r/r";
test r3 with "u";
test r4 with "l/r/l/r/r/r";
test r5 with "r/l/r/l/l/l";
test r6 with "r";
test r7 with "u/s/u/s/r/s";
test r8 with "u/s/u/s/l/s";
test r9 with "l/r/l/r/u/u/u/u/r/l/r/l/r";
test r10 with "l";
test r11 with "r";
test r12 with "r/r";
test r13 with "d/d/d/d/d/d/u";
test r14 with "u/u/l";
test r15 with "l/l/r";
test r16 with "u/s/d/u";
test r17 with "u/s/d/u";
test r18 with "l/r/r/r/r/r/s";
test r19 with "s/s/r/s/s";
test r20 with "s/s/l/s/s";
test r21 with "r";
test r22 with "s/u/r/d/l/u";
test r23 with "s/s/s/u";
test r24 with "u/s/d/s/r";
test r25 with "l/s/l/l";
test r26 with "s/r/u/u";
test r27 with "r/u/d/l";
test r28 with "r/u/l/u/r/u/s/l/u";
test r29 with "l/u/r/u/l/u/s/r/u";
test r30 with "u/u/s/r/r";
test r31 with "l/r/u/r/l/r/l/s";
test r32 with "r/l/u/l/r/l/r/s";
test r33 with "s/l/u/s/s";
test r34 with "r/u/r/r";
test r35 with "d/u/l";
test r36 with "s/u/u/u/u/u/u/u/u";
test r37 with "l";
test r38 with "r";
test r39 with "l/l/l/l/d/r/u/s/s/u/s"

test rall with "test r1/test r2/test r3/test r4/test r5/test r6/test r7/test r8/test r9/test r10/test r11/test r12/test r13"

test rnext with "test r14/test r15/test r16/test r17/test r18/test r19/test r20/test r21/test r22/test r23/test r24/test r25/test r26"

test rlast with "test r27/test r28/test r29/test r30/test r31/test r32/test r33/test r34/test r35/test r36/test r37/test r38/test r39"

test ofudge with "s/test r28/test r29/test r30/test r31/test r32/test r33/test r34/test r35/test r36/test r37/test r38"