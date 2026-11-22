// Apple Podcasts Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// UK fitness shows with 20+ episodes
const run = await client.actor('Turboextract/apple-podcasts-leads').call({
    "searchTerms": [
        "fitness"
    ],
    "country": "gb",
    "minEpisodes": 20,
    "maxResults": 200
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.title, item.ownerEmail, item.episodeCount, item.lastEpisodeDate);
}
