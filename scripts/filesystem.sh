#!/bin/bash

# Function to get filesystem information in MB
get_filesystem_info() {
    mountpoint="/"
    used=$(df -BM --output=used / | tail -n 1)
    total=$(df -BM --output=size / | tail -n 1)
    used=${used//[^0-9]/}  # Extract only numeric values (removes 'M' suffix)
    total=${total//[^0-9]/}  # Extract only numeric values (removes 'M' suffix)
    
    # Convert MB to GB
    used_gb=$(echo "scale=2; $used / 1024" | bc)
    total_gb=$(echo "scale=2; $total / 1024" | bc)
    
    echo "$used_gb GB/$total_gb GB"
}

# Handle the action when module is clicked
handle_click() {
    thunar /
}

# Main function to print output based on Polybar action
main() {
    case "$1" in
        --output)
            get_filesystem_info
            ;;
        --click-left)
            handle_click
            ;;
        *)
            echo "unknown action"
            ;;
    esac
}

main "$@"
