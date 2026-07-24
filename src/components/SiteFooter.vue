<script setup>
const year = new Date().getFullYear()
</script>

<template>
  <footer class="footer" id="abyss-floor">
    <div class="footer-inner content">
      <p class="footer-mark">🐋 Deep Dive</p>
      <p class="footer-tagline">
        We surface here. Thanks for descending all the way to the ocean floor.
      </p>

      <nav class="footer-nav" aria-label="Jump to a depth zone">
        <a href="#top">Surface</a>
        <a href="#sunlight">Sunlight Zone</a>
        <a href="#twilight">Twilight Zone</a>
        <a href="#midnight">Midnight Zone</a>
        <a href="#conservation">Conservation</a>
      </nav>

      <p class="footer-note">
        An educational, non-commercial project. Facts summarised from public marine-science
        references including
        <a href="https://www.fisheries.noaa.gov/" target="_blank" rel="noreferrer">NOAA Fisheries</a>
        and the
        <a href="https://www.iucnredlist.org/" target="_blank" rel="noreferrer">IUCN Red List</a>.
      </p>
      <p class="footer-copy">© {{ year }} Deep Dive</p>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  background: #000;
  padding-block: clamp(3.5rem, 9vh, 6rem);
  border-top: 1px solid var(--color-hairline);
  text-align: center;
}

.footer-mark {
  font-size: 1.4rem;
  font-weight: 800;
  color: var(--color-foam);
  margin-bottom: 0.4rem;
}

.footer-tagline {
  color: var(--color-text-dim);
  max-width: 32rem;
  margin-inline: auto;
}

.footer-nav {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.4rem 1.4rem;
  margin: 1.6rem 0;
}

.footer-nav a {
  font-weight: 600;
  color: var(--color-glow-2);
}

.footer-note {
  font-size: 0.88rem;
  color: var(--color-text-dim);
  max-width: 40rem;
  margin: 0 auto 0.8rem;
}

.footer-copy {
  font-size: 0.82rem;
  color: rgba(143, 177, 214, 0.6);
  margin: 0;
}
</style>
