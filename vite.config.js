import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
// `base` is set to a relative path so the built site works whether it is served
// from a domain root or a sub-path. Swap to '/' (or '/whales/') before deploy.
export default defineConfig({
  base: './',
  plugins: [vue()],
})
