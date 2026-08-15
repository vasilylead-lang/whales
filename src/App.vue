<script setup>
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import { whales } from './data/whales.js'
import { zones } from './data/zones.js'
import HeroSurface from './components/HeroSurface.vue'
import ZoneSection from './components/ZoneSection.vue'
import WhaleSong from './components/WhaleSong.vue'
import ConservationSection from './components/ConservationSection.vue'
import DepthMeter from './components/DepthMeter.vue'
import SiteFooter from './components/SiteFooter.vue'
import ConsentBanner from './components/ConsentBanner.vue'

// Deepest depth we map the page scroll onto (m) — the abyssal plain.
const MAX_DEPTH = 6000

const scrollPct = ref(0)

const depth = computed(() => ({
  pct: scrollPct.value,
  metres: Math.round((scrollPct.value / 100) * MAX_DEPTH),
}))

// Group species into their depth zone so each card drops into the right layer.
const whalesByZone = (key) => whales.filter((w) => w.zone === key)

let revealObserver = null

function onScroll() {
  const el = document.scrollingElement || document.documentElement
  const top = window.scrollY || el.scrollTop || 0
  const max = el.scrollHeight - el.clientHeight
  scrollPct.value = max > 0 ? Math.min(100, (top / max) * 100) : 0
}

onMounted(() => {
  onScroll()
  window.addEventListener('scroll', onScroll, { passive: true })
  window.addEventListener('resize', onScroll, { passive: true })

  // Fade + rise sections into view as they enter the viewport.
  const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches
  const targets = document.querySelectorAll('.reveal')

  if (prefersReduced || !('IntersectionObserver' in window)) {
    targets.forEach((el) => el.classList.add('is-visible'))
    return
  }

  revealObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible')
          revealObserver.unobserve(entry.target)
        }
      })
    },
    { threshold: 0.15, rootMargin: '0px 0px -8% 0px' },
  )

  targets.forEach((el) => revealObserver.observe(el))
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', onScroll)
  window.removeEventListener('resize', onScroll)
  revealObserver?.disconnect()
})
</script>

<template>
  <a class="skip-link" href="#sunlight">Skip to whale species</a>

  <DepthMeter :depth="depth" />

  <main>
    <HeroSurface />

    <!-- Sunlight zone: surface-feeding baleen giants -->
    <ZoneSection :zone="zones[0]" :whales="whalesByZone('sunlight')" />

    <!-- Twilight zone: the hunters that follow prey into the gloom -->
    <ZoneSection :zone="zones[1]" :whales="whalesByZone('twilight')" />

    <WhaleSong />

    <!-- Midnight zone: the deepest divers -->
    <ZoneSection :zone="zones[2]" :whales="whalesByZone('midnight')" />

    <!-- The abyss: no cards, just the whale-fall story -->
    <ZoneSection :zone="zones[3]">
      <div class="whale-fall reveal">
        <h3>The whale fall</h3>
        <p>
          Even in death a whale gives life. When a great whale sinks to the abyssal
          floor, its body becomes a “whale fall” — first a feast for scavengers, then a
          reef of bones colonised by worms, crabs and bacteria that can thrive there for
          decades. A single carcass can sustain an entire deep-sea community, the last
          gift of a life lived across every layer of the sea.
        </p>
      </div>
    </ZoneSection>

    <ConservationSection />
  </main>

  <SiteFooter />

  <ConsentBanner />
</template>

<style scoped>
.skip-link {
  position: absolute;
  top: -60px;
  left: 1rem;
  z-index: 100;
  padding: 0.6rem 1rem;
  border-radius: 0 0 10px 10px;
  background: var(--color-glow);
  color: var(--color-abyss);
  font-weight: 700;
  transition: top var(--dur-interactive) var(--ease);
}

.skip-link:focus {
  top: 0;
  color: var(--color-abyss);
}

.whale-fall {
  max-width: 46rem;
  padding: clamp(1.5rem, 4vw, 2.4rem);
  border-radius: var(--radius);
  border: 1px solid var(--color-card-border);
  background: rgba(4, 20, 46, 0.5);
}

.whale-fall h3 {
  color: var(--color-glow);
}
</style>
