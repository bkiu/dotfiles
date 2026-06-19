#!/bin/bash
# keycomb.sh
# Used with https://github.com/bulletmark/libinput-gestures

EVDEVICE=/dev/input/event2

for key in $@; do
    evemu-event $EVDEVICE --type EV_KEY --code KEY_$key --value 1 --sync
done


# reverse order
for (( idx=${#@}; idx>0; idx-- )); do
    evemu-event $EVDEVICE --type EV_KEY --code KEY_${!idx} --value 0 --sync
done
