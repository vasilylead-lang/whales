import { ref } from 'vue'

// Analytics consent, shared across components (module-level refs = one instance).
// The stored value is read in index.html too, before gtag.js loads — keep the
// key and the 'granted' / 'denied' values in sync with that inline script.

const STORAGE_KEY = 'dd-analytics-consent'

const choice = ref(null) // 'granted' | 'denied' | null (undecided)
const isOpen = ref(false)

function readStored() {
  try {
    const v = localStorage.getItem(STORAGE_KEY)
    return v === 'granted' || v === 'denied' ? v : null
  } catch {
    return null // storage blocked (private mode, cookie settings) — treat as undecided
  }
}

function writeStored(value) {
  try {
    localStorage.setItem(STORAGE_KEY, value)
  } catch {
    /* nothing to do — the choice still applies for this page view */
  }
}

function updateGtag(value) {
  if (typeof window.gtag === 'function') {
    window.gtag('consent', 'update', { analytics_storage: value })
  }
}

function set(value) {
  choice.value = value
  writeStored(value)
  updateGtag(value)
  isOpen.value = false
}

export function useConsent() {
  return {
    choice,
    isOpen,
    // Show the banner only to visitors who have not decided yet.
    init() {
      choice.value = readStored()
      isOpen.value = choice.value === null
    },
    accept: () => set('granted'),
    decline: () => set('denied'),
    // Let visitors change their mind later (footer link).
    reopen: () => {
      isOpen.value = true
    },
  }
}
