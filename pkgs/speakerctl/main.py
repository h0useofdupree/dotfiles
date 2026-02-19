#!/usr/bin/env python3
import argparse
import json
import os
import sys
import time
import tinytuya as tt

CONFIG_PATH = os.environ.get(
    "SPEAKERCTL_DEVICES_FILE", "/run/agenix/speakerctl-devices"
)


def load_devices():
    try:
        with open(CONFIG_PATH, "r") as f:
            data = json.load(f)
            devices = []
            for d in data:
                # Pass connection_timeout directly to the constructor
                device = tt.OutletDevice(
                    dev_id=d["id"],
                    address=d["ip"],
                    local_key=d["key"],
                    connection_timeout=5,  # This is the correct way for most versions
                )
                device.set_version(float(d.get("version", 3.3)))
                devices.append(device)
            return devices
    except Exception as e:
        print(f"Error loading config from {CONFIG_PATH}: {e}")
        sys.exit(1)


def set_state(devices, state, retries=3):
    for device in devices:
        success = False
        for attempt in range(retries):
            try:
                if state == 1:
                    result = device.turn_on()
                else:
                    result = device.turn_off()

                if "Error" not in result:
                    success = True
                    break
                else:
                    print(
                        f"Attempt {attempt + 1} failed for {device.address}: {result.get('Error')}"
                    )
            except Exception as e:
                print(f"Attempt {attempt + 1} exception for {device.address}: {e}")

            time.sleep(1)  # Wait before retry

        if not success:
            print(
                f"FAILED: Could not switch device {device.address} after {retries} attempts."
            )


def print_status(devices):
    for device in devices:
        try:
            # heartbeat/status check
            status = device.status()
            print(f"Device {device.id} (@{device.address}):")
            print(json.dumps(status, indent=2))
        except Exception as e:
            print(f"Error getting status for {device.address}: {e}")


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
