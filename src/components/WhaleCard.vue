<script setup>
defineProps({
  whale: {
    type: Object,
    required: true,
  },
})
</script>

<template>
  <article :id="whale.id" class="whale-card reveal">
    <header class="whale-card-head">
      <span class="whale-card-emoji" aria-hidden="true">{{ whale.emoji }}</span>
      <div class="whale-card-title">
        <h3>{{ whale.name }}</h3>
        <p class="whale-card-latin">{{ whale.latin }}</p>
      </div>
      <span
        class="tag"
        :class="whale.group === 'Baleen' ? 'tag--baleen' : 'tag--toothed'"
      >
        {{ whale.group }}
      </span>
    </header>

    <p class="whale-card-tagline">{{ whale.tagline }}</p>

    <dl class="whale-card-stats">
      <div>
        <dt>Length</dt>
        <dd>{{ whale.length }}</dd>
      </div>
      <div>
        <dt>Weight</dt>
        <dd>{{ whale.weight }}</dd>
      </div>
      <div>
        <dt>IUCN status</dt>
        <dd>{{ whale.status }}</dd>
      </div>
    </dl>

    <ul class="whale-card-facts">
      <li v-for="(fact, i) in whale.facts" :key="i">{{ fact }}</li>
    </ul>
  </article>
</template>

<style scoped>
.whale-card {
  background: var(--color-card);
  border: 1px solid var(--color-card-border);
  border-radius: var(--radius);
  padding: clamp(1.25rem, 3vw, 1.9rem);
  backdrop-filter: blur(6px);
  box-shadow: 0 18px 50px -30px rgba(0, 0, 0, 0.9);
  transition:
    transform var(--dur-interactive) var(--ease),
    border-color var(--dur-interactive) var(--ease),
    box-shadow var(--dur-interactive) var(--ease);
}

.whale-card:hover {
  transform: translateY(-4px);
  border-color: var(--color-glow);
  box-shadow: 0 24px 60px -28px rgba(95, 251, 241, 0.35);
}

.whale-card-head {
  display: flex;
  align-items: center;
  gap: 0.85rem;
  margin-bottom: 0.9rem;
}

.whale-card-emoji {
  font-size: 2rem;
  line-height: 1;
  filter: drop-shadow(0 0 10px rgba(95, 251, 241, 0.5));
}

.whale-card-title {
  flex: 1 1 auto;
  min-width: 0;
}

.whale-card-title h3 {
  margin: 0;
}

.whale-card-latin {
  margin: 0.1rem 0 0;
  font-style: italic;
  font-size: 0.9rem;
  color: var(--color-text-dim);
}

.whale-card-tagline {
  color: var(--color-glow-2);
  font-weight: 600;
  margin-bottom: 1.1rem;
}

.whale-card-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.75rem;
  margin: 0 0 1.1rem;
  padding: 0.9rem 0;
  border-top: 1px solid var(--color-hairline);
  border-bottom: 1px solid var(--color-hairline);
}

.whale-card-stats div {
  min-width: 0;
}

.whale-card-stats dt {
  font-size: 0.7rem;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--color-text-dim);
  margin-bottom: 0.2rem;
}

.whale-card-stats dd {
  margin: 0;
  font-weight: 700;
  color: var(--color-foam);
  font-size: 0.92rem;
}

.whale-card-facts {
  margin: 0;
  padding-left: 1.1rem;
  display: grid;
  gap: 0.55rem;
}

.whale-card-facts li {
  color: var(--color-text);
}

.whale-card-facts li::marker {
  color: var(--color-glow);
}

@media (max-width: 760px) {
  .whale-card-stats {
    grid-template-columns: 1fr;
    gap: 0.5rem;
  }
}
</style>
