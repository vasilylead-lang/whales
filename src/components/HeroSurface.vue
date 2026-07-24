<script setup>
// Animated caustics + rising bubbles are pure CSS; the whale silhouette is inline SVG.
</script>

<template>
  <header class="hero" id="top">
    <div class="hero-caustics" aria-hidden="true"></div>
    <div class="hero-bubbles" aria-hidden="true">
      <span v-for="n in 12" :key="n" :style="{ '--i': n }"></span>
    </div>

    <div class="hero-inner content">
      <p class="hero-eyebrow">
        An immersive descent ·
        <a class="hero-eyebrow-link" href="#sunlight">the light side</a>
        ← 0 m → the abyss
      </p>
      <h1>The Whales of the Ocean</h1>
      <p class="hero-lede">
        Take a breath. We’re diving from the sunlit surface to the crushing dark —
        meeting the giants that live at every depth, and the science of how they
        sing, hunt, migrate and survive.
      </p>
      <a class="hero-cta" href="#sunlight">
        Begin the dive
        <span class="hero-cta-arrow" aria-hidden="true">↓</span>
      </a>
    </div>

    <svg
      class="hero-whale"
      viewBox="0 0 640 210"
      role="img"
      aria-label="Silhouette of a sperm whale gliding through the water"
    >
      <!-- A sperm whale, swimming right: the huge block-shaped head (about a third
           of the body), tapering body with low dorsal knuckles on the back third,
           the underslung jaw, and thick triangular tail flukes. -->
      <path
        fill="rgba(2, 12, 30, 0.42)"
        d="M50 96 C 50 76 66 66 100 64 C 150 61 210 62 252 68
           C 322 76 382 80 430 84 C 442 80 452 76 462 82
           C 476 89 486 84 496 88 C 510 93 520 91 530 93
           C 542 95 552 95 560 94 L 614 76 C 604 90 600 98 612 110
           L 618 118 C 596 114 572 110 554 112 C 470 118 380 124 300 125
           C 240 126 168 128 126 124 C 96 121 70 116 58 106
           C 50 98 50 100 50 96 Z"
      />
      <!-- underslung jaw line -->
      <path d="M58 104 C 98 112 142 112 170 107"
            fill="none" stroke="rgba(234, 249, 253, 0.16)" stroke-width="1.5" />
      <circle cx="206" cy="96" r="3.6" fill="rgba(95,251,241,0.5)" />
    </svg>

    <div class="hero-scroll" aria-hidden="true">
      <span></span>
    </div>
  </header>
</template>

<style scoped>
.hero {
  position: relative;
  min-height: 100svh;
  display: grid;
  place-items: center;
  overflow: hidden;
  background:
    radial-gradient(120% 90% at 50% -10%, rgba(126, 232, 250, 0.5), transparent 55%),
    linear-gradient(180deg, var(--color-surface) 0%, var(--color-shallow) 45%, var(--color-sea) 100%);
  isolation: isolate;
}

/* Moving light "caustics" near the surface */
.hero-caustics {
  position: absolute;
  inset: -20% -20% 40% -20%;
  background:
    repeating-linear-gradient(115deg, rgba(255, 255, 255, 0.14) 0 2px, transparent 2px 26px),
    repeating-linear-gradient(65deg, rgba(255, 255, 255, 0.1) 0 2px, transparent 2px 34px);
  mix-blend-mode: soft-light;
  animation: caustics 14s linear infinite;
  z-index: -1;
}

@keyframes caustics {
  from {
    transform: translate3d(0, 0, 0);
  }
  to {
    transform: translate3d(-60px, 40px, 0);
  }
}

.hero-bubbles {
  position: absolute;
  inset: 0;
  z-index: -1;
}

.hero-bubbles span {
  position: absolute;
  bottom: -40px;
  left: calc(var(--i) * 8%);
  width: calc(6px + (var(--i) * 0.7px));
  height: calc(6px + (var(--i) * 0.7px));
  border-radius: 50%;
  background: rgba(234, 249, 253, 0.35);
  box-shadow: inset 0 0 4px rgba(255, 255, 255, 0.7);
  animation: rise calc(9s + var(--i) * 1s) linear infinite;
  animation-delay: calc(var(--i) * -0.8s);
}

@keyframes rise {
  to {
    transform: translateY(-105svh) translateX(20px);
    opacity: 0;
  }
}

.hero-inner {
  text-align: center;
  max-width: 46rem;
  z-index: 1;
  padding-block: 4rem;
}

.hero-eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.22em;
  font-size: 0.78rem;
  font-weight: 700;
  color: var(--color-deep);
  opacity: 0.75;
  margin-bottom: 1rem;
}

.hero-eyebrow-link {
  color: inherit;
  text-decoration: underline;
  text-underline-offset: 3px;
  text-decoration-thickness: 1px;
  transition: color var(--dur-interactive) var(--ease);
}

.hero-eyebrow-link:hover,
.hero-eyebrow-link:focus-visible {
  color: #063056;
}

.hero h1 {
  color: #f4feff;
  text-shadow: 0 6px 30px rgba(4, 20, 46, 0.4);
}

.hero-lede {
  font-size: clamp(1.05rem, 2.2vw, 1.3rem);
  color: #063056;
  max-width: 40rem;
  margin: 1rem auto 2rem;
  font-weight: 500;
}

.hero-cta {
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.85rem 1.8rem;
  border-radius: 999px;
  font-weight: 700;
  color: var(--color-abyss);
  background: linear-gradient(180deg, var(--color-glow), var(--color-accent));
  box-shadow: 0 12px 30px -8px rgba(71, 224, 192, 0.6);
  transition:
    transform var(--dur-interactive) var(--ease),
    box-shadow var(--dur-interactive) var(--ease);
}

.hero-cta:hover,
.hero-cta:focus-visible {
  color: var(--color-abyss);
  transform: translateY(-3px);
  box-shadow: 0 18px 40px -10px rgba(95, 251, 241, 0.7);
}

.hero-cta-arrow {
  animation: nudge 1.6s ease-in-out infinite;
}

@keyframes nudge {
  0%,
  100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(4px);
  }
}

.hero-whale {
  position: absolute;
  bottom: 3%;
  left: 50%;
  width: min(46rem, 78vw);
  transform: translateX(-50%);
  z-index: 0;
  animation: glide 18s ease-in-out infinite;
}

@keyframes glide {
  0%,
  100% {
    transform: translateX(-52%) translateY(0);
  }
  50% {
    transform: translateX(-48%) translateY(-14px);
  }
}

.hero-scroll {
  position: absolute;
  bottom: 1.5rem;
  left: 50%;
  transform: translateX(-50%);
  width: 26px;
  height: 42px;
  border: 2px solid rgba(6, 48, 86, 0.6);
  border-radius: 14px;
  z-index: 1;
}

.hero-scroll span {
  position: absolute;
  top: 8px;
  left: 50%;
  width: 4px;
  height: 8px;
  margin-left: -2px;
  border-radius: 2px;
  background: rgba(6, 48, 86, 0.8);
  animation: scrolldot 1.8s ease-in-out infinite;
}

@keyframes scrolldot {
  0% {
    opacity: 0;
    transform: translateY(0);
  }
  40% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    transform: translateY(14px);
  }
}

@media (prefers-reduced-motion: reduce) {
  .hero-caustics,
  .hero-bubbles span,
  .hero-cta-arrow,
  .hero-whale,
  .hero-scroll span {
    animation: none;
  }
}
</style>
