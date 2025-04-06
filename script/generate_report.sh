#!/bin/bash

CSV="data/prices.csv"
REPORT="data/report.txt"

if [ ! -f "$CSV" ]; then
  echo "Pas de données disponibles pour générer un rapport." > "$REPORT"
  exit 0
fi

# Récupération de la date du jour (sans l'heure)
TODAY=$(date "+%Y-%m-%d")

# Extraction de l'en-tête et des lignes du jour
HEADER=$(head -n 1 "$CSV")
SKINS=(${HEADER//,/ })  # split par virgule

LINES_TODAY=$(grep "^$TODAY" "$CSV")

if [ -z "$LINES_TODAY" ]; then
  echo "Aucune donnée collectée pour aujourd'hui ($TODAY)." > "$REPORT"
  exit 0
fi

# Création temporaire d’un fichier
TMPFILE=$(mktemp)
echo "$LINES_TODAY" > "$TMPFILE"

{
  echo "🗓 Rapport financier du jour - $TODAY"
  echo ""

  for ((i=1; i<${#SKINS[@]}; i++)); do
    SKIN=${SKINS[$i]}

    # Récupération des colonnes pour ce skin
    PRICES=$(cut -d',' -f$((i+1)) "$TMPFILE" | grep -v "N/A")

    if [ -z "$PRICES" ]; then
      echo "❌ $SKIN : Données manquantes pour la journée."
      echo ""
      continue
    fi

    # Conversion en tableau bash
    readarray -t PRICE_ARRAY <<< "$PRICES"

    OPEN=${PRICE_ARRAY[0]}
    CLOSE=${PRICE_ARRAY[-1]}

    # Calcul de variation en %
    if [ "$OPEN" != "0" ]; then
      CHANGE=$(awk "BEGIN { printf \"%.2f\", (($CLOSE - $OPEN)/$OPEN)*100 }")
    else
      CHANGE="N/A"
    fi

    # Volatilité (écart-type)
    COUNT=${#PRICE_ARRAY[@]}
    SUM=0
    for price in "${PRICE_ARRAY[@]}"; do
      SUM=$(awk "BEGIN { print $SUM + $price }")
    done
    MEAN=$(awk "BEGIN { print $SUM / $COUNT }")

    SUM_SQUARE=0
    for price in "${PRICE_ARRAY[@]}"; do
      DIFF=$(awk "BEGIN { print $price - $MEAN }")
      SUM_SQUARE=$(awk "BEGIN { print $SUM_SQUARE + ($DIFF * $DIFF) }")
    done
    VOLATILITY=$(awk "BEGIN { printf \"%.4f\", sqrt($SUM_SQUARE / $COUNT) }")

    echo "🔫 $SKIN"
    echo "  - Prix ouverture : ${OPEN}€"
    echo "  - Prix clôture   : ${CLOSE}€"
    echo "  - Évolution      : ${CHANGE}%"
    echo "  - Volatilité     : ${VOLATILITY}"
    echo ""
  done
} > "$REPORT"

# Nettoyage
rm "$TMPFILE"
