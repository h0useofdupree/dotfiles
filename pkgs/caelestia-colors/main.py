#!/usr/bin/env python3
"""Generate color configuration files from Caelestia's scheme.json.

Currently supports Hyprland and can be extended with new writers by
adding functions to the WRITERS mapping.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path


SCHEME_PATH = Path.home() / ".local/state/caelestia/scheme.json"


def load_scheme(path: Path) -> dict[str, str]:
    with path.open() as f:
        data = json.load(f)
    return data.get("colours", {})


def write_hypr(colors: dict[str, str], out_dir: Path | None = None) -> None:
    """Write Hyprland color variables."""

    out_dir = out_dir or Path.home() / ".config/hypr"
    out_dir.mkdir(parents=True, exist_ok=True)
    out_file = out_dir / "color-vars.conf"

    lines = [f"${name} = 0xff{value.lower()}" for name, value in colors.items()]
    out_file.write_text("\n".join(lines) + "\n")


WRITERS = {
    "hyprland": write_hypr,
}


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Sync Caelestia colour scheme to config files"
    )
    parser.add_argument(
        "--scheme", default=SCHEME_PATH, type=Path, help="Path to scheme.json"
    )
    parser.add_argument(
        "--targets",
        nargs="*",
        default=list(WRITERS.keys()),
        help="Targets to generate (default: all)",
    )
    args = parser.parse_args()

    colors = load_scheme(args.scheme)
    for target in args.targets:
        writer = WRITERS.get(target)
        if writer:
            writer(colors)


if __name__ == "__main__":
    main()
