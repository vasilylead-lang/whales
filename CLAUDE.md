# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

**Deep Dive — The Whales of the Ocean.** An immersive, single-page Vue 3 site (English,
`lang="en"`) structured as one continuous descent: the page scrolls from the sunlit
surface down through the ocean's depth zones (Sunlight → Twilight → Midnight → Abyss),
introducing the whales at each layer, plus sections on song, migration and conservation.
A fixed depth gauge tracks scroll progress and reads out the current "depth" in metres.

## Commands

```bash
npm install     # install dependencies
npm run dev     # Vite dev server → http://localhost:5173
npm run build   # production build → dist/
npm run preview # serve the production build locally
```

There is no linter or test suite configured.

## Stack

- Vue 3 (`<script setup>` SFCs) + Vite 7 (`@vitejs/plugin-vue` v6 — v5 does **not** support Vite 7)
- Hand-written CSS, no framework. Design tokens (deep-ocean palette) live in `src/assets/main.css`

## Architecture

- **Narrative spine = depth zones.** `src/data/zones.js` defines the ocean layers; each
  whale in `src/data/whales.js` has a `zone` key so `App.vue` drops its card into the
  matching `ZoneSection`. To add a species, add an object to `whales.js` — no markup needed.
- **`App.vue`** orchestrates all sections and owns two scroll behaviours: (1) a scroll
  handler that maps page progress to the `DepthMeter` reading (0 → `MAX_DEPTH` metres),
  and (2) an `IntersectionObserver` that adds `.is-visible` to `.reveal` elements for
  fade-in-on-scroll. Both respect `prefers-reduced-motion`.
- **Components** in `src/components/` are presentational: `HeroSurface`, `ZoneSection`
  (wraps a zone + its `WhaleCard`s), `WhaleCard`, `WhaleSong`, `ConservationSection`,
  `DepthMeter`, `SiteFooter`.

### Gotcha: horizontal-overflow clipping

Use `overflow-x: clip` (not `hidden`) on `body`/full-bleed elements. `overflow-x: hidden`
forces `overflow-y` to compute as `auto`, turning the element into a scroll container —
which leaves `document.documentElement.scrollTop` stuck at 0 and breaks the depth meter.

## SEO

Single-page site, so **all** SEO is static in `index.html` (present in served HTML, no
client-only meta): unique title/description, canonical, Open Graph + Twitter cards, and
JSON-LD (`WebSite`, `Organization`, `ItemList` of species, `FAQPage`). `public/robots.txt`
and `public/sitemap.xml` sit at the root.

### Before deploying

1. Replace `https://whales.example.com` with the real domain in `index.html`,
   `public/sitemap.xml`, `public/robots.txt`.
2. Set `base` in `vite.config.js` to match the host path (`'/'` for root, `'/whales/'`
   for a sub-path; currently `'./'` so it works from either).
