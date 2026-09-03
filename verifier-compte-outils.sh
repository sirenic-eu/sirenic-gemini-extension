#!/usr/bin/env bash
# Le compte d'outils annoncé par ce dépôt ne peut PAS être interpolé : il n'y a
# ici que du texte, et la constante qui le porte (NB_OUTILS_MCP) vit dans le
# service. Deux libellés l'affirment donc en dur — README.md et la description
# du serveur dans gemini-extension.json — et rien ne les gardait : au 78ᵉ outil
# ils seraient restés faux sans qu'aucune erreur ne sorte, sur une fiche
# publique de la galerie Gemini.
#
# Ce contrôle les confronte à la SEULE source qui fasse foi : le catalogue
# réellement servi par `tools/list` en production. Il refuse aussi de passer à
# vide — une phrase reformulée qui perdrait la mention est un ÉCHEC, pas un
# silence.
set -euo pipefail

SERVEUR="${SIRENIC_MCP:-https://api.sirenic.eu/mcp}"
ATTENDU_MENTIONS=2

# `tools/list` est anonyme et gratuit sur /mcp (le paywall x402 porte sur les
# appels d'outils, pas sur le catalogue). La réponse peut arriver en JSON ou en
# SSE selon la négociation : les deux sont pelés ici.
brut="$(curl -sS --max-time 30 -X POST "$SERVEUR" \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}')"
servi="$(printf '%s\n' "$brut" | sed 's/^data: //' | grep -v '^event:' | grep -v '^$' \
  | jq -r 'select(.result != null) | .result.tools | length' | head -1)"

if ! printf '%s' "$servi" | grep -qE '^[0-9]+$' || [ "$servi" -eq 0 ]; then
  echo "REFUS : le catalogue n'a pas pu être compté sur $SERVEUR (réponse : ${brut:0:200})" >&2
  exit 1
fi

mentions="$(grep -ohE '\b[0-9]+ tools\b' README.md gemini-extension.json || true)"
nb_mentions="$(printf '%s' "$mentions" | grep -c . || true)"
if [ "$nb_mentions" -ne "$ATTENDU_MENTIONS" ]; then
  echo "REFUS : $ATTENDU_MENTIONS mentions « N tools » attendues (README.md, gemini-extension.json), $nb_mentions trouvée(s)." >&2
  echo "        Un libellé reformulé sort du contrôle : le remettre, ou corriger ATTENDU_MENTIONS ici." >&2
  exit 1
fi

valeurs="$(printf '%s\n' "$mentions" | grep -oE '^[0-9]+' | sort -u)"
if [ "$(printf '%s\n' "$valeurs" | grep -c .)" -ne 1 ]; then
  echo "REFUS : les deux libellés annoncent des nombres DIFFÉRENTS : $(printf '%s ' $valeurs)" >&2
  exit 1
fi

if [ "$valeurs" != "$servi" ]; then
  echo "REFUS : ce dépôt annonce $valeurs outils, la production en sert $servi." >&2
  echo "        Corriger README.md et gemini-extension.json (et la fiche de la galerie suit au prochain crawl)." >&2
  exit 1
fi

echo "OK : $servi outils servis par $SERVEUR, $nb_mentions libellés d'accord."
