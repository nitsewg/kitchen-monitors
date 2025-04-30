#!/bin/bash
email="wgeorge@monettschools.org"
echo "Downloading and installing uv."
curl -LsSf https://astral.sh/uv/install.sh | sh
echo "Running uv sync to install dependencies."
uv sync --no-dev
echo "Setting up cron job to run every 2 hours."
line="0 */2 * * * /home/pi/kitchen-monitors/checktemp.sh"
crontab -l | { cat; echo "$line"; } | crontab -
line2="0 */6 * * * cd /home/pi/kitchen-monitors/ && git pull"
crontab -l | { cat; echo "$line2"; } | crontab -
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
            break
            ;;
        2)
            location="MECC"
            break
            ;;
        3)
            location="MIS"
            break
            ;;
        4)
            location="MMS"
            break
            ;;
        5)
            location="MHS"
            break
            ;;
        6)
            location="SRTC"
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
            temp="60"
            break
            ;;
        2)
            type="Freezer"
            temp="40"
            break
            ;;
        *)
            echo "Invalid input. Please enter 1 or 2."
            ;;
    esac
done


echo "You selected $type".
echo "Building info.csv"
device="$location-$type"
echo "$temp,$device,$email" > /home/pi/kitchen-monitors/info.csv
echo "All done!  It should run every 2 hours."