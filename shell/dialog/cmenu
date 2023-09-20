#!/bin/bash

# Functions
prs () { printf $@ > /dev/tty ; }           # prevent printing from being piped to another program
filter_func () { grep -F "$searchtext" ; }  # the function applied to input to filter out results
cursor_hide () { prs '%b' '\e[?25l' ; }
cursor_show () { prs '%b' '\e[?25h' ; }

# create a unique but reusable file id
get_index_file_hash () { get_md5_hash "$searchtext" ; } 
get_prev_index_hash () { get_md5_hash "${searchtext::-1}" ; }
get_md5_hash () {
	# if case-insensitive search is on, use same file for upper and lower case variants of $searchtext
	$case_matters && tohash=$1 || tohash=$(tr '[:upper:]' '[:lower:]' <<< "$1")
	md5sum <<< "$tohash" | sed 's/  -//g'
}

# replace tabs with the appropriate number of spaces while reading stdin
clean_input () {
	result=''
	tabs='    '
	for ((i=0; i<${#inline}; i++)); do
		c=${inline:$i:1}
		case $c in
		# tab
		($'\t')
			result=$result$tabs
			tabs=''
		;;
		(*)
			result=$result$c
			tabs=${tabs::-1}
		;;
		esac
		[[ $tabs == '' ]] && tabs='    '
	done
	inline=$result
}

# see if the item matches on the search text
filter_check () {
	# remove ANSI escape codes from item to only compare text characters to search string
	if [[ $(sed 's/\(\x1b\|\\e\)\[[0-9;?=]*[a-zA-Z]//g' <<< ${stdin_orig[$idx]} | filter_func) ]]; then
		handle_filtered_item
		echo $idx >> $filename
	fi
}

# do some stuff once you've got yourself a filtered item
handle_filtered_item () {
	let 'count+=1'
	# if filter removes the previously selected item from list, select the next available item instead
	! $selected && [[ $idx -gt $select_idx ]] && select_idx=$idx
	# set some values if the selected item is matched
	[[ $idx == $select_idx ]] && select_menu_idx=$count && selected=true
	 prev_idx=$idx
}

# filtering after a backspace, which means the new filter string results have already been cached
filter_search () {
	get_select_index
	count=-1
	prev_idx=-1
	selected=false
	max_height=$(($(tput lines)-1))
	hash=$(get_index_file_hash)
	filename="$index_file$hash"
	cache_done=false
	# the previously filtered indexes don't require re-filtering
	if [[ -f $filename ]]; then
		while read -rs idx; do
			[[ "$idx" == "done" ]] && cache_done=true && break
			handle_filtered_item
		done < $filename
	else
	# if this filter hasn't been cached, build off of the previous filter
		if [[ ! -z $searchtext ]]; then
			# read from previous cache of indexes
			prev_hash=$(get_prev_index_hash)
			prev_filename="$index_file$prev_hash"
			if [[ -f $prev_filename ]]; then
				while read -rs idx; do
					[[ "$idx" == "done" ]] && cache_done=true && break
					filter_check
				done < $prev_filename
				$cache_done && echo 'done' >> $filename
			fi
		fi
	fi
	# if the filter was previously interrupted, finish filtering on original input
	if ! $cache_done; then
		for (( idx=$(($prev_idx+1)); idx<${#original_indexes[@]}; idx++ )); do
			filter_check
		done
		echo 'done' >> $filename
	fi
	
	# if filter shrinks list past selected item, select the first item
	! $selected && select_idx=$prev_idx && select_menu_idx=$count
	# if the filter results in no valid items, set the indexes to defaults
	[[ $count -lt 0 ]] && select_idx=-1 && select_menu_idx=-1
	
	# make sure newly filtered items print on screen
	[[ $select_menu_idx -le $max_height ]] && start_menu_idx=0 ||
	start_menu_idx=$(($select_menu_idx-$max_height+2))
	# cache indexes
	save_menu_index
	save_select_index
	save_start_index
}

# print items on screen
print_menu () {
	get_menu_index
	get_select_index
	get_start_index
	count=-1
	item_width=$(($(tput cols)-2))
	max_height=$(($(tput lines)-1))
	hash=$(get_index_file_hash)
	filename="$index_file$hash"
	cursor_hide
	# move cursor to top of screen
	prs '\e[H'
	# read from file of current indexes
	while read -rs idx; do
		let 'count+=1'
		# when done, clear rest of screen and stop printing
		[[ "$idx" == 'done' ]] && prs '\n%b\e[0J' $clr_default && break
		# skip items that are before the first on-screen item
		[[ $count -lt $start_menu_idx ]] && continue
		# set color for current item
		[[ $count == $select_menu_idx ]] && clr_line=$clr_select || clr_line=$clr_default
		# get value of item
		item="${stdin[$idx]}"
		# if item contains color codes, change the "reset" code to be the currently selected color instead
		item=$(echo -e "$item" | sed "s/\x1b\[0m/\x1b${clr_line:2}/g")
		# trim item to fit on screen and print
		prs '\n%b>%b %s\e[K' $clr_select $clr_line ${item::$item_width}
		# stop printing once bottom of screen is reached
		[[ $(($count-$start_menu_idx+2)) == $(($max_height)) ]] && break
	done < $filename
	# clear the progress bar
	prs '%b\e[\r%iB\e[K' $clr_default $max_height
	# go back to top of screen and print search text
	print_search
}

# print the prompt and user-typed search string
print_search () {
	cursor_hide
	search_width=$(tput cols)
	# replace tabs in the search text with spaces (for math purposes)
	search_field=$(echo $prompt$searchtext | sed 's/\t/    /g')
	# figure out how much of the search bar would end up off-screen
	search_overflow=$((${#search_field}-$search_width+1))
	[[ $search_overflow -lt 0 ]] && search_overflow=0
	# scroll the prompt and search string to the left if needed, so that the cursor is always on screen
	prs '%b\e[H\r%s\e[K' $clr_default $(echo "${search_field:$search_overflow}" | cut -c 1-$search_width)
	# to prevent screen flickering, this is always the last thing we print before showing the cursor again
	cursor_show
}

# add or remove highlighting from selected item
deselect_item () { highlight_selected $clr_default ; }
reselect_item () { highlight_selected $clr_select ; }
highlight_selected () {
	get_menu_index
	get_select_index
	get_start_index
	wait $print_proc
	if [[ $select_menu_idx -ge 0 ]] && [[ $select_idx -ge 0 ]]; then
		item_width=$(($(tput cols)-2))
		cursor_hide
		# move cursor to selected item
		prs '\e[%iB' $(($select_menu_idx-$start_menu_idx+1))
		# reprint selected item with default color
		item="${stdin[$select_idx]}"
		item=$(echo -e "$item" | sed "s/\x1b\[0m/\x1b${1:2}/g")
		prs '\r%b>%b %s\e[0K' $clr_select $1 ${item::$item_width}
	fi
	# return cursor to search text
	print_search
}

# get the indexes of all currently filtered items
get_indexes () {
	if $need_index_refresh; then
		hash=$(get_index_file_hash)
		filename="$index_file$hash"
		indexes=()
		while read -rs idx; do
			[[ "$idx" == 'done' ]] && break
			indexes+=($idx)
		done < $filename
		need_index_refresh=false
	fi
}

# cache management functions
read_cache () { read -rs $1 2>/dev/null < $2; }
save_cache() { rm $2 2>/dev/null; echo "$1" > $2; }

get_menu_index () { read_cache select_menu_idx $menu_file ; }
save_menu_index () { save_cache $select_menu_idx $menu_file ; }

get_start_index () { read_cache start_menu_idx $start_file ; }
save_start_index () { save_cache $start_menu_idx $start_file ; }

get_select_index () { read_cache select_idx $select_file ; }
save_select_index () { save_cache $select_idx $select_file ; }

# kill background filtering shell and start new one
update_filter () {
	kill $filter_proc 2>/dev/null
	filter_search &
	filter_proc=$!
}

# kill background printing shell and start new one
reprint () {
	kill $print_proc 2>/dev/null
	max_height=$(($(tput lines)-1))
	# reset cursor if it was mid-print
	cursor_hide && prs '%b\e[\r%iB\e[K\e[H' $clr_default $max_height
	# if selected item is highlighted, remove highlighting to indicate to user that menu is updating
	$need_deselect && deselect_item && need_deselect=false
	# start background shell
	queue_print &
	print_proc=$!
}

# wait for filtering to finish in the background before printing
queue_print () {
	dots=''
	next_dot=' .'
	dot_time=0
	dot_cycle=1
	# check for filtering in a loop since we can't use "wait" command from the background printing shell
	while [[ ! -z $filter_proc ]] && $(kill -0 $filter_proc 2>/dev/null); do
		# let's not be too hasty
		sleep .01
		# print some 'in progress' dots to tell the user things are working
		let 'dot_time+=1'
		# update dots every 10 iterations of loop
		if [[ $dot_time == 10 ]]; then
			dot_time=0
			# one dot + one space = 2, three dots + three spaces = 6
			if [[ ${#dots} -ge 6 ]]; then
				dots=''
				# after printing dots, overwrite them one at a time for that sleek "in progress" look
				if [[ $dot_cycle == 1 ]]; then
					next_dot='  '
					dot_cycle=0
				else
					next_dot=' .'
					dot_cycle=1
				fi
			fi
			dots=$dots$next_dot
			max_height=$(($(tput lines)-1))
			cursor_hide
			# print dots
			prs '%b\e[\r%iB%s' $clr_default $max_height $dots
			# move cursor back to top of screen
			print_search
		fi
	done
	# once filtering is done we can finally print the menu
	print_menu
}

# do some housekeeping when the script exits
cleanup () {
	# kill any in-progress background shells
	kill $filter_proc 2>/dev/null
	kill $print_proc 2>/dev/null
	# start background shell to clear old cache files
	rm -rf $cache_dir &
	# restore previous contents of terminal if possible, otherwise clear screen
	tput rmcup > /dev/tty || prs '\e[H\e[J'
}

##########################
### Script Starts Here ###
##########################

# Initial setup
IFS=''                     # do not ignore whitespace on input
searchtext=''              # user-typed filter
case_matters=true          # is filtering case sensitive or not
prompt=': '                # text at top of screen before the search filter
clr_select='\e[0;30;47m'   # black text with white highlight
clr_default='\e[0m'        # default colors

# read command line arguments
arg_flag=''
for arg in "$@";
do
	# if a flag was set, set a value based on the nxt argument
	if [[ ! -z $arg_flag ]]; then
		case "$arg_flag" in
		('-p')  
			# set prompt text
			prompt="$arg"
		;;
		('-c')  
			# set highlight color (using ANSI escape codes)
			clr_select="$arg"
		;;
		(*)
			echo "Could not parse argument $arg_flag"
			exit 1
		;;
		esac
		arg_flag=''
		continue
	fi
	# if the previous argument was not a flag, handle it here
	case "$arg" in
	('-p'|'-c')
		# these are flags and require the next argument to be processed
		arg_flag=$arg
	;;
	('-c1'|'-c2'|'-c3'|'-c4')  
		# preset custom highlight colors
		[[ "$arg" == "-c1" ]] && clr_select='\e[0;44;37m'  # white on blue
		[[ "$arg" == "-c2" ]] && clr_select='\e[0;34;42m'  # blue on green
		[[ "$arg" == "-c3" ]] && clr_select='\e[0;30;43m'  # black on yellow
		[[ "$arg" == "-c4" ]] && clr_select='\e[0;37;41m'  # white on red
	;;
	('-i')
		# use case-insensitive filtering
		filter_func () { grep -F -i "$searchtext" ;}
		case_matters=false
	;;
	(*)
		# if the argument wasn't handled by now, it isn't a valid argument
		echo "Could not parse argument $arg"
		exit 1
	;;
	esac
done
# if a flag was set but not handled, then it isn't a valid argument
[[ ! -z $arg_flag ]] && echo "Argument $arg_flag requires an additional value" && exit 1

# directory to store files so the $filter_proc and $print_proc background shells can communicate
cache_dir=~/.cache/cmenu/active_
# use a unique identifier for this cache so other instances of cmenu do not conflict
cache_ID=$$$(date +%s%N) # process id + seconds + nanoseconds
while [[ -e $cache_dir$cache_ID ]]; do
	cache_ID=$$$(date +%s%N)
done
cache_dir=$cache_dir$cache_ID

# initialize the temporary stuff
filter_proc=              # pid of background shell that is running the filter
print_proc=               # pid of background shell that is printing the menu on screen
tput smcup > /dev/tty     # save current contents of terminal
prs '\e[H\e[J'            # move cursor to top of screen and clear it
mkdir -p $cache_dir       # create cache directory

# kill background shells, delete cache, and restore screen on CTRL+c
trap "{ cleanup ; exit 1 ; }" 2

# cache files
index_file="$cache_dir/cmenu_indexes"  # combine with the hash of $searchtext to keep track of filtered indexes
select_file="$cache_dir/cmenu_select"  # holds the index of the selected item
menu_file="$cache_dir/cmenu_menu"      # holds the on-screen index of the selected item
start_file="$cache_dir/cmenu_start"    # holds the index of the first item printed on screen
# important indexes and other values
select_idx=0        # index of selected item in stdin
select_menu_idx=0   # index of selected item on screen
start_menu_idx=0    # index of item in stdin that is first to print on screen
select_item=''      # value of selected item
need_index_refresh=false  # is our indexes() array up to date or not
need_deselect=false       # do we need to remove the highlight from screen

# print the search bar while the input loads
print_search

# read piped input
stdin=()       # strings of input text for displaying
stdin_orig=()  # unaltered input text for outputting
indexes=()     # indexes of menu items
if test ! -t 0; then
	hash=$(get_index_file_hash)
	filename="$index_file$hash"
	rm $filename 2>/dev/null
	count=0
	while read -rs inline; do
		stdin_orig+=($inline)
		clean_input
		stdin+=($inline)
		indexes+=($count)
		echo "$count" >> $filename
		let 'count+=1'
	done
	echo "done" >> $filename
fi
# keep unfiltered indexes in memory
original_indexes=( ${indexes[@]} )

# Main():
save_select_index
save_menu_index
save_start_index
reprint
wait $print_proc
loop=true
while $loop; do
	# wait for user input
	read -rs -N 1 key  </dev/tty
	# get additional input for escape characters
	while read -rs -t0 </dev/tty; do
		read -rs -N 1 </dev/tty
		key=$key$REPLY
	done
	# parse input
	case $key in
	# Up arrow
	($'\x1b[A'|$'\x1bOA')
		# don't do anything if filtering is in progress
		if ! $(kill -0 $filter_proc 2>/dev/null); then
			get_indexes
			get_menu_index
			get_start_index
			# if we aren't at the first item
			if [[ $select_menu_idx -gt 0 ]]; then
				max_height=$(($(tput lines)-3))
				# if scrolling, don't need to remove highlighting fronm top row
				[[ $select_menu_idx -lt $(($start_menu_idx+1)) ]] || deselect_item
				let 'select_menu_idx-=1'
				save_menu_index
				select_idx=${indexes[$select_menu_idx]}
				save_select_index
				# if scrolling, need to reprint the whole screen
				if [[ $select_menu_idx -lt $start_menu_idx ]]; then
					let 'start_menu_idx-=1'
					save_start_index
					# update the top-most item so we can see that you are scrolling
					kill $print_proc 2>/dev/null
					prs '\e[H'
					reselect_item
					reprint
				else
					# if not scrolling, just re-apply highlighting
					reselect_item
				fi
			fi
		fi
	;;
	# Down arrow
	($'\x1b[B'|$'\x1bOB')
		# don't do anything if filtering is in progress
		if ! $(kill -0 $filter_proc 2>/dev/null); then
			get_indexes
			get_menu_index
			get_start_index
			# if we aren't at the last item
			if [[ $select_menu_idx -lt $((${#indexes[@]}-1)) ]]; then
				max_height=$(($(tput lines)-3))
				# if scrolling, don't need to remove highlighting from bottom row
				[[ $select_menu_idx -gt $(($start_menu_idx+$max_height-1)) ]] || deselect_item
				let 'select_menu_idx+=1'
				save_menu_index
				select_idx=${indexes[$select_menu_idx]}
				save_select_index
				# if scrolling, need to reprint the whole screen
				if [[ $select_menu_idx -gt $(($start_menu_idx+$max_height)) ]]; then
					let 'start_menu_idx+=1'
					save_start_index
					# since menu prints top-down, update the bottom selected item first so we can see it
					kill $print_proc 2>/dev/null
					prs '\e[H'
					reselect_item
					reprint
				else
					# if not scrolling, just re-apply highlighting
					reselect_item
				fi
			fi
		fi
	;;
	# ESC
	($'\x1b')
		# stop the presses and output the empty string
		loop=false
		select_item=''
	;;
	# Backspace
	($'\x7f'|$'\b')
		# only backspace if there is something to backspace
		if [[ ! -z $searchtext ]]; then 
			searchtext="${searchtext::-1}"
			need_index_refresh=true
			need_deselect=true
			update_filter
			reprint
		fi
	;;
	# Enter
	($'\n')
		# wait for any filtering to finish and output the selected result
		loop=false
		wait $filter_proc
		get_select_index
		[[ $select_idx -ge 0 ]] && select_item="${stdin_orig[$select_idx]}"
	;;
	# Typed characters to apply to search text
	(*)
		# make sure it is not a control character (except tabs are cool)
		if [[ ! -z $key ]] && [[ $key == $'\t' ]] || [[ ! $key =~ [[:cntrl:]] ]]; then
			searchtext="$searchtext$key"
			need_index_refresh=true
			need_deselect=true
			update_filter
			reprint
		fi
	;;
	esac
done

# kill background shells, delete cache, restore screen
cleanup
# print the final results to stdout
echo -e "$select_item"
