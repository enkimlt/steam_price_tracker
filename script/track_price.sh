#!/bin/bash

OUTPUT="data/prices.csv"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

declare -A SKINS
SKINS["printstream"]="Desert%20Eagle%20%7C%20Printstream%20%28Factory%20New%29"
SKINS["blaze"]="Desert%20Eagle%20%7C%20Blaze%20%28Factory%20New%29"
SKINS["cobalt"]="Desert%20Eagle%20%7C%20Cobalt%20Disruption%20%28Factory%20New%29"
SKINS["hypnotic"]="Desert%20Eagle%20%7C%20Hypnotic%20%28Factory%20New%29"
SKINS["kumicho"]="Desert%20Eagle%20%7C%20Kumicho%20Dragon%20%28Factory%20New%29"

if [ ! -f "$OUTPUT" ]; then
  echo "timestamp,printstream,blaze,cobalt,hypnotic,kumicho" > "$OUTPUT"
fi

LINE="$TIMESTAMP"

ORDER=("printstream" "blaze" "cobalt" "hypnotic" "kumicho")

for key in "${ORDER[@]}"; do
  URL="https://steamcommunity.com/market/priceoverview/?appid=730&currency=3&market_hash_name=${SKINS[$key]}"
  PRICE=$(curl -s "$URL" | grep -oP '"lowest_price":"\K[^"]+')

  if [ -z "$PRICE" ]; then
    PRICE="N/A"
  else
    PRICE=$(echo "$PRICE" | sed 's/€//' | sed 's/,/./')
  fi

  LINE="$LINE,$PRICE"
done

echo "$LINE" >> "$OUTPUT"
echo "DEBUG: script finished at $(date)" >> data/debug.log
