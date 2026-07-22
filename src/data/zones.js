// The ocean's vertical layers, used as the narrative spine of the dive.
// `top`/`bottom` are the depths in metres each zone spans; `key` matches the
// `zone` field on whale species so cards drop into the right layer.

export const zones = [
  {
    key: 'sunlight',
    name: 'The Sunlight Zone',
    subtitle: 'Epipelagic · 0–200 m',
    top: 0,
    bottom: 200,
    blurb:
      'Sunlight reaches down about 200 metres. Almost all the ocean’s plant life and most of its whales feed in this bright, productive band — where blooms of plankton fuel swarms of krill and shoals of fish.',
  },
  {
    key: 'twilight',
    name: 'The Twilight Zone',
    subtitle: 'Mesopelagic · 200–1,000 m',
    top: 200,
    bottom: 1000,
    blurb:
      'Below 200 metres the light fades to a deep blue gloom and then to black. Here the daily "vertical migration" of billions of small animals draws hunters down after them — and the first flickers of bioluminescence appear.',
  },
  {
    key: 'midnight',
    name: 'The Midnight Zone',
    subtitle: 'Bathypelagic · 1,000–4,000 m',
    top: 1000,
    bottom: 4000,
    blurb:
      'No sunlight ever reaches this far. The water is near-freezing and the pressure is crushing, yet the greatest of the deep-diving whales come here on a single breath to hunt squid in absolute darkness.',
  },
  {
    key: 'abyss',
    name: 'The Abyss',
    subtitle: 'Abyssopelagic · 4,000 m and below',
    top: 4000,
    bottom: 6000,
    blurb:
      'Beyond the reach of even the deepest divers lies the abyssal plain. When a great whale dies and sinks here, its body becomes a "whale fall" — an oasis that feeds a whole community of deep-sea life for decades.',
  },
]
