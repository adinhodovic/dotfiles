#!/usr/bin/env python3
import json
import subprocess

ICON = ""


def get_notifications():
    try:
        # GitHub CLI must be logged in: gh auth login
        result = subprocess.run(
            ["gh", "api", "notifications"], capture_output=True, text=True, check=True
        )
        notifications = json.loads(result.stdout)
        count = len(notifications)
        return count
    except subprocess.CalledProcessError as e:
        return -1  # CLI error
    except json.JSONDecodeError:
        return -2  # bad JSON


def main():
    count = get_notifications()
    if count < 0:
        text = f"{ICON} ✗"  # three trailing spaces
        tooltip = "Error: run `gh auth login` or check API access"
        klass = "error"
    elif count == 0:
        text = f"{ICON}"  # three trailing spaces
        tooltip = "No unread GitHub notifications"
        klass = "zero"
    else:
        text = f"{ICON} {count}"  # two spaces before, three after
        tooltip = f"{count} unread GitHub notifications"
        klass = "unread"

    print(json.dumps({"text": text, "tooltip": tooltip, "class": klass}))


if __name__ == "__main__":
    main()
