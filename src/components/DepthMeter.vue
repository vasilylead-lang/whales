<script setup>
defineProps({
  depth: {
    type: Object,
    required: true,
  },
})
</script>

<template>
  <aside class="depth-meter" aria-hidden="true">
    <div class="depth-meter-track">
      <span class="depth-meter-fill" :style="{ height: `${depth.pct}%` }"></span>
    </div>
    <div class="depth-meter-readout">
      <strong>{{ depth.metres.toLocaleString('en-US') }}</strong>
      <span>m</span>
    </div>
  </aside>
</template>

<style scoped>
.depth-meter {
  position: fixed;
  top: 50%;
  right: clamp(0.6rem, 2vw, 1.4rem);
  transform: translateY(-50%);
  z-index: 50;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.6rem;
  pointer-events: none;
}

.depth-meter-track {
  position: relative;
  width: 6px;
  height: min(48vh, 340px);
  border-radius: 999px;
  background: rgba(143, 177, 214, 0.18);
  overflow: hidden;
}

.depth-meter-fill {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  background: linear-gradient(180deg, var(--color-glow), var(--color-accent));
  box-shadow: 0 0 12px rgba(95, 251, 241, 0.7);
  border-radius: 999px;
  transition: height 120ms linear;
}

.depth-meter-readout {
  font-variant-numeric: tabular-nums;
  text-align: center;
  line-height: 1;
  color: var(--color-glow-2);
}

.depth-meter-readout strong {
  display: block;
  font-size: 1rem;
  color: var(--color-foam);
}

.depth-meter-readout span {
  font-size: 0.7rem;
  letter-spacing: 0.1em;
  color: var(--color-text-dim);
}

@media (max-width: 760px) {
  .depth-meter {
    display: none;
  }
}
</style>
