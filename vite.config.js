import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
// Served from the domain root at https://whales-info.life
export default defineConfig({
  base: '/',
  plugins: [vue()],
})
