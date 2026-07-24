<script setup>
import WhaleCard from './WhaleCard.vue'
import WhalePlate from './WhalePlate.vue'

defineProps({
  zone: {
    type: Object,
    required: true,
  },
  whales: {
    type: Array,
    default: () => [],
  },
})
</script>

<template>
  <section :id="zone.key" class="zone" :class="`zone--${zone.key}`">
    <div class="zone-inner content">
      <header class="zone-head reveal">
        <p class="zone-depth">{{ zone.subtitle }}</p>
        <h2>{{ zone.name }}</h2>
        <p class="zone-blurb">{{ zone.blurb }}</p>
      </header>

      <div v-if="whales.length" class="zone-grid">
        <component
          :is="whale.plate ? WhalePlate : WhaleCard"
          v-for="whale in whales"
          :key="whale.id"
          :whale="whale"
        />
      </div>

      <slot />
    </div>
  </section>
</template>

<style scoped>
.zone {
  position: relative;
  padding-block: clamp(4rem, 12vh, 8rem);
}

/* Each zone blends into the next, getting darker with depth */
.zone--sunlight {
  background: linear-gradient(180deg, var(--color-sea) 0%, var(--color-mid) 100%);
}

.zone--twilight {
  background: linear-gradient(180deg, var(--color-mid) 0%, var(--color-deep) 100%);
}

.zone--midnight {
  background: linear-gradient(180deg, var(--color-deep) 0%, var(--color-abyss) 100%);
}

.zone--abyss {
  background: linear-gradient(180deg, var(--color-abyss) 0%, #000 100%);
}

.zone-head {
  max-width: 44rem;
  margin-bottom: clamp(2rem, 5vh, 3.5rem);
}

.zone-depth {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--color-glow);
  margin-bottom: 0.6rem;
}

.zone-blurb {
  font-size: clamp(1.02rem, 2vw, 1.18rem);
  color: var(--color-text);
}

.zone-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(min(100%, 20rem), 1fr));
  gap: clamp(1.1rem, 2.5vw, 1.75rem);
}
</style>
