#!/bin/bash

analyze_sort_and_paginate() {
    local page_size=10
    local current_page=0
    local total_lines=$(du -sh * 2>/dev/null | sort -rh | wc -l)
    local total_pages=$(( (total_lines + page_size - 1) / page_size ))

    while true; do
        clear
        echo "Page $((current_page + 1)) of $total_pages"
        du -sh * 2>/dev/null | sort -rh | tail -n +$((current_page * page_size + 1)) | head -n $page_size

        if (( (current_page + 1) * page_size >= total_lines )); then
            echo "End of results."
            break
        fi

        read -p "Press Enter to see next page, or type 'q' to quit: " input
        if [[ $input == "q" ]]; then
            break
        fi

        current_page=$((current_page + 1))
    done
}

analyze_sort_and_paginate
