#!/bin/bash

INPUT="data/prices.csv"
OUTPUT="data/report.txt"
TODAY=$(date "+%Y-%m-%d")

echo "📈 Rapport quotidien - $TODAY" > "$OUTPUT"
echo "-----------------------------" >> "$OUTPUT"

COLUMNS=("printstream" "cobalt" "hypnotic" "kumicho" "blaze")

for skin in "${COLUMNS[@]}"; do
  prices=$(awk -F',' -v col="$skin" '
    NR==1 {
      for(i=1;i<=NF;i++) if ($i==col) idx=i
    }
    $1 ~ /^'"$TODAY"'/ {print $idx}
  ' "$INPUT")

  if [ -z "$prices" ]; then
    echo "$skin : aucune donnée" >> "$OUTPUT"
  else
    min=$(echo "$prices" | sort -n | head -n1)
    max=$(echo "$prices" | sort -n | tail -n1)
    avg=$(echo "$prices" | awk '{sum+=$1} END {printf "%.2f", sum/NR}')
    echo "$skin : min €$min / max €$max / moyenne €$avg" >> "$OUTPUT"
  fi
done
