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

echo "$location-$type"