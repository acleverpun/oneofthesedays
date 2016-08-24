#!/usr/bin/env bash

scripts/clean.sh

moonc -t dist .

for map in assets/maps/*.tmx; do
	output=$(echo "$map" | sed 's;\.tmx$;.lua;')
	tiled --export-map "$map" "$output"
done
