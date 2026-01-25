from libqtile import qtile
import subprocess
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.command.client import InteractiveCommandClient
import sys

import time

def qtile_to_screen_hook( dest_name ):
    logger.warning("screenshot taken")
    c = InteractiveCommandClient()

    source_name = c.group.info()["name"]
    scrot_cmd="scrot -q 10 -o ~/dotfiles/eww/images/qtile-scrot/"
    file_name=f"{source_name}.jpg"
    subprocess.run( scrot_cmd+file_name, shell=True)
    time.sleep(.1)

    c.group[ dest_name ].toscreen(0)
    file_name=f"{dest_name}.jpg"
    subprocess.run( scrot_cmd+file_name, shell=True)

if len(sys.argv) > 1:
    qtile_to_screen_hook( sys.argv[1])
else:
    print("Group name must be provided to select a group.")
