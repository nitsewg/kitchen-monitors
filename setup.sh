#!/bin/bash
#email="wgeorge@monettschools.org"
echo "Downloading and installing uv."
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
echo "Running uv sync to install dependencies."
uv sync --no-dev
echo "Setting up cron job to run every 2 hours."
line="0 */2 * * * /home/pi/kitchen-monitors/checktemp.sh"
crontab -l | { cat; echo "$line"; } | crontab -
line2="0 */6 * * * cd /home/pi/kitchen-monitors/ && git pull"
crontab -l | { cat; echo "$line2"; } | crontab -
line3="0 3 * * 6 sudo reboot"
crontab -l | { cat; echo "$line3"; } | crontab -
while true; do
    echo "Enter the number for the campus:"
    echo "1 - MES"
    echo "2 - MECC"
    echo "3 - MIS"
    echo "4 - MMS"
    echo "5 - MHS"
    echo "6 - SRTC"
    read campus

    case "$campus" in
        1)
            location="MES"
            email="es-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        2)
            location="MECC"
            email="ec-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        3)
            location="MIS"
            email="is-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        4)
            location="MMS"
            email="ms-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        5)
            location="MHS"
            email="hs-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        6)
            location="SRTC"
            email="tc-kitchen-monitors@g-apps.monett.k12.mo.us"
            break
            ;;
        *)
            echo "Invalid input. Please enter 1-6."
            ;;
    esac
done

echo "You selected: $location"

while true; do
    echo "What are you monitoring?"
    echo "1 - Cooler"
    echo "2 - Freezer"
    read unit

    case "$unit" in
        1)
            type="Cooler"
            break
            ;;
        2)
            type="Freezer"
            break
            ;;
        *)
            echo "Invalid input.  Please enter 1 or 2."
    esac
done

case "$type" in
    "Cooler")
        temp="60"
        ;;
    "Freezer")
        temp="40"
        ;;
    *)
        echo "Something went wrong, please format info.csv as temp,devicename,emailaddress"
        exit 1
        ;;
esac

echo "You selected $type".
echo "Building info.csv"
device="$location-$type"
echo "$temp,$device,$email" > /home/pi/kitchen-monitors/info.csv
echo "All done!  It should run every 2 hours."
