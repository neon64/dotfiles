#!/bin/python3

# from: https://github.com/tobiaspc/wofi-scripts
# modified to include drun menu as well
# TODO: migrate this from Python to get much quicker startup times!! (perhaps should be a mode integrated into wofi?)
#       see this issue: https://todo.sr.ht/~scoopta/wofi/117

from argparse import ArgumentParser
import subprocess
import json

enter="\n"

# Returns a list of all json window objects
def get_windows():

    command="swaymsg -t get_tree"

    active_outputs = []

    process = subprocess.Popen(command,shell=True,stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    data = json.loads(process.communicate()[0])

    # Select outputs that are active
    windows = []
    for output in data['nodes']:

        # The scratchpad (under __i3) is not supported
        if output.get('name') != '__i3' and output.get('type') == 'output':
                workspaces = output.get('nodes')
                for ws in workspaces:
                    if ws.get('type') == 'workspace':
                        windows += extract_nodes_iterative(ws)
    return windows

# Extracts all windows from a sway workspace json object
def extract_nodes_iterative(workspace):
    all_nodes = []

    floating_nodes = workspace.get('floating_nodes')

    for floating_node in floating_nodes:
        all_nodes.append(floating_node)

    nodes = workspace.get('nodes')

    for node in nodes:

        # Leaf node
        if len(node.get('nodes')) == 0:
            all_nodes.append(node)
        # Nested node, handled iterative
        else:
            for inner_node in node.get('nodes'):
                nodes.append(inner_node)

    return all_nodes

# Returns an array of all windows
def parse_windows(windows):
    parsed_windows = []
    for window in windows:
        parsed_windows.append(window.get('name'))
    return parsed_windows

# Returns a newline seperated UFT-8 encoded string of all windows for wofi
def build_wofi_string(windows):
    return enter.join(windows).encode("UTF-8")

# Returns the sway window id of the window that was selected by the user inside wofi
def parse_id(windows, parsed_windows, selected):
    selected = (selected.decode("UTF-8"))[:-1] # Remove new line character
    if selected == "":
        return None
    window_index = int(parsed_windows.index(selected)) # Get index of selected window in the parsed window array
    return str(windows[window_index].get('id')) # Get sway window id based on the index

# Switches the focus to the given id
def switch_window(id):
    command="swaymsg [con_id={}] focus".format(id)

    process = subprocess.Popen(command,shell=True,stdout=subprocess.PIPE)
    process.communicate()[0]

# Entry point
if __name__ == "__main__":

    # launch combined window switcher and app menu
    command="wofi -S dmenu,drun -i"

    process = subprocess.Popen(command,shell=True,stdin=subprocess.PIPE,stdout=subprocess.PIPE)
    print("opened wofi")

    parser = ArgumentParser(description="Wofi based window switcher")

    windows = get_windows()

    parsed_windows = parse_windows(windows)

    wofi_string = build_wofi_string(parsed_windows)

    print("sending windows to wofi")
    selected = process.communicate(input=wofi_string)[0]

    selected_id = parse_id(windows, parsed_windows, selected)

    if selected_id is not None:
        switch_window(selected_id)
