#!/usr/bin/env python3
import json
import subprocess


def is_paused():
    """Check if Dunst is paused"""
    result = subprocess.run(["dunstctl", "is-paused"], capture_output=True, text=True)
    return result.stdout.strip().lower() == "true"


def main():
    paused = is_paused()
    if paused:
        icon = ""  # bell-slash + padding
        tooltip = "Do Not Disturb: ON"
        klass = "muted"
    else:
        icon = ""  # bell + padding
        tooltip = "Do Not Disturb: OFF"
        klass = "active"

    print(json.dumps({"text": icon, "tooltip": tooltip, "class": klass}))


if __name__ == "__main__":
    main()
