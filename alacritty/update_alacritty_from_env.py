import os
from tomlkit import parse, dumps

config_path = os.path.expanduser("~/.config/alacritty/alacritty.toml")

# Load the existing configuration
with open(config_path, "r") as f:
    config = parse(f.read())

# Update font family and size based on environment variables
config["font"]["size"] = float(os.getenv("ALACRITTY_FONT_SIZE", 14))
config["font"]["normal"]["family"] = os.getenv("ALACRITTY_FONT_FAMILY", 'FiraCode Nerd Font')

# Save the updated configuration
with open(config_path, "w") as f:
    f.write(dumps(config))
