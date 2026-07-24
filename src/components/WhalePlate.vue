<script setup>
// A single species rendered as a vintage naturalist's "specimen plate" —
// a deliberate break from the glassy cards, styled after 19th-century engravings
// (e.g. Richard Lydekker, 1894). Two figures: a shaded body above its skeleton.
//
// Anatomy follows the sperm whale (Physeter macrocephalus): a block-shaped head
// ~1/4–1/3 of the body, a low skull with a long rostrum and concave spermaceti
// basin, a long narrow underslung mandible of conical teeth, a thoracic ribcage in
// the front third, a vertebral column that tapers to a point (the flukes are
// cartilage — no bone), chevron bones under the tail, a finger-boned flipper, and a
// vestigial pelvis. No dorsal fin — just knuckle ridges on the caudal third.

defineProps({
  whale: {
    type: Object,
    required: true,
  },
})

// External silhouette: big blunt head at left → triangular flukes at right.
// Reused for the shaded body (filled) and as the faint skeleton outline.
const BODY =
  'M46 66 C 46 59 58 55 92 54 L 206 55 C 250 56 304 62 360 72 ' +
  'C 398 79 428 80 450 75 C 468 71 484 79 498 84 C 520 90 544 92 566 91 ' +
  'C 574 90 580 88 586 85 L 610 66 C 602 84 598 99 612 115 L 616 123 ' +
  'C 592 119 566 114 540 114 C 462 117 372 121 300 122 C 238 123 170 125 126 121 ' +
  'C 94 118 66 113 56 103 C 50 95 46 80 46 66 Z'

// A few wrinkle strokes behind the head, echoing the species' furrowed skin.
const wrinkles = [246, 268, 290, 312].map((x) => `M${x} 60 q 7 26 -3 54`)

// --- Skeleton, generated so the engraving reads as regular hand-work ---

// Vertebral column: centra shrink and neural spines shorten toward the tail,
// which ends in a point (no bone reaches into the flukes).
const vertebrae = Array.from({ length: 26 }, (_, i) => {
  const t = i / 25
  return {
    x: 236 + t * (560 - 236),
    r: 5 - t * 3.2,
    spine: 30 * (1 - t) ** 1.2 + 4, // neural spine length
  }
})

// Ribcage in the front third, curving down from the thoracic vertebrae.
const ribs = Array.from({ length: 11 }, (_, i) => {
  const t = i / 10
  const x = 242 + t * 118
  const depth = 152 - Math.abs(t - 0.42) * 46
  return `M${x} 99 Q ${x - 32} ${depth - 18} ${x - 12} ${depth}`
})

// Conical teeth along the top edge of the long underslung mandible.
const teeth = Array.from({ length: 20 }, (_, i) => {
  const x = 62 + (i * 126) / 19
  return { x, y: 115 - (x - 52) * 0.05 }
})

// Chevron (haemal) bones hanging beneath the caudal vertebrae.
const chevrons = Array.from({ length: 8 }, (_, i) => 432 + (i * 124) / 7)
</script>

<template>
  <article :id="whale.id" class="plate reveal">
    <div class="plate-frame">
      <p v-if="whale.plateNo" class="plate-no">{{ whale.plateNo }}</p>

      <figure class="plate-figure">
        <svg
          viewBox="0 0 640 344"
          role="img"
          :aria-label="`Engraving of a ${whale.name}: a shaded body above its skeleton`"
        >
          <defs>
            <pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse"
                     patternTransform="rotate(28)">
              <rect width="6" height="6" fill="#4b463b" />
              <line x1="0" y1="0" x2="0" y2="6" stroke="#2b271f" stroke-width="1.4" />
            </pattern>
            <linearGradient id="shade" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0" stop-color="#000" stop-opacity="0.45" />
              <stop offset="0.55" stop-color="#000" stop-opacity="0.1" />
              <stop offset="1" stop-color="#fff" stop-opacity="0.14" />
            </linearGradient>
          </defs>

          <!-- Figure 1: the shaded animal -->
          <g transform="translate(6 4)">
            <path :d="BODY" fill="#3a352c" />
            <path :d="BODY" fill="url(#hatch)" />
            <path :d="BODY" fill="url(#shade)" />
            <path :d="BODY" fill="none" stroke="#241f18" stroke-width="1.4" />
            <!-- underslung mouth line -->
            <path d="M54 104 C 96 112 130 112 152 106" fill="none"
                  stroke="#1c1812" stroke-width="1.2" />
            <!-- furrowed skin behind the head -->
            <path v-for="(d, i) in wrinkles" :key="`w${i}`" :d="d"
                  fill="none" stroke="#efe7d3" stroke-width="1" opacity="0.13" />
            <!-- S-shaped blowhole at the front-left of the head, and eye -->
            <path d="M50 58 q 4 -3 7 1 q -3 3 1 6" fill="none"
                  stroke="#efe7d3" stroke-width="1.1" opacity="0.7" />
            <circle cx="206" cy="94" r="2.6" fill="#efe7d3" />
          </g>

          <!-- Figure 2: the skeleton -->
          <g transform="translate(6 176)" fill="none" stroke="#241f18">
            <path :d="BODY" stroke-width="1.2" stroke-dasharray="2 3" opacity="0.4" />

            <!-- skull: braincase + long rostrum, with the concave spermaceti basin -->
            <path
              d="M48 99 C 92 94 140 93 172 93 C 184 84 190 74 200 72
                 C 210 70 217 78 217 90 C 217 100 213 107 203 108
                 C 190 109 176 107 168 106 C 130 106 86 106 54 105
                 C 50 103 48 101 48 99 Z"
              fill="#efe7d3" stroke-width="1.6"
            />
            <path d="M190 72 Q 203 84 216 74" stroke-width="1.2" opacity="0.8" />
            <circle cx="196" cy="92" r="3.6" fill="#efe7d3" stroke-width="1.2" />

            <!-- long narrow underslung mandible + conical teeth -->
            <path d="M205 108 C 150 118 98 120 52 116 L 52 120 C 98 124 152 124 205 114 Z"
                  fill="#efe7d3" stroke-width="1.5" />
            <path v-for="(t, i) in teeth" :key="`t${i}`"
                  :d="`M${t.x - 1.8} ${t.y} L ${t.x} ${t.y - 7} L ${t.x + 1.8} ${t.y} Z`"
                  fill="#241f18" stroke="none" />

            <!-- fused cervical block behind the skull -->
            <path d="M218 85 L234 85 L234 101 L218 101 Z" fill="#efe7d3" stroke-width="1.3" />
            <line x1="223" y1="85" x2="223" y2="101" stroke-width="1" />
            <line x1="228" y1="85" x2="228" y2="101" stroke-width="1" />

            <!-- vertebral column: centrum + neural spine (tapering to a point) -->
            <g v-for="(v, i) in vertebrae" :key="`v${i}`">
              <line :x1="v.x" :y1="90" :x2="v.x - v.spine * 0.16" :y2="90 - v.spine"
                    stroke-width="1.3" />
              <circle :cx="v.x" :cy="94" :r="v.r" fill="#efe7d3" stroke-width="1.2" />
            </g>

            <!-- thoracic ribcage in the front third -->
            <path v-for="(d, i) in ribs" :key="`r${i}`" :d="d" stroke-width="1.3" />

            <!-- chevron (haemal) bones beneath the tail -->
            <path v-for="(x, i) in chevrons" :key="`c${i}`"
                  :d="`M${x - 4} 99 L ${x} 112 L ${x + 4} 99`" stroke-width="1.2" />

            <!-- flipper: humerus, forearm and finger bones -->
            <g>
              <path d="M222 104 C 214 122 217 141 230 151 C 239 142 242 123 237 106 Z"
                    fill="#efe7d3" stroke-width="1.3" />
              <line x1="226" y1="116" x2="223" y2="146" stroke-width="1" />
              <line x1="230" y1="116" x2="230" y2="149" stroke-width="1" />
              <line x1="234" y1="116" x2="236" y2="146" stroke-width="1" />
            </g>

            <!-- vestigial pelvic bones, floating free below the spine -->
            <path d="M360 118 q 12 3 18 9" stroke-width="1.6" />
            <path d="M366 124 q 10 2 15 7" stroke-width="1.3" opacity="0.8" />
          </g>
        </svg>
        <figcaption>
          <em>{{ whale.latin }}.</em> Specimen plate, after R. Lydekker, 1894.
        </figcaption>
      </figure>

      <hr class="plate-rule" />

      <header class="plate-head">
        <h3>{{ whale.name }}</h3>
        <span class="plate-order">{{ whale.group === 'Baleen' ? 'Mysticeti' : 'Odontoceti' }}</span>
      </header>
      <p class="plate-tagline">{{ whale.tagline }}</p>

      <dl class="plate-stats">
        <div><dt>Length</dt><dd>{{ whale.length }}</dd></div>
        <div><dt>Mass</dt><dd>{{ whale.weight }}</dd></div>
        <div><dt>Status</dt><dd>{{ whale.status }}</dd></div>
      </dl>

      <ul class="plate-facts">
        <li v-for="(fact, i) in whale.facts" :key="i">{{ fact }}</li>
      </ul>
    </div>
  </article>
</template>

<style scoped>
.plate {
  /* Local, intentionally-not-the-ocean palette: aged paper + sepia ink. */
  --ink: #2a2620;
  --ink-soft: #6a6152;
  --paper: #efe7d3;
  --paper-edge: #ddceac;
  --line: #b9a682;

  grid-column: 1 / -1;
  color: var(--ink);
  font-family: "Iowan Old Style", "Palatino Linotype", "Book Antiqua", Palatino, Georgia, serif;
  background: radial-gradient(120% 120% at 50% 0%, var(--paper) 0%, var(--paper-edge) 100%);
  border-radius: 6px;
  padding: clamp(0.5rem, 1.5vw, 0.85rem);
  box-shadow:
    0 22px 60px -28px rgba(0, 0, 0, 0.85),
    inset 0 0 0 1px rgba(0, 0, 0, 0.08);
  /* subtle paper grain */
  background-image:
    radial-gradient(120% 120% at 50% 0%, var(--paper) 0%, var(--paper-edge) 100%),
    url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='120' height='120'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2'/%3E%3C/filter%3E%3Crect width='120' height='120' filter='url(%23n)' opacity='0.05'/%3E%3C/svg%3E");
}

.plate-frame {
  border: 1px solid var(--ink);
  box-shadow: inset 0 0 0 3px var(--paper), inset 0 0 0 4px var(--line);
  border-radius: 3px;
  padding: clamp(1.1rem, 3vw, 1.9rem);
  position: relative;
}

.plate-no {
  position: absolute;
  top: 0.7rem;
  right: 1rem;
  margin: 0;
  font-size: 0.72rem;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--ink-soft);
}

.plate-figure {
  margin: 0 0 0.4rem;
}

.plate-figure svg {
  width: 100%;
  height: auto;
  display: block;
}

.plate-figure figcaption {
  text-align: center;
  font-size: 0.86rem;
  color: var(--ink-soft);
  margin-top: 0.4rem;
}

.plate-figure figcaption em {
  color: var(--ink);
}

.plate-rule {
  border: 0;
  border-top: 1px solid var(--line);
  margin: 1.1rem 0 0.9rem;
}

.plate-head {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 1rem;
  flex-wrap: wrap;
}

.plate-head h3 {
  font-family: inherit;
  color: var(--ink);
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  margin: 0;
}

.plate-order {
  font-style: italic;
  font-size: 0.9rem;
  color: var(--ink-soft);
}

.plate-tagline {
  font-style: italic;
  font-size: 1.05rem;
  margin: 0.4rem 0 1.1rem;
}

.plate-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.75rem;
  margin: 0 0 1.1rem;
  padding: 0.85rem 0;
  border-top: 1px solid var(--line);
  border-bottom: 1px solid var(--line);
}

.plate-stats dt {
  font-size: 0.68rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  color: var(--ink-soft);
  margin-bottom: 0.2rem;
}

.plate-stats dd {
  margin: 0;
  font-weight: 700;
  font-size: 0.98rem;
}

.plate-facts {
  margin: 0;
  padding-left: 1.1rem;
  display: grid;
  gap: 0.55rem;
}

.plate-facts li::marker {
  color: var(--ink-soft);
}

@media (max-width: 760px) {
  .plate-stats {
    grid-template-columns: 1fr;
    gap: 0.5rem;
  }
}
</style>
