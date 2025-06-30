#!/usr/bin/env python3
import argparse
import json
import os
import sys
import tinytuya as tt

CONFIG_PATH = os.path.expanduser("~/.config/speakerctl/devices.json")


def load_devices():
    try:
        with open(CONFIG_PATH, "r") as f:
            data = json.load(f)
            devices = []
            for d in data:
                device = tt.OutletDevice(
                    dev_id=d["id"],
                    address=d["ip"],
                    local_key=d["key"],
                )
                device.set_version(d.get("version", 3.3))
                devices.append(device)
            return devices
    except Exception as e:
        print(f"Error loading config from {CONFIG_PATH}: {e}")
        sys.exit(1)


def set_state(devices, state):
    for device in devices:
        try:
            if state == 1:
                device.turn_on()
            else:
                device.turn_off()
        except Exception as e:
            print(f"Error setting state for device {device.id}: {e}")


def print_status(devices):
    for i, device in enumerate(devices, start=1):
        try:
            status = device.status()
            print(f"Device {i} ({device.id} @ {device.address}): {status}")
        except Exception as e:
            print(f"Error getting status for device {device.id}: {e}")


def main():
    parser = argparse.ArgumentParser(description="Speaker Control via TinyTuya")
    parser.add_argument("-1", "--on", action="store_true", help="Turn speakers ON")
    parser.add_argument("-0", "--off", action="store_true", help="Turn speakers OFF")
    parser.add_argument("--verbose", action="store_true", help="Show device status")
    args = parser.parse_args()

    devices = load_devices()

    if args.on:
        set_state(devices, 1)
    elif args.off:
        set_state(devices, 0)

    if args.verbose:
        print_status(devices)


if __name__ == "__main__":
    main()
