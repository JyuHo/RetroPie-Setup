#!/bin/bash
config="$1"
rom="$2"
rom_bn="${rom%.*}"

pushd "${0%/*}" >/dev/null
if [[ -z "$rom" ]]; then
    ./uae4arm
elif [[ "$rom" == *.uae ]]; then
    ./uae4arm -config="$rom" -G
else
    source "../../lib/archivefuncs.sh"

    archiveExtract "$rom" ".adf .adz .dms"

    # check successful extraction and if we have at least one file
    if [[ $? == 0 ]]; then
        for i in {0..3}; do
            [[ -n "${arch_files[$i]}" ]] && images+=(-$i "${arch_files[$i]}")
        done
        name="${arch_files[0]}"
    elif [[ -n "$rom" ]]; then
        name="$rom"
        # try and find the disk series
        base="${name##*/}"
        base="${base%Disk*}"
        i=0
        while read -r disk; do
            images+=(-$i "$disk")
            ((i++))
            [[ "$i" -eq 4 ]] && break
        done < <(find "${rom%/*}" -iname "$base*" | sort)
        [[ "${#images[@]}" -eq 0 ]] && images=(-0 "$rom")
    fi

    # if no config or auto provided, then look for rom config or choose automatically 
    if [[ -z "$config" || "$config" == "auto" ]]; then
        # check for .uae file with the same base name as the adf/zip
        if [[ -f "$rom_bn.uae" ]]; then
            config="$rom_bn.uae"
        else
            if [[ "$name" =~ AGA|CD32 ]]; then
                config="conf/rp-a1200.uae"
            else
                config="conf/rp-a500.uae"
            fi
        fi
    else
        # add conf directory
        config="conf/$config"
    fi

    ./uae4arm -config="$config" "${images[@]}" -G
    archiveCleanup
fi

popd