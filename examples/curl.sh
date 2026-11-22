#!/usr/bin/env bash
# Apple Podcasts Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~apple-podcasts-leads"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Active SaaS and startup shows with an owner email (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchTerms": [
      "saas",
      "startup"
    ],
    "activeWithinDays": 30,
    "onlyWithEmail": true
  }'

# 2. UK fitness shows with 20+ episodes (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchTerms": [
      "fitness"
    ],
    "country": "gb",
    "minEpisodes": 20,
    "maxResults": 200
  }'

# 3. The current US top 100 chart (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "topCharts": true,
    "searchTerms": [],
    "maxResults": 100
  }'
