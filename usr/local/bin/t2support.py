from re import search
from requests import get
from os import walk
from os.path import join, islink
from shutil import chown
from sys import exit
from textwrap import wrap
from itertools import chain

user = "t2server"
install_parent = "/opt"
install_dir = f"{install_parent}/t2server"
etc_dir = "/etc/t2server"
log_dir = "/var/log/t2server"
unit_dir = "/etc/systemd/system"
bin_dir = "/usr/local/bin"
release_file = f"{etc_dir}/release"

config_defaults = {
    'ServerPrefs' : 'Classic_CTF.cs',
    'Mod'         : 'Classic',
    'Public'      : False,
    'OverrideMITM': False,
    'Heartbeat'   : False,
    'DSOCleanup'  : True,
    'MissionType' : 'CTF',
    'MapList'     : False
}

class color:
    X = '\033[m'        # Reset
    DR = '\033[31m'     # Dark Red
    DG = '\033[32m'     # Dark Green
    DY = '\033[33m'     # Dark Yellow (Brown)
    DU = '\033[34m'     # Dark Blue
    DP = '\033[35m'     # Dark Purple
    DC = '\033[36m'     # Dark Cyan
    DW = '\033[37m'     # Dark White (light grey)
    BK = '\033[90m'     # Bright Black (dark grey)
    BR = '\033[91m'     # Bright Red
    BG = '\033[92m'     # Bright Green
    BY = '\033[93m'     # Bright Yellow
    BU = '\033[94m'     # Bright Blue
    BP = '\033[95m'     # Bright Purple
    BC = '\033[96m'     # Bright Cyan
    BW = '\033[97m'     # Bright White

class box:
    TR = u'\u2510'
    TL = u'\u250c'
    BR = u'\u2518'
    BL = u'\u2514'
    H  = u'\u2500'
    V  = u'\u2502'

def menu(option_list,header="",footer=""):
    """ 
    This function takes a list of options and make a BBS-style menu out of them.
    Each item should have a unique alphanum in square brackets (eg. "[Q]uit" or "[1] Quit") 
    that represents the letter the user will type to select that option. Additionally, one 
    option may start with ~~ to indicate that it is the default option. This option will be 
    selected if the user presses Enter without typing a letter. ~~ will not be displayed on
    screen. The function returns the selected letter in uppercase.
    """
    default=None
    keys=[]
    line_list=list(option_list)

    if header:
        header_list = wrap(header,width=76)
        line_list.extend(header_list)
    else:
        header_list = None

    if footer: 
        footer_list = wrap(footer,width=76)
        line_list.extend(footer_list)
    else:
        footer_list = None

    longest = max(list(chain((len(ele) for ele in line_list),[40])))

    print(f"{color.BG}{box.TL}{box.H}{''.ljust(longest,box.H)}{box.H}{box.TR}{color.X}")
    print(f"{color.BG}{box.V} {''.ljust(longest)} {color.DG}{box.V}{color.X}")
    if header_list: 
        for line in header_list:
            print(f"{color.BG}{box.V} {color.DG}{line.ljust(longest)} {box.V}{color.X}")
        print(f"{color.BG}{box.V} {''.ljust(longest)} {color.DG}{box.V}{color.X}")
    for option in option_list:
        try:
            key=search(r'\[([0-9a-zA-Z])\]', option).group(1)
        except AttributeError:
            bail("Error while processing menu option list.")
        if option.startswith("~~"): 
            default = str(key)
            keys.append(key.upper())
            option=option[2:]
        else:
            keys.append(str(key).lower())
        option=option.ljust(longest)
        option=option.replace("[", color.BG + "[" + color.BW)
        option=option.replace("]", color.BG + "]" + color.DG)
        option=color.DG + option + color.X
        print(f"{color.BG}{box.V} {option.ljust(longest)} {color.DG}{box.V}{color.X}")
    if footer_list: 
        print(f"{color.BG}{box.V} {''.ljust(longest)} {color.DG}{box.V}{color.X}")
        for line in footer_list:
            print(f"{color.BG}{box.V} {color.DG}{line.ljust(longest)} {box.V}{color.X}")
    print(f"{color.BG}{box.V} {''.ljust(longest)} {color.DG}{box.V}{color.X}")
    print(f"{color.BG}{box.BL}{color.DG}{box.H}{''.ljust(longest,box.H)}{box.H}{box.BR}{color.X}")
    menu_choice=" "
    if default: 
        prompt=f"{color.DG}Choice {color.BK}({color.BG}{default}{color.BK}){color.DG}: {color.X}"
    else:
        prompt=f"{color.DG}Choice: {color.X}"
    while menu_choice.upper() not in [x.upper() for x in keys]:
        menu_choice = str(input(prompt))
        if default and menu_choice == "": menu_choice = default
    return menu_choice.upper()

def chowner(path, owner):
    """ Recursively chown path with owner as both user and group """
    for dirpath, ignore, filenames in walk(path):
        chown(dirpath, owner, owner)
        for filename in filenames:
            if not islink(join(dirpath, filename)):
                chown(join(dirpath, filename), owner, owner)

def pinfo(message):
    print(color.BU + message + color.X)

def pwarn(message):
    print(color.BY + message + color.X)

def perror(message):
    print(color.BR + message + color.X)

def bail(message=""):
    exit(color.BR + message + color.X)

if __name__ == "__main__":
    bail("This file contains only shared functions and variables for the other scripts and is not meant to be run interactively.")