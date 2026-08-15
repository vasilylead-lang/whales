<script setup>
import { onMounted } from 'vue'
import { useConsent } from '../composables/useConsent.js'

const { isOpen, accept, decline, init } = useConsent()

onMounted(init)
</script>

<template>
  <Transition name="consent">
    <aside
      v-if="isOpen"
      class="consent"
      role="dialog"
      aria-modal="false"
      aria-labelledby="consent-title"
      aria-describedby="consent-body"
    >
      <div class="consent-inner">
        <div class="consent-copy">
          <h2 id="consent-title">Analytics on this site</h2>
          <p id="consent-body">
            We’d like to use Google Analytics to count visits and see which sections
            people read, so we can improve the guide. It sets cookies in your browser
            and is only enabled if you agree. Decline and the site works exactly the
            same — nothing is collected.
            <a href="/privacy.html">Privacy &amp; cookies</a>
          </p>
        </div>

        <div class="consent-actions">
          <button type="button" class="consent-btn consent-btn--ghost" @click="decline">
            Decline
          </button>
          <button type="button" class="consent-btn consent-btn--primary" @click="accept">
            Allow analytics
          </button>
        </div>
      </div>
    </aside>
  </Transition>
</template>

<style scoped>
.consent {
  position: fixed;
  /* Centred with auto margins rather than translateX(-50%), so the enter/leave
     transitions can own `transform` without fighting the centring. */
  left: 0;
  right: 0;
  bottom: clamp(0.75rem, 2vw, 1.25rem);
  margin-inline: auto;
  z-index: 100;
  width: min(58rem, calc(100vw - 1.5rem));
  background: rgba(4, 20, 46, 0.94);
  border: 1px solid var(--color-card-border);
  border-radius: var(--radius);
  box-shadow: 0 24px 70px -24px rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(10px);
}

.consent-inner {
  display: flex;
  align-items: center;
  gap: clamp(1rem, 3vw, 2rem);
  padding: clamp(1rem, 2.5vw, 1.4rem);
}

.consent-copy h2 {
  font-size: 1rem;
  margin: 0 0 0.3rem;
  color: var(--color-foam);
}

.consent-copy p {
  margin: 0;
  font-size: 0.92rem;
  line-height: 1.55;
  color: var(--color-text);
}

.consent-copy a {
  white-space: nowrap;
  font-weight: 600;
}

.consent-actions {
  display: flex;
  gap: 0.6rem;
  flex: 0 0 auto;
}

.consent-btn {
  font: inherit;
  font-size: 0.92rem;
  font-weight: 700;
  padding: 0.6rem 1.15rem;
  border-radius: 999px;
  cursor: pointer;
  white-space: nowrap;
  transition:
    transform var(--dur-interactive) var(--ease),
    background-color var(--dur-interactive) var(--ease),
    border-color var(--dur-interactive) var(--ease);
}

.consent-btn--primary {
  border: 1px solid transparent;
  color: var(--color-abyss);
  background: linear-gradient(180deg, var(--color-glow), var(--color-accent));
}

.consent-btn--ghost {
  border: 1px solid var(--color-card-border);
  color: var(--color-text);
  background: transparent;
}

.consent-btn:hover {
  transform: translateY(-2px);
}

.consent-btn--ghost:hover {
  border-color: var(--color-glow);
  color: var(--color-foam);
}

.consent-enter-active,
.consent-leave-active {
  transition:
    opacity var(--dur-interactive) var(--ease),
    transform var(--dur-interactive) var(--ease);
}

.consent-enter-from,
.consent-leave-to {
  opacity: 0;
  transform: translateY(12px);
}

@media (max-width: 760px) {
  .consent-inner {
    flex-direction: column;
    align-items: stretch;
    gap: 0.9rem;
  }

  .consent-actions {
    flex-direction: row-reverse;
  }

  .consent-btn {
    flex: 1 1 auto;
  }
}

@media (prefers-reduced-motion: reduce) {
  .consent-enter-active,
  .consent-leave-active,
  .consent-btn {
    transition: none;
  }

  .consent-btn:hover {
    transform: none;
  }
}
</style>
