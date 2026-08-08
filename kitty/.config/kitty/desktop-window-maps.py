#!/usr/bin/env python3

"""Enable Kitty window shortcuts outside tiling window managers."""

import os
import sys

desktop = " ".join(
    filter(
        None,
        (
            os.environ.get("XDG_CURRENT_DESKTOP"),
            os.environ.get("XDG_SESSION_DESKTOP"),
            os.environ.get("DESKTOP_SESSION"),
        ),
    )
).lower()

tiling_desktops = (
    "aerospace",
    "awesome",
    "bspwm",
    "dwl",
    "hyprland",
    "i3",
    "niri",
    "qtile",
    "river",
    "sway",
    "yabai",
)

# Linux desktops expose their session name through XDG variables. macOS does
# not, so it keeps the mappings by default; set KITTY_TILING_WM=1 when launching
# Kitty from a macOS tiling WM such as AeroSpace or yabai.
forced_tiling = os.environ.get("KITTY_TILING_WM", "").lower() in ("1", "true", "yes")
detected_tiling = sys.platform != "darwin" and any(
    name in desktop for name in tiling_desktops
)
is_tiling = forced_tiling or detected_tiling

if not is_tiling:
    print("""\
map cmd+enter new_window
map cmd+shift+k move_window up
map cmd+shift+h move_window left
map cmd+shift+l move_window right
map cmd+shift+j move_window down
map cmd+h       neighboring_window left
map cmd+l       neighboring_window right
map cmd+k       neighboring_window up
map cmd+j       neighboring_window down
map cmd+n       next_layout""")
