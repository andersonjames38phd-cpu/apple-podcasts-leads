"""Apple Podcasts Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Active SaaS and startup shows with an owner email
run = client.actor("Turboextract/apple-podcasts-leads").call(run_input={
    "searchTerms": [
        "saas",
        "startup"
    ],
    "activeWithinDays": 30,
    "onlyWithEmail": True
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("title"), item.get("ownerEmail"), item.get("episodeCount"), item.get("lastEpisodeDate"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
