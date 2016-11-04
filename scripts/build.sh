#!/usr/bin/env bash

moonc -t dist lib src {conf,main}.moon

for map in assets/maps/*.tmx; do
	output=$(echo "$map" | sed 's;\.tmx$;.lua;')
	tiled --export-map "$map" "$output"
done
