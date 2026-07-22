# Deep Dive — The Whales of the Ocean

An immersive, single-page guide to the whales of the ocean, built with **Vue 3 + Vite**.
The page is one continuous descent: it scrolls from the sunlit surface down through the
ocean's depth zones — Sunlight → Twilight → Midnight → the Abyss — introducing the whales
that live at each layer, plus sections on whale song, migration and conservation. A fixed
depth gauge tracks how deep you've scrolled.

## Stack

- Vue 3 (`^3.5`, `<script setup>` SFCs)
- Vite 7 build tooling (`@vitejs/plugin-vue`)
- No CSS framework — hand-written CSS with design tokens in `src/assets/main.css`

## Commands

```bash
npm install     # install dependencies
npm run dev     # start the Vite dev server (http://localhost:5173)
npm run build   # production build → dist/
npm run preview # preview the production build locally
```

## Project structure

```
index.html                     # Served HTML — all SEO/meta + JSON-LD live here
vite.config.js                 # base: './' so it works from root or a sub-path
public/
  robots.txt, sitemap.xml      # absolute URLs — update the domain before deploy
  favicon.svg, og-image.svg    # icon + social share image
src/
  main.js                      # app entry, imports global CSS
  App.vue                      # orchestrates sections; scroll-depth + reveal logic
  assets/main.css              # design tokens (deep-ocean palette) + base styles
  data/
    whales.js                  # species data (facts, size, IUCN status)
    zones.js                   # ocean depth zones (the narrative spine)
  components/
    HeroSurface.vue            # animated surface hero
    ZoneSection.vue            # a depth zone + its whale cards
    WhaleCard.vue              # one species card
    WhaleSong.vue              # "signals in the dark" feature section
    ConservationSection.vue    # conservation stats + actions
    DepthMeter.vue             # fixed depth gauge (fed by scroll progress)
    SiteFooter.vue             # footer + in-page nav
```

## SEO

Because this is a single-page site, all SEO meta is static and lives directly in
`index.html`, so it is present in the served HTML (no client-only meta): unique
`<title>` + description, canonical URL, Open Graph + Twitter cards, and JSON-LD
(`WebSite`, `Organization`, an `ItemList` of species, and a `FAQPage`). `robots.txt`
and `sitemap.xml` sit at the site root.

### Before deploying

1. Replace `https://whales.example.com` with the real production domain in:
   `index.html`, `public/sitemap.xml`, `public/robots.txt`.
2. In `vite.config.js`, set `base` to match where the site is hosted (`'/'` for a
   domain root, or e.g. `'/whales/'` for a sub-path).
3. (Optional) Swap `public/og-image.svg` for a raster (1200×630 PNG/JPG) if a target
   platform doesn't render SVG social previews, and update the `og:image` URLs.

## Content note

Whale facts are summarised from public marine-science references (NOAA Fisheries, the
IUCN Red List). This is an educational, non-commercial project.
