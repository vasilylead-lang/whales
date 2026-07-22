<script setup>
// A small interactive touch: animated "song" bars that respond to hover/focus.
</script>

<template>
  <section class="song reveal" id="song" aria-labelledby="song-title">
    <div class="song-inner content">
      <div class="song-copy">
        <p class="song-eyebrow">Signals in the dark</p>
        <h2 id="song-title">The ocean is full of voices</h2>
        <p>
          Sound travels almost five times faster in water than in air, so whales live
          in a world of sound. Baleen whales like the blue and fin whale rumble at
          frequencies so low they can carry for hundreds of kilometres. Toothed whales
          click and buzz to <em>echolocate</em> — reading the shape of prey from the
          echoes that return through total darkness.
        </p>
        <p>
          Humpback song is the most elaborate of all: long, repeating phrases that
          change through a season and ripple from one population to the next, like a
          hit spreading across the sea.
        </p>
      </div>

      <div class="song-viz" role="img" aria-label="Animated bars representing whale song frequencies">
        <span v-for="n in 28" :key="n" :style="{ '--i': n }"></span>
      </div>
    </div>
  </section>
</template>

<style scoped>
.song {
  background: linear-gradient(180deg, var(--color-abyss) 0%, var(--color-deep) 100%);
  padding-block: clamp(4rem, 12vh, 8rem);
}

.song-inner {
  display: grid;
  grid-template-columns: 1.1fr 1fr;
  gap: clamp(2rem, 5vw, 4rem);
  align-items: center;
}

.song-eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--color-glow);
  margin-bottom: 0.6rem;
}

.song-copy em {
  color: var(--color-glow-2);
  font-style: normal;
}

.song-viz {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  height: 220px;
  padding: 1.5rem;
  border-radius: var(--radius);
  border: 1px solid var(--color-card-border);
  background: var(--color-card);
}

.song-viz span {
  flex: 1 1 auto;
  min-width: 3px;
  max-width: 10px;
  height: 20%;
  border-radius: 999px;
  background: linear-gradient(180deg, var(--color-glow), var(--color-accent));
  box-shadow: 0 0 8px rgba(95, 251, 241, 0.5);
  animation: sing 1.8s ease-in-out infinite;
  animation-delay: calc(var(--i) * -0.09s);
}

@keyframes sing {
  0%,
  100% {
    height: 14%;
    opacity: 0.55;
  }
  50% {
    height: 92%;
    opacity: 1;
  }
}

@media (max-width: 760px) {
  .song-inner {
    grid-template-columns: 1fr;
  }
  .song-viz {
    height: 160px;
  }
}

@media (prefers-reduced-motion: reduce) {
  .song-viz span {
    animation: none;
    height: 50%;
  }
}
</style>
