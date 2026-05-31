#!/usr/bin/env bash
path="${1:-$PWD}"
max=30

[[ "$path" == "$HOME"* ]] && path="~${path#$HOME}"
(( ${#path} <= max )) && { printf '%s' "$path"; exit; }

if   [[ "$path" == "~/"* ]]; then root="~"; rest="${path#~/}"
elif [[ "$path" == "/"*  ]]; then root="";  rest="${path#/}"
else                               root="";  rest="$path"
fi

IFS='/' read -ra parts <<< "$rest"
kept="${parts[-1]}"

for (( i = ${#parts[@]} - 2; i >= 0; i-- )); do
    try="${root}/…/${parts[$i]}/${kept}"
    (( ${#try} <= max )) && kept="${parts[$i]}/${kept}" || break
done

printf '%s' "${root}/…/${kept}"
