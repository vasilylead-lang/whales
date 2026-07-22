<script setup>
const stats = [
  { value: '~3 M', label: 'whales killed by industrial whaling in the 20th century' },
  { value: '340', label: 'North Atlantic right whales estimated to remain' },
  { value: '#1', label: 'threats today: ship strikes & fishing-gear entanglement' },
  { value: '1986', label: 'the year a global commercial-whaling moratorium began' },
]

const actions = [
  'Whales are climate allies — each great whale stores tonnes of carbon and fertilises the plankton that produce much of our oxygen.',
  'Slower shipping lanes and "whale-safe" fishing gear dramatically cut deadly collisions and entanglements.',
  'Protected areas and international agreements have helped humpback and grey whale populations recover strongly.',
]
</script>

<template>
  <section class="cons reveal" id="conservation" aria-labelledby="cons-title">
    <div class="cons-inner content">
      <header class="cons-head">
        <p class="cons-eyebrow">Why it matters</p>
        <h2 id="cons-title">Bringing the giants back</h2>
        <p class="cons-lede">
          A century of industrial whaling pushed many species to the brink. Some have
          recovered remarkably; others are still perilously close to the edge. Their
          fate is tied to ours — healthy whale populations mean a healthier ocean.
        </p>
      </header>

      <ul class="cons-stats">
        <li v-for="stat in stats" :key="stat.label">
          <strong>{{ stat.value }}</strong>
          <span>{{ stat.label }}</span>
        </li>
      </ul>

      <ul class="cons-actions">
        <li v-for="(action, i) in actions" :key="i">{{ action }}</li>
      </ul>
    </div>
  </section>
</template>

<style scoped>
.cons {
  background: linear-gradient(180deg, var(--color-deep) 0%, var(--color-abyss) 100%);
  padding-block: clamp(4rem, 12vh, 8rem);
}

.cons-head {
  max-width: 46rem;
  margin-bottom: clamp(2rem, 5vh, 3.5rem);
}

.cons-eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--color-glow);
  margin-bottom: 0.6rem;
}

.cons-lede {
  font-size: clamp(1.02rem, 2vw, 1.18rem);
}

.cons-stats {
  list-style: none;
  margin: 0 0 clamp(2rem, 5vh, 3rem);
  padding: 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(min(100%, 12rem), 1fr));
  gap: 1rem;
}

.cons-stats li {
  padding: 1.4rem;
  border-radius: var(--radius);
  border: 1px solid var(--color-card-border);
  background: var(--color-card);
}

.cons-stats strong {
  display: block;
  font-size: clamp(1.8rem, 4vw, 2.6rem);
  font-weight: 800;
  color: var(--color-glow);
  line-height: 1;
  margin-bottom: 0.5rem;
}

.cons-stats span {
  color: var(--color-text-dim);
  font-size: 0.92rem;
}

.cons-actions {
  margin: 0;
  padding-left: 1.2rem;
  display: grid;
  gap: 0.9rem;
  max-width: 52rem;
}

.cons-actions li {
  color: var(--color-text);
  font-size: 1.02rem;
}

.cons-actions li::marker {
  color: var(--color-accent);
}
</style>
