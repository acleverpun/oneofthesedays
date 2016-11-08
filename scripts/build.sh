#!/usr/bin/env bash

moonc -t dist vendor lib src {conf,main}.moon
if [ -f local-conf.moon ]; then moonc -t dist local-conf.moon; fi

for map in assets/maps/*.tmx; do
	output=$(echo "$map" | sed 's;\.tmx$;.lua;')
	tiled --export-map "$map" "$output"
done
